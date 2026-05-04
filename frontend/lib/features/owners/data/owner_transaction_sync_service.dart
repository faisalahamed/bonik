import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';

final ownerTransactionSyncServiceProvider =
    Provider<OwnerTransactionSyncService>((ref) {
      return OwnerTransactionSyncService(
        database: ref.watch(appDatabaseProvider),
        apiClient: const ApiClient(),
      );
    });

class OwnerTransactionSyncService {
  const OwnerTransactionSyncService({
    required this.database,
    required this.apiClient,
  });

  final AppDatabase database;
  final ApiClient apiClient;

  Future<void> syncOwnerTransactions() async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    await _pushPending(currentUser.shopId);
    await _pullCurrentShop(currentUser.shopId);
  }

  Future<void> _pushPending(String shopId) async {
    final pendingTransactions = await database.getPendingOwnerTransactions(
      shopId: shopId,
    );
    if (pendingTransactions.isEmpty) {
      return;
    }

    final response = await apiClient.postJson(
      '/owner-transactions',
      body: {
        'cash_transactions': [
          for (final transaction in pendingTransactions)
            _transactionToJson(transaction),
        ],
      },
    );
    final rawTransactions = response['cash_transactions'];
    final syncedIds = rawTransactions is List
        ? rawTransactions
              .whereType<Map<String, dynamic>>()
              .map((row) => row['id']?.toString())
              .whereType<String>()
              .toSet()
        : <String>{};

    for (final transaction in pendingTransactions) {
      if (syncedIds.isNotEmpty && !syncedIds.contains(transaction.id)) {
        throw StateError('Owner transaction sync did not return every id.');
      }
      await database.markOwnerTransactionSynced(transaction.id);
    }
  }

  Future<void> _pullCurrentShop(String shopId) async {
    final response = await apiClient.getJson(
      '/owner-transactions',
      queryParameters: {'shop_id': shopId},
    );

    final rawTransactions = response['cash_transactions'];
    if (rawTransactions is! List) {
      return;
    }

    await database.upsertSyncedOwnerTransactions(
      rawTransactions
          .whereType<Map<String, dynamic>>()
          .map(_transactionFromJson)
          .toList(),
    );
  }

  Map<String, dynamic> _transactionToJson(LocalCashTransaction transaction) {
    return {
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
    };
  }

  LocalCashTransactionsCompanion _transactionFromJson(
    Map<String, dynamic> json,
  ) {
    return LocalCashTransactionsCompanion(
      id: Value(json['id'].toString()),
      shopId: Value(json['shop_id'].toString()),
      type: Value(json['type'].toString()),
      direction: Value(json['direction'].toString()),
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
