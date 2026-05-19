import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../../features/expenses/data/expense_sync_service.dart';
import '../../features/incomes/data/income_sync_service.dart';
import '../../features/notes/data/note_sync_service.dart';
import '../../features/owners/data/owner_transaction_sync_service.dart';
import '../../features/purchases/data/category_sync_service.dart';
import '../../features/purchases/data/purchase_sync_service.dart';
import '../../features/purchases/data/supplier_sync_service.dart';
import '../../features/recycle_bin/data/recycle_bin_sync_service.dart';
import '../../features/sales/data/sales_return_sync_service.dart';
import '../../features/sales/data/sales_sync_service.dart';

final appSyncServiceProvider = Provider<AppSyncService>((ref) {
  return AppSyncService(ref);
});

class AppSyncService {
  const AppSyncService(this._ref);

  final Ref _ref;

  Future<void> syncCurrentSessionOnLogin() {
    return syncAll(pushPending: true);
  }

  Future<void> syncAll({bool pushPending = true}) async {
    final currentUser = await _ref.read(appDatabaseProvider).getCurrentUser();
    if (currentUser == null) {
      return;
    }

    await _ref
        .read(supplierSyncServiceProvider)
        .syncSuppliers(pushPending: pushPending);
    await _ref
        .read(categorySyncServiceProvider)
        .syncProductCategories(pushPending: pushPending);
    await _ref
        .read(recycleBinSyncServiceProvider)
        .syncRecycleBin(pushPending: pushPending);
    await _ref
        .read(purchaseSyncServiceProvider)
        .syncPurchases(pushPending: pushPending);
    await _ref
        .read(salesSyncServiceProvider)
        .syncSales(pushPending: pushPending);
    await _ref
        .read(salesReturnSyncServiceProvider)
        .syncSalesReturns(pushPending: pushPending);
    await _ref
        .read(expenseSyncServiceProvider)
        .syncExpenses(pushPending: pushPending);
    await _ref
        .read(incomeSyncServiceProvider)
        .syncIncomes(pushPending: pushPending);
    await _ref
        .read(ownerTransactionSyncServiceProvider)
        .syncOwnerTransactions(pushPending: pushPending);
    await _ref
        .read(noteSyncServiceProvider)
        .syncNotes(pushPending: pushPending);
  }
}
