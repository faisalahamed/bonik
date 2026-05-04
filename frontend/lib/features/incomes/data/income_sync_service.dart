import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';

final incomeSyncServiceProvider = Provider<IncomeSyncService>((ref) {
  return IncomeSyncService(
    database: ref.watch(appDatabaseProvider),
    apiClient: const ApiClient(),
  );
});

class IncomeSyncService {
  const IncomeSyncService({required this.database, required this.apiClient});

  final AppDatabase database;
  final ApiClient apiClient;

  Future<void> syncIncomes() async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    await _pushPending(currentUser.shopId);
    await _pullCurrentShop(currentUser.shopId);
  }

  Future<void> _pushPending(String shopId) async {
    final bundle = await database.getPendingIncomeSyncBundle(shopId: shopId);
    if (bundle.isEmpty) {
      return;
    }

    await apiClient.postJson('/incomes', body: _bundleToJson(bundle));
    await database.markIncomeSyncBundleSynced(bundle);
  }

  Future<void> _pullCurrentShop(String shopId) async {
    final response = await apiClient.getJson(
      '/incomes',
      queryParameters: {'shop_id': shopId},
    );

    await database.upsertSyncedIncomeData(
      incomes: [
        if (response['incomes'] case final List rows)
          for (final row in rows.whereType<Map<String, dynamic>>())
            _incomeFromJson(row),
      ],
      cashTransactions: [
        if (response['cash_transactions'] case final List rows)
          for (final row in rows.whereType<Map<String, dynamic>>())
            _cashTransactionFromJson(row),
      ],
    );
  }

  Map<String, dynamic> _bundleToJson(LocalIncomeSyncBundle bundle) {
    return {
      'incomes': [
        for (final income in bundle.incomes)
          {
            'id': income.id,
            'shop_id': income.shopId,
            'category_id': income.categoryId,
            'amount': income.amount,
            'reason': income.reason,
            'note': income.note,
            'receipt_url': income.receiptUrl,
            'created_at': income.createdAt.toIso8601String(),
            'updated_at': income.updatedAt.toIso8601String(),
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

  LocalIncomesCompanion _incomeFromJson(Map<String, dynamic> json) {
    return LocalIncomesCompanion(
      id: Value(json['id'].toString()),
      shopId: Value(json['shop_id'].toString()),
      categoryId: Value(json['category_id'].toString()),
      amount: Value(_double(json['amount'] ?? json['total'])),
      reason: Value(_nullableString(json['reason'])),
      note: Value(_nullableString(json['note'])),
      receiptUrl: Value(_nullableString(json['receipt_url'])),
      createdAt: Value(_dateTime(json['created_at'])),
      updatedAt: Value(_dateTime(json['updated_at'])),
      syncStatus: const Value('synced'),
    );
  }

  LocalCashTransactionsCompanion _cashTransactionFromJson(
    Map<String, dynamic> json,
  ) {
    return LocalCashTransactionsCompanion(
      id: Value(json['id'].toString()),
      shopId: Value(json['shop_id'].toString()),
      type: Value(json['type']?.toString() ?? 'income'),
      direction: Value(json['direction']?.toString() ?? 'in'),
      amount: Value(_double(json['amount'])),
      referenceId: Value(_nullableString(json['reference_id'])),
      referenceType: Value(_nullableString(json['reference_type'])),
      method: Value(_nullableString(json['method'])),
      note: Value(_nullableString(json['note'])),
      createdAt: Value(_dateTime(json['created_at'])),
      updatedAt: Value(_dateTime(json['updated_at'])),
      syncStatus: const Value('synced'),
    );
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

  DateTime _dateTime(Object? value) {
    return DateTime.tryParse(value?.toString() ?? '') ?? DateTime.now();
  }
}
