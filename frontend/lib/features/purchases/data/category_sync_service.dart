import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';

final categorySyncServiceProvider = Provider<CategorySyncService>((ref) {
  return CategorySyncService(
    database: ref.watch(appDatabaseProvider),
    apiClient: const ApiClient(),
  );
});

class CategorySyncService {
  const CategorySyncService({required this.database, required this.apiClient});

  final AppDatabase database;
  final ApiClient apiClient;

  Future<void> syncProductCategories() async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    await _pushPending();
    await _pullCurrentShop(currentUser.shopId);
  }

  Future<void> _pushPending() async {
    final pendingCategories = await database.getPendingProductCategories();

    for (final category in pendingCategories) {
      final response = await apiClient.postJson(
        '/categories',
        body: {
          'id': category.id,
          'shop_id': category.shopId,
          'name': category.name,
          'type': category.type,
          'details': category.details,
          'image_url': category.imageUrl,
          'created_at': category.createdAt.toIso8601String(),
          'updated_at': category.updatedAt.toIso8601String(),
          'deleted_at': category.deletedAt?.toIso8601String(),
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

  Future<void> _pullCurrentShop(String shopId) async {
    final response = await apiClient.getJson(
      '/categories',
      queryParameters: {'shop_id': shopId, 'type': 'product'},
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
    return _nullableDateTime(value) ?? DateTime.now();
  }

  DateTime? _nullableDateTime(Object? value) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value.toString());
  }
}
