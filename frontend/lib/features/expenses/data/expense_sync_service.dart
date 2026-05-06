import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/app_time.dart';

final expenseSyncServiceProvider = Provider<ExpenseSyncService>((ref) {
  return ExpenseSyncService(
    database: ref.watch(appDatabaseProvider),
    apiClient: const ApiClient(),
  );
});

class ExpenseSyncService {
  const ExpenseSyncService({required this.database, required this.apiClient});

  final AppDatabase database;
  final ApiClient apiClient;

  Future<void> syncExpenses() async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    await _pushPending(currentUser.shopId);
    await _pullCurrentShop(currentUser.shopId);
  }

  Future<void> _pushPending(String shopId) async {
    final bundle = await database.getPendingExpenseSyncBundle(shopId: shopId);
    if (bundle.isEmpty) {
      return;
    }

    await apiClient.postJson('/expenses', body: _bundleToJson(bundle));
    await database.markExpenseSyncBundleSynced(bundle);
  }

  Future<void> _pullCurrentShop(String shopId) async {
    final response = await apiClient.getJson(
      '/expenses',
      queryParameters: {'shop_id': shopId},
    );

    await database.upsertSyncedExpenseData(
      expenses: [
        if (response['expenses'] case final List rows)
          for (final row in rows.whereType<Map<String, dynamic>>())
            _expenseFromJson(row),
      ],
      cashTransactions: [
        if (response['cash_transactions'] case final List rows)
          for (final row in rows.whereType<Map<String, dynamic>>())
            _cashTransactionFromJson(row),
      ],
    );
  }

  Map<String, dynamic> _bundleToJson(LocalExpenseSyncBundle bundle) {
    return {
      'expenses': [
        for (final expense in bundle.expenses)
          {
            'id': expense.id,
            'shop_id': expense.shopId,
            'category_id': expense.categoryId,
            'amount': expense.amount,
            'reason': expense.reason,
            'note': expense.note,
            'created_at': AppTime.isoUtc(expense.createdAt),
            'updated_at': AppTime.isoUtc(expense.updatedAt),
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

  LocalExpensesCompanion _expenseFromJson(Map<String, dynamic> json) {
    return LocalExpensesCompanion(
      id: Value(json['id'].toString()),
      shopId: Value(json['shop_id'].toString()),
      categoryId: Value(json['category_id'].toString()),
      amount: Value(_double(json['amount'] ?? json['total'])),
      reason: Value(_nullableString(json['reason'])),
      note: Value(_nullableString(json['note'])),
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
      type: Value(json['type']?.toString() ?? 'expense'),
      direction: Value(json['direction']?.toString() ?? 'out'),
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
    return AppTime.parseUtc(value);
  }
}
