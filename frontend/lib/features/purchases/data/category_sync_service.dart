import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/app_time.dart';

final categorySyncServiceProvider = Provider<CategorySyncService>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return CategorySyncService(
    database: database,
    apiClient: ApiClient(authTokenProvider: database.getCurrentApiToken),
  );
});

class CategorySyncService {
  const CategorySyncService({required this.database, required this.apiClient});

  final AppDatabase database;
  final ApiClient apiClient;

  Future<void> syncProductCategories({bool pushPending = true}) async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    if (pushPending) {
      await _pushPending(currentUser.shopId, currentUser.id);
    }
    await _pullCurrentShop(currentUser.shopId, currentUser.id);
  }

  Future<void> _pushPending(String shopId, String userId) async {
    final pendingCategories = await database.getPendingCategories(
      shopId: shopId,
    );

    for (final category in pendingCategories) {
      _assertShop(category.shopId, shopId, 'category');
      final response = await apiClient.postJson(
        '/categories',
        body: {
          'id': category.id,
          'shop_id': category.shopId,
          'name': category.name,
          'type': category.type,
          'details': category.details,
          'image_url': category.imageUrl,
          'created_at': AppTime.isoUtc(category.createdAt),
          'updated_at': AppTime.isoUtc(category.updatedAt),
          'deleted_at': AppTime.nullableIsoUtc(category.deletedAt),
          'user_id': userId,
        },
      );
      final syncedCategory = response['category'];
      final syncedId = syncedCategory is Map<String, dynamic>
          ? syncedCategory['id']?.toString()
          : null;
      if (syncedId != category.id) {
        throw StateError('Category sync returned a different category id.');
      }
      await database.markCategorySynced(category.id);
    }
  }

  void _assertShop(String rowShopId, String activeShopId, String label) {
    if (rowShopId != activeShopId) {
      throw StateError(
        'Blocked $label sync for a different shop. Expected $activeShopId, got $rowShopId.',
      );
    }
  }

  Future<void> _pullCurrentShop(String shopId, String userId) async {
    const entityType = 'categories';
    final cursor = await database.getLastPulledAt(
      shopId: shopId,
      entityType: entityType,
    );
    final response = await apiClient.getJson(
      '/categories',
      queryParameters: {
        'shop_id': shopId,
        'user_id': userId,
        if (cursor != null) 'updated_after': AppTime.syncCursorIso(cursor),
      },
    );

    final rawCategories = response['categories'];
    if (rawCategories is! List) {
      return;
    }

    await database.upsertSyncedCategories(
      rawCategories
          .whereType<Map<String, dynamic>>()
          .map(_categoryFromJson)
          .toList(),
    );
    await database.markPullSucceeded(
      shopId: shopId,
      entityType: entityType,
      serverTime: _dateTime(response['server_time']),
    );
  }

  LocalCategoriesCompanion _categoryFromJson(Map<String, dynamic> json) {
    return LocalCategoriesCompanion(
      id: Value(json['id'].toString()),
      shopId: Value(json['shop_id'].toString()),
      name: Value(json['name'].toString()),
      type: Value(json['type'].toString()),
      details: Value(_nullableString(json['details'])),
      imageUrl: Value(_nullableString(json['image_url'])),
      createdAt: Value(_dateTime(json['created_at'])),
      updatedAt: Value(_dateTime(json['updated_at'])),
      deletedAt: Value(_nullableDateTime(json['deleted_at'])),
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
