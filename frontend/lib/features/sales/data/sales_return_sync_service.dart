import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';

final salesReturnSyncServiceProvider = Provider<SalesReturnSyncService>((ref) {
  return SalesReturnSyncService(
    database: ref.watch(appDatabaseProvider),
    apiClient: const ApiClient(),
  );
});

class SalesReturnSyncService {
  const SalesReturnSyncService({
    required this.database,
    required this.apiClient,
  });

  final AppDatabase database;
  final ApiClient apiClient;

  Future<void> syncSalesReturns() async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    final bundles = await database.getPendingSaleReturnBundles(
      shopId: currentUser.shopId,
    );
    for (final bundle in bundles) {
      final response = await apiClient.postJson(
        '/sales/returns',
        body: _bundleToJson(bundle),
      );
      final syncedReturn = response['sale_return'];
      final syncedId = syncedReturn is Map<String, dynamic>
          ? syncedReturn['id']?.toString()
          : null;
      if (syncedId != bundle.saleReturn.id) {
        throw StateError('Sales return sync returned a different return id.');
      }
      await database.markSaleReturnBundleSynced(bundle.saleReturn.id);
    }
  }

  Map<String, dynamic> _bundleToJson(LocalSaleReturnBundle bundle) {
    return {
      'sale_return': {
        'id': bundle.saleReturn.id,
        'shop_id': bundle.saleReturn.shopId,
        'sale_id': bundle.saleReturn.saleId,
        'subtotal': bundle.saleReturn.subtotal,
        'restocking_fee': bundle.saleReturn.restockingFee,
        'refund_total': bundle.saleReturn.refundTotal,
        'note': bundle.saleReturn.note,
        'created_at': bundle.saleReturn.createdAt.toIso8601String(),
        'updated_at': bundle.saleReturn.updatedAt.toIso8601String(),
      },
      'items': [
        for (final item in bundle.items)
          {
            'id': item.id,
            'shop_id': item.shopId,
            'return_id': item.returnId,
            'sale_item_id': item.saleItemId,
            'product_id': item.productId,
            'product_name': item.productName,
            'sale_price': item.salePrice,
            'quantity': item.quantity,
            'reason': item.reason,
            'created_at': item.createdAt.toIso8601String(),
            'updated_at': item.updatedAt.toIso8601String(),
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
            'created_at': transaction.createdAt.toIso8601String(),
            'updated_at': transaction.updatedAt.toIso8601String(),
          },
      ],
    };
  }
}
