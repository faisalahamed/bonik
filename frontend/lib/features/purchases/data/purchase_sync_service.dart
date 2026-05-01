import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';
import '../application/cash_purchase_draft_controller.dart';

final purchaseSyncServiceProvider = Provider<PurchaseSyncService>((ref) {
  return PurchaseSyncService(
    database: ref.watch(appDatabaseProvider),
    apiClient: const ApiClient(),
  );
});

class PurchaseSyncService {
  const PurchaseSyncService({required this.database, required this.apiClient});

  final AppDatabase database;
  final ApiClient apiClient;

  Future<void> syncPurchases() async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    await syncPendingPurchases();
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

    final now = DateTime.now();
    final purchaseId = const Uuid().v4();
    final paidAmount = _paidAmountForDraft(draft);
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
        createdAt: Value(draft.purchaseDate),
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
            description: Value(line.category.details),
            createdAt: Value(draft.purchaseDate),
            updatedAt: Value(now),
            syncStatus: const Value('pending'),
          ),
      ],
      payment: paidAmount > 0
          ? LocalPurchasePaymentsCompanion(
              id: Value(const Uuid().v4()),
              shopId: Value(currentUser.shopId),
              purchaseId: Value(purchaseId),
              payments: Value(paidAmount),
              description: Value(_paymentDescription(draft.paymentMethod)),
              createdAt: Value(draft.purchaseDate),
              updatedAt: Value(now),
              syncStatus: const Value('pending'),
            )
          : null,
    );

    return purchaseId;
  }

  Future<void> syncPendingPurchases() async {
    final bundles = await database.getPendingPurchaseBundles();

    for (final bundle in bundles) {
      await apiClient.postJson('/purchases', body: _bundleToJson(bundle));
      await database.markPurchaseBundleSynced(bundle.purchase.id);
    }
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

    await database.upsertSyncedPurchaseBundles(
      rawPurchases
          .whereType<Map<String, dynamic>>()
          .map(_bundleFromJson)
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
        'created_at': bundle.purchase.createdAt.toIso8601String(),
        'updated_at': bundle.purchase.updatedAt.toIso8601String(),
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
            'created_at': item.createdAt.toIso8601String(),
            'updated_at': item.updatedAt.toIso8601String(),
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
            'created_at': payment.createdAt.toIso8601String(),
            'updated_at': payment.updatedAt.toIso8601String(),
          },
      ],
    };
  }

  LocalPurchaseBundleCompanion _bundleFromJson(Map<String, dynamic> json) {
    final purchaseId = json['id'].toString();
    final rawItems = json['items'];
    final rawPayments = json['payments'];

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
    return DateTime.tryParse(value?.toString() ?? '') ?? DateTime.now();
  }
}
