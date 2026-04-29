import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/purchases/data/category_sync_service.dart';

final appSyncServiceProvider = Provider<AppSyncService>((ref) {
  return AppSyncService(ref);
});

class AppSyncService {
  const AppSyncService(this._ref);

  final Ref _ref;

  Future<void> syncAll() async {
    await _ref.read(categorySyncServiceProvider).syncProductCategories();

    // Add future sync modules here:
    // await _ref.read(salesSyncServiceProvider).syncSales();
    // await _ref.read(purchaseSyncServiceProvider).syncPurchases();
  }
}
