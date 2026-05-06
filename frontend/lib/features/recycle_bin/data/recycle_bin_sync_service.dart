import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/app_time.dart';

final recycleBinSyncServiceProvider = Provider<RecycleBinSyncService>((ref) {
  return RecycleBinSyncService(
    database: ref.watch(appDatabaseProvider),
    apiClient: const ApiClient(),
  );
});

class RecycleBinSyncService {
  const RecycleBinSyncService({
    required this.database,
    required this.apiClient,
  });

  final AppDatabase database;
  final ApiClient apiClient;

  Future<void> syncRecycleBin() async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    await _pushPending(currentUser.shopId);
    await _pullCurrentShop(currentUser.shopId);
  }

  Future<void> _pushPending(String shopId) async {
    final pendingEntries = await database.getPendingRecycleBinEntries(
      shopId: shopId,
    );

    for (final entry in pendingEntries) {
      final response = await apiClient.postJson(
        '/recycle-bin',
        body: _entryToJson(entry),
      );
      final syncedEntry = response['recycle_bin_entry'];
      final syncedId = syncedEntry is Map<String, dynamic>
          ? syncedEntry['id']?.toString()
          : null;
      if (syncedId != entry.id) {
        throw StateError('Recycle bin sync returned a different entry id.');
      }
      await database.markRecycleBinEntrySynced(entry.id);
    }
  }

  Future<void> _pullCurrentShop(String shopId) async {
    final response = await apiClient.getJson(
      '/recycle-bin',
      queryParameters: {'shop_id': shopId},
    );

    final rawEntries = response['recycle_bin_entries'];
    if (rawEntries is! List) {
      return;
    }

    await database.upsertSyncedRecycleBinEntries(
      rawEntries.whereType<Map<String, dynamic>>().map(_entryFromJson).toList(),
    );
  }

  Map<String, dynamic> _entryToJson(LocalRecycleBinEntry entry) {
    return {
      'id': entry.id,
      'shop_id': entry.shopId,
      'table_name': _backendTableName(entry.sourceTableName),
      'record_id': entry.recordId,
      'display_title': entry.displayTitle,
      'display_subtitle': entry.displaySubtitle,
      'deleted_data': _decodeJson(entry.deletedData),
      'related_data': _decodeNullableJson(entry.relatedData),
      'deleted_by_user_id': entry.deletedByUserId,
      'deleted_at': AppTime.isoUtc(entry.deletedAt),
      'restored_at': AppTime.nullableIsoUtc(entry.restoredAt),
      'restore_status': entry.restoreStatus,
      'restore_block_reason': entry.restoreBlockReason,
      'created_at': AppTime.isoUtc(entry.createdAt),
      'updated_at': AppTime.isoUtc(entry.updatedAt),
    };
  }

  LocalRecycleBinEntriesCompanion _entryFromJson(Map<String, dynamic> json) {
    return LocalRecycleBinEntriesCompanion(
      id: Value(json['id'].toString()),
      shopId: Value(json['shop_id'].toString()),
      sourceTableName: Value(_localTableName(json['table_name'].toString())),
      recordId: Value(json['record_id'].toString()),
      displayTitle: Value(json['display_title'].toString()),
      displaySubtitle: Value(_nullableString(json['display_subtitle'])),
      deletedData: Value(
        jsonEncode(json['deleted_data'] ?? <String, dynamic>{}),
      ),
      relatedData: Value(
        json['related_data'] == null ? null : jsonEncode(json['related_data']),
      ),
      deletedByUserId: Value(_nullableString(json['deleted_by_user_id'])),
      deletedAt: Value(_dateTime(json['deleted_at'])),
      restoredAt: Value(_nullableDateTime(json['restored_at'])),
      restoreStatus: Value(json['restore_status']?.toString() ?? 'deleted'),
      restoreBlockReason: Value(_nullableString(json['restore_block_reason'])),
      createdAt: Value(_dateTime(json['created_at'])),
      updatedAt: Value(_dateTime(json['updated_at'])),
      syncStatus: const Value('synced'),
    );
  }

  Object _decodeJson(String value) {
    try {
      return jsonDecode(value);
    } on FormatException {
      return {'value': value};
    }
  }

  Object? _decodeNullableJson(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return _decodeJson(value);
  }

  String _backendTableName(String sourceTableName) {
    return sourceTableName.startsWith('local_')
        ? sourceTableName.substring(6)
        : sourceTableName;
  }

  String _localTableName(String tableName) {
    return tableName.startsWith('local_') ? tableName : 'local_$tableName';
  }

  String? _nullableString(Object? value) {
    if (value == null) {
      return null;
    }

    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  DateTime _dateTime(Object? value) {
    return AppTime.parseUtc(value);
  }

  DateTime? _nullableDateTime(Object? value) {
    if (value == null) {
      return null;
    }

    return AppTime.tryParseUtc(value);
  }
}
