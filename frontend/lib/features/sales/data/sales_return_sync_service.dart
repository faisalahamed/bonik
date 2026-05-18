import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/app_time.dart';

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
        body: {..._bundleToJson(bundle), 'user_id': currentUser.id},
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
    await _pullCurrentShop(currentUser.shopId, currentUser.id);
  }

  Future<void> _pullCurrentShop(String shopId, String userId) async {
    const entityType = 'sale_returns';
    final cursor = await database.getLastPulledAt(
      shopId: shopId,
      entityType: entityType,
    );
    final response = await apiClient.getJson(
      '/sales/returns',
      queryParameters: {
        'shop_id': shopId,
        'user_id': userId,
        if (cursor != null) 'updated_after': AppTime.syncCursorIso(cursor),
      },
    );

    final rawReturns = response['sale_returns'];
    if (rawReturns is! List) {
      return;
    }

    await database.upsertSyncedSaleReturnBundles(
      rawReturns
          .whereType<Map<String, dynamic>>()
          .map(_bundleFromJson)
          .toList(),
    );
    await database.markPullSucceeded(
      shopId: shopId,
      entityType: entityType,
      serverTime: AppTime.parseUtc(response['server_time']),
    );
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
        'created_at': AppTime.isoUtc(bundle.saleReturn.createdAt),
        'updated_at': AppTime.isoUtc(bundle.saleReturn.updatedAt),
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
            'created_at': AppTime.isoUtc(item.createdAt),
            'updated_at': AppTime.isoUtc(item.updatedAt),
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

  LocalSaleReturnBundleCompanion _bundleFromJson(Map<String, dynamic> json) {
    final returnId = json['id'].toString();
    final rawItems = json['items'];
    final rawCashTransactions =
        json['cash_transactions'] ?? json['cashTransactions'];

    return LocalSaleReturnBundleCompanion(
      saleReturn: LocalSaleReturnsCompanion(
        id: Value(returnId),
        shopId: Value(json['shop_id'].toString()),
        saleId: Value(json['sale_id'].toString()),
        subtotal: Value(_double(json['subtotal'])),
        restockingFee: Value(_double(json['restocking_fee'])),
        refundTotal: Value(_double(json['refund_total'])),
        note: Value(_nullableString(json['note'])),
        createdAt: Value(AppTime.parseUtc(json['created_at'])),
        updatedAt: Value(AppTime.parseUtc(json['updated_at'])),
        deletedAt: Value(_nullableDateTime(json['deleted_at'])),
        syncStatus: const Value('synced'),
      ),
      items: [
        if (rawItems is List)
          for (final item in rawItems.whereType<Map<String, dynamic>>())
            LocalSaleReturnItemsCompanion(
              id: Value(item['id'].toString()),
              shopId: Value(item['shop_id'].toString()),
              returnId: Value(item['return_id']?.toString() ?? returnId),
              saleItemId: Value(item['sale_item_id'].toString()),
              productId: Value(item['product_id'].toString()),
              productName: Value(item['product_name'].toString()),
              salePrice: Value(_double(item['sale_price'])),
              quantity: Value(_int(item['quantity'])),
              reason: Value(_nullableString(item['reason'])),
              createdAt: Value(AppTime.parseUtc(item['created_at'])),
              updatedAt: Value(AppTime.parseUtc(item['updated_at'])),
              deletedAt: Value(_nullableDateTime(item['deleted_at'])),
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
              type: Value(transaction['type']?.toString() ?? 'sales_return'),
              direction: Value(transaction['direction']?.toString() ?? 'out'),
              amount: Value(_double(transaction['amount'])),
              referenceId: Value(
                _nullableString(transaction['reference_id']) ?? returnId,
              ),
              referenceType: Value(
                _nullableString(transaction['reference_type']) ??
                    'sales_return',
              ),
              method: Value(_nullableString(transaction['method'])),
              note: Value(_nullableString(transaction['note'])),
              createdAt: Value(AppTime.parseUtc(transaction['created_at'])),
              updatedAt: Value(AppTime.parseUtc(transaction['updated_at'])),
              deletedAt: Value(_nullableDateTime(transaction['deleted_at'])),
              syncStatus: const Value('synced'),
            ),
      ],
    );
  }

  String? _nullableString(Object? value) {
    if (value == null) {
      return null;
    }

    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  DateTime? _nullableDateTime(Object? value) {
    if (value == null) {
      return null;
    }

    return AppTime.tryParseUtc(value);
  }

  double _double(Object? value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  int _int(Object? value) {
    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
