import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/app_time.dart';

final noteSyncServiceProvider = Provider<NoteSyncService>((ref) {
  return NoteSyncService(
    database: ref.watch(appDatabaseProvider),
    apiClient: const ApiClient(),
  );
});

class NoteSyncService {
  const NoteSyncService({required this.database, required this.apiClient});

  final AppDatabase database;
  final ApiClient apiClient;

  Future<void> syncNotes() async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    await _pushPending(currentUser.shopId);
    await _pullCurrentShop(currentUser.shopId);
  }

  Future<void> _pushPending(String shopId) async {
    final pendingNotes = await database.getPendingNotes(shopId: shopId);

    for (final note in pendingNotes) {
      final response = await apiClient.postJson(
        '/notes',
        body: _noteToJson(note),
      );
      final syncedNote = response['note'];
      final syncedId = syncedNote is Map<String, dynamic>
          ? syncedNote['id']?.toString()
          : null;
      if (syncedId != note.id) {
        throw StateError('Note sync returned a different note id.');
      }
      await database.markNoteSynced(note.id);
    }
  }

  Future<void> _pullCurrentShop(String shopId) async {
    final response = await apiClient.getJson(
      '/notes',
      queryParameters: {'shop_id': shopId},
    );

    final rawNotes = response['notes'];
    if (rawNotes is! List) {
      return;
    }

    await database.upsertSyncedNotes(
      rawNotes.whereType<Map<String, dynamic>>().map(_noteFromJson).toList(),
    );
  }

  Map<String, dynamic> _noteToJson(LocalNote note) {
    return {
      'id': note.id,
      'shop_id': note.shopId,
      'title': note.title,
      'body': note.body,
      'is_archived': note.isArchived,
      'archived_at': AppTime.nullableIsoUtc(note.archivedAt),
      'created_at': AppTime.isoUtc(note.createdAt),
      'updated_at': AppTime.isoUtc(note.updatedAt),
      'deleted_at': AppTime.nullableIsoUtc(note.deletedAt),
    };
  }

  LocalNotesCompanion _noteFromJson(Map<String, dynamic> json) {
    return LocalNotesCompanion(
      id: Value(json['id'].toString()),
      shopId: Value(json['shop_id'].toString()),
      title: Value(json['title']?.toString() ?? ''),
      body: Value(json['body']?.toString() ?? ''),
      isArchived: Value(_bool(json['is_archived'])),
      archivedAt: Value(_nullableDateTime(json['archived_at'])),
      createdAt: Value(_dateTime(json['created_at'])),
      updatedAt: Value(_dateTime(json['updated_at'])),
      deletedAt: Value(_nullableDateTime(json['deleted_at'])),
      syncStatus: const Value('synced'),
    );
  }

  bool _bool(Object? value) {
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
    return value?.toString() == '1' || value?.toString() == 'true';
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
