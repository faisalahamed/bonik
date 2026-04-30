import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/purchases/data/category_sync_service.dart';
import '../../features/purchases/data/purchase_sync_service.dart';
import '../../features/purchases/data/supplier_sync_service.dart';

final appSyncServiceProvider = Provider<AppSyncService>((ref) {
  return AppSyncService(ref);
});

class AppSyncService {
  const AppSyncService(this._ref);

  final Ref _ref;

  Future<void> syncAll() async {
    await _ref.read(supplierSyncServiceProvider).syncSuppliers();
    await _ref.read(categorySyncServiceProvider).syncProductCategories();
    await _ref.read(purchaseSyncServiceProvider).syncPendingPurchases();

    // Add future sync modules here:
    // await _ref.read(salesSyncServiceProvider).syncSales();
  }
}
