import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';

final supplierSyncServiceProvider = Provider<SupplierSyncService>((ref) {
  return SupplierSyncService(
    database: ref.watch(appDatabaseProvider),
    apiClient: const ApiClient(),
  );
});

class SupplierSyncService {
  const SupplierSyncService({required this.database, required this.apiClient});

  final AppDatabase database;
  final ApiClient apiClient;

  Future<void> syncSuppliers() async {
    final currentUser = await database.getCurrentUser();
    if (currentUser == null) {
      return;
    }

    await _pushPending();
    await _pullCurrentShop(currentUser.shopId);
  }

  Future<void> _pushPending() async {
    final pendingSuppliers = await database.getPendingSuppliers();

    for (final supplier in pendingSuppliers) {
      await apiClient.postJson(
        '/suppliers',
        body: {
          'id': supplier.id,
          'shop_id': supplier.shopId,
          'name': supplier.name,
          'image': supplier.image,
          'mobile': supplier.mobile,
          'address': supplier.address,
          'created_at': supplier.createdAt.toIso8601String(),
          'updated_at': supplier.updatedAt.toIso8601String(),
          'deleted_at': supplier.deletedAt?.toIso8601String(),
        },
      );
      await database.markSupplierSynced(supplier.id);
    }
  }

  Future<void> _pullCurrentShop(String shopId) async {
    final response = await apiClient.getJson(
      '/suppliers',
      queryParameters: {'shop_id': shopId},
    );

    final rawSuppliers = response['suppliers'];
    if (rawSuppliers is! List) {
      return;
    }

    await database.upsertSyncedSuppliers(
      rawSuppliers
          .whereType<Map<String, dynamic>>()
          .map(_supplierFromJson)
          .toList(),
    );
  }

  LocalSuppliersCompanion _supplierFromJson(Map<String, dynamic> json) {
    return LocalSuppliersCompanion(
      id: Value(json['id'].toString()),
      shopId: Value(json['shop_id'].toString()),
      name: Value(json['name'].toString()),
      image: Value(_nullableString(json['image'])),
      mobile: Value(_nullableString(json['mobile'])),
      address: Value(_nullableString(json['address'])),
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
