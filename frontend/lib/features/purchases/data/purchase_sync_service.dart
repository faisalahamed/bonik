import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/app_time.dart';
import '../application/cash_purchase_draft_controller.dart';
import 'category_sync_service.dart';
import 'supplier_sync_service.dart';

final purchaseSyncServiceProvider = Provider<PurchaseSyncService>((ref) {
  return PurchaseSyncService(
    database: ref.watch(appDatabaseProvider),
    apiClient: const ApiClient(),
    categorySyncService: ref.watch(categorySyncServiceProvider),
    supplierSyncService: ref.watch(supplierSyncServiceProvider),
  );
});

class PurchaseSyncService {
  const PurchaseSyncService({
    required this.database,
    required this.apiClient,
    required this.categorySyncService,
    required this.supplierSyncService,
  });

  final AppDatabase database;
  final ApiClient apiClient;
  final CategorySyncService categorySyncService;
  final SupplierSyncService supplierSyncService;

  Future<void> syncPurchases() async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    await syncPendingPurchases(shopId: currentUser.shopId);
    await _pullCurrentShop(currentUser.shopId);
  }

  Future<String> saveDraftLocally(CashPurchaseDraftState draft) async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      throw StateError('No current user found.');
    }
    if (draft.supplierId == null || draft.supplierId!.isEmpty) {
      throw StateError('সাপ্লায়ার নির্বাচন করুন।');
    }
    if (draft.selectedLines.isEmpty) {
      throw StateError('কোনো পণ্য নির্বাচন করা হয়নি।');
    }

    final invalidLine = draft.selectedLines.any(
      (line) =>
          line.quantityValue <= 0 ||
          line.buyingPriceValue <= 0 ||
          line.sellingPriceValue <= 0,
    );
    if (invalidLine) {
      throw StateError('সব পণ্যের পরিমাণ, ক্রয় মূল্য এবং বিক্রয় মূল্য দিন।');
    }

    final now = AppTime.nowUtc();
    final purchaseDate = AppTime.toUtc(draft.purchaseDate);
    final purchaseId = const Uuid().v4();
    final paidAmount = _paidAmountForDraft(draft);
    final paymentId = paidAmount > 0 ? const Uuid().v4() : null;
    final status = paidAmount >= draft.purchaseTotal ? 'completed' : 'pending';

    await database.insertPurchaseBundle(
      purchase: LocalPurchasesCompanion(
        id: Value(purchaseId),
        shopId: Value(currentUser.shopId),
        supplierId: Value(draft.supplierId!),
        total: Value(draft.purchaseTotal),
        otherCharge: const Value(0),
        description: Value(_nullableTrimmed(draft.comment)),
        status: Value(status),
        createdAt: Value(purchaseDate),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
      items: [
        for (final line in draft.selectedLines)
          LocalPurchaseItemsCompanion(
            id: Value(const Uuid().v4()),
            shopId: Value(currentUser.shopId),
            purchaseId: Value(purchaseId),
            categoryId: Value(line.category.id),
            productName: Value(line.category.name),
            buyingPrice: Value(line.buyingPriceValue),
            estSellingPrice: Value(line.sellingPriceValue),
            quantity: Value(line.quantityValue.round()),
            barcode: Value(_nullableString(line.barcode)),
            description: Value(line.category.details),
            createdAt: Value(purchaseDate),
            updatedAt: Value(now),
            syncStatus: const Value('pending'),
          ),
      ],
      payment: paidAmount > 0
          ? LocalPurchasePaymentsCompanion(
              id: Value(paymentId!),
              shopId: Value(currentUser.shopId),
              purchaseId: Value(purchaseId),
              payments: Value(paidAmount),
              description: Value(_paymentDescription(draft.paymentMethod)),
              createdAt: Value(purchaseDate),
              updatedAt: Value(now),
              syncStatus: const Value('pending'),
            )
          : null,
      cashTransaction: paidAmount > 0
          ? LocalCashTransactionsCompanion(
              id: Value(const Uuid().v4()),
              shopId: Value(currentUser.shopId),
              type: const Value('purchase_payment'),
              direction: const Value('out'),
              amount: Value(paidAmount),
              referenceId: Value(purchaseId),
              referenceType: const Value('purchase'),
              method: Value(
                _paymentMethodForCashTransaction(draft.paymentMethod),
              ),
              note: Value(_paymentDescription(draft.paymentMethod)),
              createdAt: Value(purchaseDate),
              updatedAt: Value(now),
              syncStatus: const Value('pending'),
            )
          : null,
    );

    return purchaseId;
  }

  Future<void> syncPendingPurchases({String? shopId}) async {
    final bundles = await database.getPendingPurchaseBundles(shopId: shopId);
    await _ensurePendingPurchaseCategoriesAreSynced(bundles);
    await _ensurePendingPurchaseSuppliersAreSynced(bundles);

    for (final bundle in bundles) {
      await apiClient.postJson('/purchases', body: _bundleToJson(bundle));
      await database.markPurchaseBundleSynced(bundle.purchase.id);
    }
  }

  Future<void> _ensurePendingPurchaseCategoriesAreSynced(
    List<LocalPurchaseBundle> bundles,
  ) async {
    final categoryItems = <String, LocalPurchaseItem>{};
    for (final item in bundles.expand((bundle) => bundle.items)) {
      final categoryId = item.categoryId;
      if (categoryId != null) {
        categoryItems[categoryId] = item;
      }
    }

    if (categoryItems.isEmpty) {
      return;
    }

    for (final entry in categoryItems.entries) {
      final categoryId = entry.key;
      final category = await database.getCategoryById(categoryId);
      if (category == null) {
        await database.ensurePendingProductCategory(
          id: categoryId,
          shopId: entry.value.shopId,
          name: entry.value.productName,
        );
        continue;
      }

      await database.markCategoryPending(categoryId);
    }

    await categorySyncService.syncProductCategories();
  }

  Future<void> _ensurePendingPurchaseSuppliersAreSynced(
    List<LocalPurchaseBundle> bundles,
  ) async {
    final supplierPurchases = <String, LocalPurchase>{};
    for (final bundle in bundles) {
      supplierPurchases[bundle.purchase.supplierId] = bundle.purchase;
    }

    if (supplierPurchases.isEmpty) {
      return;
    }

    for (final entry in supplierPurchases.entries) {
      final supplierId = entry.key;
      final supplier = await database.getSupplierById(supplierId);
      if (supplier == null) {
        await database.ensurePendingSupplier(
          id: supplierId,
          shopId: entry.value.shopId,
        );
        continue;
      }

      await database.markSupplierPending(supplierId);
    }

    await supplierSyncService.syncSuppliers();
  }

  Future<void> _pullCurrentShop(String shopId) async {
    final response = await apiClient.getJson(
      '/purchases',
      queryParameters: {'shop_id': shopId},
    );

    final rawPurchases = response['purchases'];
    if (rawPurchases is! List) {
      return;
    }
    final rawCashTransactions = response['cash_transactions'];
    final cashTransactionsByPurchaseId = <String, List<Map<String, dynamic>>>{};
    if (rawCashTransactions is List) {
      for (final row in rawCashTransactions.whereType<Map<String, dynamic>>()) {
        final purchaseId = row['reference_id']?.toString();
        if (purchaseId == null || purchaseId.isEmpty) {
          continue;
        }
        cashTransactionsByPurchaseId
            .putIfAbsent(purchaseId, () => <Map<String, dynamic>>[])
            .add(row);
      }
    }

    await database.upsertSyncedPurchaseBundles(
      rawPurchases
          .whereType<Map<String, dynamic>>()
          .map(
            (purchase) => _bundleFromJson({
              ...purchase,
              'cash_transactions':
                  cashTransactionsByPurchaseId[purchase['id']?.toString()],
            }),
          )
          .toList(),
    );
  }

  Map<String, dynamic> _bundleToJson(LocalPurchaseBundle bundle) {
    return {
      'purchase': {
        'id': bundle.purchase.id,
        'shop_id': bundle.purchase.shopId,
        'supplier_id': bundle.purchase.supplierId,
        'total': bundle.purchase.total,
        'other_charge': bundle.purchase.otherCharge,
        'description': bundle.purchase.description,
        'buying_memo_url': bundle.purchase.buyingMemoUrl,
        'status': bundle.purchase.status,
        'created_at': AppTime.isoUtc(bundle.purchase.createdAt),
        'updated_at': AppTime.isoUtc(bundle.purchase.updatedAt),
      },
      'items': [
        for (final item in bundle.items)
          {
            'id': item.id,
            'shop_id': item.shopId,
            'purchase_id': item.purchaseId,
            'category_id': item.categoryId,
            'product_name': item.productName,
            'buying_price': item.buyingPrice,
            'est_selling_price': item.estSellingPrice,
            'quantity': item.quantity,
            'barcode': item.barcode,
            'other_charge': item.otherCharge,
            'description': item.description,
            'product_image': item.productImage,
            'created_at': AppTime.isoUtc(item.createdAt),
            'updated_at': AppTime.isoUtc(item.updatedAt),
          },
      ],
      'payments': [
        for (final payment in bundle.payments)
          {
            'id': payment.id,
            'shop_id': payment.shopId,
            'purchase_id': payment.purchaseId,
            'payments': payment.payments,
            'description': payment.description,
            'created_at': AppTime.isoUtc(payment.createdAt),
            'updated_at': AppTime.isoUtc(payment.updatedAt),
          },
      ],
      'cash_transactions': [
        for (final transaction in bundle.cashTransactions)
          {
            'id': transaction.id,
            'shop_id': transaction.shopId,
            'type': transaction.type,
            'direction': transaction.direction,
            'amount': transaction.amount,
            'reference_id': transaction.referenceId,
            'reference_type': transaction.referenceType,
            'method': transaction.method,
            'note': transaction.note,
            'created_at': AppTime.isoUtc(transaction.createdAt),
            'updated_at': AppTime.isoUtc(transaction.updatedAt),
          },
      ],
    };
  }

  LocalPurchaseBundleCompanion _bundleFromJson(Map<String, dynamic> json) {
    final purchaseId = json['id'].toString();
    final rawItems = json['items'];
    final rawPayments = json['payments'];
    final rawCashTransactions = json['cash_transactions'];

    return LocalPurchaseBundleCompanion(
      purchase: LocalPurchasesCompanion(
        id: Value(purchaseId),
        shopId: Value(json['shop_id'].toString()),
        supplierId: Value(json['supplier_id'].toString()),
        total: Value(_double(json['total'])),
        otherCharge: Value(_double(json['other_charge'])),
        description: Value(_nullableString(json['description'])),
        buyingMemoUrl: Value(_nullableString(json['buying_memo_url'])),
        status: Value(json['status']?.toString() ?? 'pending'),
        createdAt: Value(_dateTime(json['created_at'])),
        updatedAt: Value(_dateTime(json['updated_at'])),
        syncStatus: const Value('synced'),
      ),
      items: [
        if (rawItems is List)
          for (final item in rawItems.whereType<Map<String, dynamic>>())
            LocalPurchaseItemsCompanion(
              id: Value(item['id'].toString()),
              shopId: Value(item['shop_id'].toString()),
              purchaseId: Value(item['purchase_id']?.toString() ?? purchaseId),
              categoryId: Value(_nullableString(item['category_id'])),
              productName: Value(item['product_name'].toString()),
              buyingPrice: Value(_double(item['buying_price'])),
              estSellingPrice: Value(
                _nullableDouble(item['est_selling_price']),
              ),
              quantity: Value(_int(item['quantity'])),
              barcode: Value(_nullableString(item['barcode'])),
              otherCharge: Value(_double(item['other_charge'])),
              description: Value(_nullableString(item['description'])),
              productImage: Value(_nullableString(item['product_image'])),
              createdAt: Value(_dateTime(item['created_at'])),
              updatedAt: Value(_dateTime(item['updated_at'])),
              syncStatus: const Value('synced'),
            ),
      ],
      payments: [
        if (rawPayments is List)
          for (final payment in rawPayments.whereType<Map<String, dynamic>>())
            LocalPurchasePaymentsCompanion(
              id: Value(payment['id'].toString()),
              shopId: Value(payment['shop_id'].toString()),
              purchaseId: Value(
                payment['purchase_id']?.toString() ?? purchaseId,
              ),
              payments: Value(_double(payment['payments'])),
              description: Value(_nullableString(payment['description'])),
              createdAt: Value(_dateTime(payment['created_at'])),
              updatedAt: Value(_dateTime(payment['updated_at'])),
              syncStatus: const Value('synced'),
            ),
      ],
      cashTransactions: [
        if (rawCashTransactions is List)
          for (final transaction
              in rawCashTransactions.whereType<Map<String, dynamic>>())
            LocalCashTransactionsCompanion(
              id: Value(transaction['id'].toString()),
              shopId: Value(transaction['shop_id'].toString()),
              type: Value(
                transaction['type']?.toString() ?? 'purchase_payment',
              ),
              direction: Value(transaction['direction']?.toString() ?? 'out'),
              amount: Value(_double(transaction['amount'])),
              referenceId: Value(_nullableString(transaction['reference_id'])),
              referenceType: Value(
                _nullableString(transaction['reference_type']) ?? 'purchase',
              ),
              method: Value(_nullableString(transaction['method'])),
              note: Value(_nullableString(transaction['note'])),
              createdAt: Value(_dateTime(transaction['created_at'])),
              updatedAt: Value(_dateTime(transaction['updated_at'])),
              syncStatus: const Value('synced'),
            ),
      ],
    );
  }

  double _paidAmountForDraft(CashPurchaseDraftState draft) {
    return switch (draft.paymentMethod) {
      'due' => 0,
      'partial' => double.tryParse(draft.paidAmount.trim()) ?? 0,
      _ => draft.purchaseTotal,
    };
  }

  String _paymentDescription(String paymentMethod) {
    return switch (paymentMethod) {
      'cash' => 'নগদ টাকা',
      'online' => 'BKash, Nagad, Rocket, Online',
      'cheque' => 'ব্যাংক চেক',
      'partial' => 'আংশিক পেমেন্ট',
      'due' => 'বাকি',
      _ => paymentMethod,
    };
  }

  String _paymentMethodForCashTransaction(String paymentMethod) {
    return switch (paymentMethod) {
      'online' => 'online',
      'cheque' => 'cheque',
      'partial' => 'partial',
      _ => 'cash',
    };
  }

  String? _nullableTrimmed(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  String? _nullableString(Object? value) {
    if (value == null) {
      return null;
    }

    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  double _double(Object? value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  double? _nullableDouble(Object? value) {
    if (value == null) {
      return null;
    }

    return _double(value);
  }

  int _int(Object? value) {
    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  DateTime _dateTime(Object? value) {
    return AppTime.parseUtc(value);
  }
}
