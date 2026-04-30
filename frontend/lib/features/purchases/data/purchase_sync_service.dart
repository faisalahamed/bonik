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
}
