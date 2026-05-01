import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

class LocalShops extends Table {
  TextColumn get id => text()();
  TextColumn get shopName => text()();
  TextColumn get email => text()();
  TextColumn get shopMobile => text()();
  TextColumn get shopWebsite => text().nullable()();
  TextColumn get shopAddress => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalUsers extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get passwordHash => text().nullable()();
  TextColumn get role => text()();
  DateTimeColumn get emailVerifiedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  BoolColumn get isCurrent => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalCategories extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get name => text()();
  TextColumn get type => text()();
  TextColumn get details => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalSuppliers extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get name => text()();
  TextColumn get image => text().nullable()();
  TextColumn get mobile => text().nullable()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalPurchases extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get supplierId => text().references(LocalSuppliers, #id)();
  RealColumn get total => real()();
  RealColumn get otherCharge => real().withDefault(const Constant(0))();
  TextColumn get description => text().nullable()();
  TextColumn get buyingMemoUrl => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalPurchaseItems extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get purchaseId =>
      text().nullable().references(LocalPurchases, #id)();
  TextColumn get categoryId =>
      text().nullable().references(LocalCategories, #id)();
  TextColumn get productName => text()();
  RealColumn get buyingPrice => real()();
  RealColumn get estSellingPrice => real().nullable()();
  IntColumn get quantity => integer().withDefault(const Constant(0))();
  TextColumn get barcode => text().nullable()();
  RealColumn get otherCharge => real().withDefault(const Constant(0))();
  TextColumn get description => text().nullable()();
  TextColumn get productImage => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalPurchasePayments extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get purchaseId => text().references(LocalPurchases, #id)();
  RealColumn get payments => real()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    LocalShops,
    LocalUsers,
    LocalCategories,
    LocalSuppliers,
    LocalPurchases,
    LocalPurchaseItems,
    LocalPurchasePayments,
  ],
)
final class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'bonik'));

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(localUsers, localUsers.passwordHash);
      }
      if (from < 3) {
        await migrator.createTable(localCategories);
      }
      if (from >= 3 && from < 4) {
        await migrator.addColumn(localCategories, localCategories.details);
      }
      if (from < 5) {
        await migrator.createTable(localSuppliers);
      }
      if (from < 6) {
        await migrator.createTable(localPurchases);
        await migrator.createTable(localPurchaseItems);
        await migrator.createTable(localPurchasePayments);
      }
    },
  );

  Future<void> saveLoggedInSession({
    required LocalShopsCompanion shop,
    required LocalUsersCompanion user,
  }) async {
    await transaction(() async {
      await into(localShops).insertOnConflictUpdate(shop);
      await update(
        localUsers,
      ).write(const LocalUsersCompanion(isCurrent: Value(false)));
      await into(
        localUsers,
      ).insertOnConflictUpdate(user.copyWith(isCurrent: const Value(true)));
    });
  }

  Future<void> clearCurrentSession() async {
    await update(
      localUsers,
    ).write(const LocalUsersCompanion(isCurrent: Value(false)));
  }

  Future<LocalUser?> findUserForOfflineLogin(String identity) {
    final trimmedIdentity = identity.trim();
    final normalizedIdentity = trimmedIdentity.toLowerCase();
    final shopIds = selectOnly(localShops)
      ..addColumns([localShops.id])
      ..where(localShops.shopMobile.equals(trimmedIdentity));

    return (select(localUsers)
          ..where(
            (user) =>
                user.email.lower().equals(normalizedIdentity) |
                user.shopId.isInQuery(shopIds),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  Stream<LocalUser?> watchCurrentUser() {
    return (select(
      localUsers,
    )..where((user) => user.isCurrent.equals(true))).watchSingleOrNull();
  }

  Stream<bool> watchHasUnsyncedData() {
    return customSelect(
      '''
      SELECT EXISTS(
        SELECT 1 FROM local_shops WHERE sync_status != 'synced'
        UNION ALL
        SELECT 1 FROM local_users WHERE sync_status != 'synced'
        UNION ALL
        SELECT 1 FROM local_categories WHERE sync_status != 'synced'
        UNION ALL
        SELECT 1 FROM local_suppliers WHERE sync_status != 'synced'
        UNION ALL
        SELECT 1 FROM local_purchases WHERE sync_status != 'synced'
        UNION ALL
        SELECT 1 FROM local_purchase_items WHERE sync_status != 'synced'
        UNION ALL
        SELECT 1 FROM local_purchase_payments WHERE sync_status != 'synced'
      ) AS has_unsynced
      ''',
      readsFrom: {
        localShops,
        localUsers,
        localCategories,
        localSuppliers,
        localPurchases,
        localPurchaseItems,
        localPurchasePayments,
      },
    ).watchSingle().map((row) => row.read<bool>('has_unsynced'));
  }

  Future<LocalUser?> getCurrentUser() {
    return (select(
      localUsers,
    )..where((user) => user.isCurrent.equals(true))).getSingleOrNull();
  }

  Stream<List<LocalCategory>> watchProductCategoriesForCurrentShop() {
    final currentShopIds = selectOnly(localUsers)
      ..addColumns([localUsers.shopId])
      ..where(localUsers.isCurrent.equals(true));

    return (select(localCategories)
          ..where(
            (category) =>
                category.type.equals('product') &
                category.deletedAt.isNull() &
                category.shopId.isInQuery(currentShopIds),
          )
          ..orderBy([(category) => OrderingTerm.asc(category.name)]))
        .watch();
  }

  Stream<List<LocalCategory>> watchDeletedProductCategoriesForCurrentShop() {
    final currentShopIds = selectOnly(localUsers)
      ..addColumns([localUsers.shopId])
      ..where(localUsers.isCurrent.equals(true));

    return (select(localCategories)
          ..where(
            (category) =>
                category.type.equals('product') &
                category.deletedAt.isNotNull() &
                category.shopId.isInQuery(currentShopIds),
          )
          ..orderBy([(category) => OrderingTerm.desc(category.deletedAt)]))
        .watch();
  }

  Future<LocalCategory> createProductCategory(
    String name, {
    String? details,
  }) async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw StateError('No current user found.');
    }

    final trimmedName = name.trim();
    final existingCategory = await _findCategoryByName(
      shopId: currentUser.shopId,
      type: 'product',
      name: trimmedName,
    );
    if (existingCategory != null) {
      return existingCategory;
    }

    final now = DateTime.now();
    final id = const Uuid().v4();
    final category = LocalCategoriesCompanion(
      id: Value(id),
      shopId: Value(currentUser.shopId),
      name: Value(trimmedName),
      type: const Value('product'),
      details: Value(_nullableTrimmed(details)),
      createdAt: Value(now),
      updatedAt: Value(now),
      syncStatus: const Value('pending'),
    );

    await into(localCategories).insert(category);

    return (select(
      localCategories,
    )..where((table) => table.id.equals(id))).getSingle();
  }

  Future<void> updateProductCategory({
    required String id,
    required String name,
    String? details,
  }) async {
    final category = await (select(
      localCategories,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (category == null) {
      throw StateError('Category not found.');
    }

    final trimmedName = name.trim();
    final existingCategory = await _findCategoryByName(
      shopId: category.shopId,
      type: category.type,
      name: trimmedName,
      excludedId: id,
    );
    if (existingCategory != null) {
      throw StateError('Category name already exists.');
    }

    await (update(
      localCategories,
    )..where((table) => table.id.equals(id))).write(
      LocalCategoriesCompanion(
        name: Value(trimmedName),
        details: Value(_nullableTrimmed(details)),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<void> deleteProductCategory(String id) async {
    final now = DateTime.now();

    await (update(
      localCategories,
    )..where((table) => table.id.equals(id))).write(
      LocalCategoriesCompanion(
        updatedAt: Value(now),
        deletedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<void> restoreProductCategory(String id) async {
    await (update(
      localCategories,
    )..where((table) => table.id.equals(id))).write(
      LocalCategoriesCompanion(
        updatedAt: Value(DateTime.now()),
        deletedAt: const Value(null),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<List<LocalCategory>> getPendingProductCategories() {
    return (select(localCategories)..where(
          (category) =>
              category.type.equals('product') &
              category.syncStatus.equals('pending'),
        ))
        .get();
  }

  Future<LocalCategory?> getCategoryById(String id) {
    return (select(
      localCategories,
    )..where((category) => category.id.equals(id))).getSingleOrNull();
  }

  Future<void> ensurePendingProductCategory({
    required String id,
    required String shopId,
    required String name,
  }) async {
    final now = DateTime.now();
    await into(localCategories).insertOnConflictUpdate(
      LocalCategoriesCompanion(
        id: Value(id),
        shopId: Value(shopId),
        name: Value(name.trim().isEmpty ? 'পণ্য' : name.trim()),
        type: const Value('product'),
        createdAt: Value(now),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<void> markCategorySynced(String id) async {
    await (update(localCategories)..where((category) => category.id.equals(id)))
        .write(const LocalCategoriesCompanion(syncStatus: Value('synced')));
  }

  Future<void> markCategoryPending(String id) async {
    await (update(localCategories)..where((category) => category.id.equals(id)))
        .write(const LocalCategoriesCompanion(syncStatus: Value('pending')));
  }

  Future<void> upsertSyncedCategories(
    List<LocalCategoriesCompanion> rows,
  ) async {
    await transaction(() async {
      for (final row in rows) {
        await into(localCategories).insertOnConflictUpdate(row);
      }
    });
  }

  Stream<List<LocalSupplier>> watchSuppliersForCurrentShop() {
    final currentShopIds = selectOnly(localUsers)
      ..addColumns([localUsers.shopId])
      ..where(localUsers.isCurrent.equals(true));

    return (select(localSuppliers)
          ..where(
            (supplier) =>
                supplier.deletedAt.isNull() &
                supplier.shopId.isInQuery(currentShopIds),
          )
          ..orderBy([(supplier) => OrderingTerm.asc(supplier.name)]))
        .watch();
  }

  Stream<LocalSupplier?> watchSupplierById(String id) {
    return (select(
      localSuppliers,
    )..where((supplier) => supplier.id.equals(id))).watchSingleOrNull();
  }

  Future<List<LocalSupplier>> getPendingSuppliers() {
    return (select(
      localSuppliers,
    )..where((supplier) => supplier.syncStatus.equals('pending'))).get();
  }

  Future<LocalSupplier?> getSupplierById(String id) {
    return (select(
      localSuppliers,
    )..where((supplier) => supplier.id.equals(id))).getSingleOrNull();
  }

  Future<void> ensurePendingSupplier({
    required String id,
    required String shopId,
    String name = 'সাপ্লায়ার',
  }) async {
    final now = DateTime.now();
    await into(localSuppliers).insertOnConflictUpdate(
      LocalSuppliersCompanion(
        id: Value(id),
        shopId: Value(shopId),
        name: Value(name.trim().isEmpty ? 'সাপ্লায়ার' : name.trim()),
        createdAt: Value(now),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<LocalSupplier> createSupplier({
    required String name,
    String? mobile,
    String? address,
  }) async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw StateError('No current user found.');
    }

    final trimmedName = name.trim();
    final existingSupplier =
        await (select(localSuppliers)
              ..where(
                (supplier) =>
                    supplier.shopId.equals(currentUser.shopId) &
                    supplier.deletedAt.isNull() &
                    supplier.name.lower().equals(trimmedName.toLowerCase()),
              )
              ..limit(1))
            .getSingleOrNull();
    if (existingSupplier != null) {
      return existingSupplier;
    }

    final now = DateTime.now();
    final id = const Uuid().v4();
    await into(localSuppliers).insert(
      LocalSuppliersCompanion(
        id: Value(id),
        shopId: Value(currentUser.shopId),
        name: Value(trimmedName),
        mobile: Value(_nullableTrimmed(mobile)),
        address: Value(_nullableTrimmed(address)),
        createdAt: Value(now),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );

    return (select(
      localSuppliers,
    )..where((supplier) => supplier.id.equals(id))).getSingle();
  }

  Future<void> markSupplierSynced(String id) async {
    await (update(localSuppliers)..where((supplier) => supplier.id.equals(id)))
        .write(const LocalSuppliersCompanion(syncStatus: Value('synced')));
  }

  Future<void> markSupplierPending(String id) async {
    await (update(localSuppliers)..where((supplier) => supplier.id.equals(id)))
        .write(const LocalSuppliersCompanion(syncStatus: Value('pending')));
  }

  Future<void> upsertSyncedSuppliers(List<LocalSuppliersCompanion> rows) async {
    await transaction(() async {
      for (final row in rows) {
        await into(localSuppliers).insertOnConflictUpdate(row);
      }
    });
  }

  Future<void> insertPurchaseBundle({
    required LocalPurchasesCompanion purchase,
    required List<LocalPurchaseItemsCompanion> items,
    required LocalPurchasePaymentsCompanion? payment,
  }) async {
    await transaction(() async {
      await into(localPurchases).insertOnConflictUpdate(purchase);
      for (final item in items) {
        await into(localPurchaseItems).insertOnConflictUpdate(item);
      }
      if (payment != null) {
        await into(localPurchasePayments).insertOnConflictUpdate(payment);
      }
    });
  }

  Future<void> upsertSyncedPurchaseBundles(
    List<LocalPurchaseBundleCompanion> bundles,
  ) async {
    await transaction(() async {
      for (final bundle in bundles) {
        await into(localPurchases).insertOnConflictUpdate(bundle.purchase);
        for (final item in bundle.items) {
          await into(localPurchaseItems).insertOnConflictUpdate(item);
        }
        for (final payment in bundle.payments) {
          await into(localPurchasePayments).insertOnConflictUpdate(payment);
        }
      }
    });
  }

  Stream<List<LocalPurchaseHistoryEntry>> watchPurchaseHistoryForCurrentShop() {
    return customSelect(
      '''
      SELECT
        p.id,
        p.supplier_id,
        COALESCE(s.name, 'সাপ্লায়ার') AS supplier_name,
        p.total,
        p.status,
        p.created_at,
        p.sync_status,
        COALESCE((
          SELECT SUM(payments)
          FROM local_purchase_payments
          WHERE purchase_id = p.id
        ), 0.0) AS paid_amount,
        COALESCE((
          SELECT COUNT(*)
          FROM local_purchase_items
          WHERE purchase_id = p.id
        ), 0) AS item_count
      FROM local_purchases p
      LEFT JOIN local_suppliers s ON s.id = p.supplier_id
      WHERE p.shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
      ORDER BY p.created_at DESC
      ''',
      readsFrom: {
        localPurchases,
        localSuppliers,
        localPurchasePayments,
        localPurchaseItems,
        localUsers,
      },
    ).watch().map(
      (rows) => rows
          .map(
            (row) => LocalPurchaseHistoryEntry(
              id: row.read<String>('id'),
              supplierId: row.read<String>('supplier_id'),
              supplierName: row.read<String>('supplier_name'),
              total: row.read<double>('total'),
              paidAmount: row.read<double>('paid_amount'),
              itemCount: row.read<int>('item_count'),
              status: row.read<String>('status'),
              createdAt: row.read<DateTime>('created_at'),
              syncStatus: row.read<String>('sync_status'),
            ),
          )
          .toList(),
    );
  }

  Stream<LocalPurchase?> watchPurchaseById(String id) {
    return (select(
      localPurchases,
    )..where((purchase) => purchase.id.equals(id))).watchSingleOrNull();
  }

  Stream<List<LocalPurchaseItem>> watchPurchaseItems(String purchaseId) {
    return (select(localPurchaseItems)
          ..where((item) => item.purchaseId.equals(purchaseId))
          ..orderBy([(item) => OrderingTerm.asc(item.createdAt)]))
        .watch();
  }

  Stream<List<LocalPurchasePayment>> watchPurchasePayments(String purchaseId) {
    return (select(localPurchasePayments)
          ..where((payment) => payment.purchaseId.equals(purchaseId))
          ..orderBy([(payment) => OrderingTerm.asc(payment.createdAt)]))
        .watch();
  }

  Stream<List<LocalSalesProduct>> watchSalesProductsForCurrentShop() {
    return customSelect(
      '''
      SELECT
        MIN(id) AS id,
        category_id,
        product_name,
        MAX(NULLIF(description, '')) AS description,
        SUM(quantity) AS stock_quantity,
        COALESCE(MAX(est_selling_price), MAX(buying_price), 0.0) AS selling_price
      FROM local_purchase_items
      WHERE shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
      GROUP BY COALESCE(category_id, product_name), product_name
      HAVING stock_quantity > 0
      ORDER BY product_name ASC
      ''',
      readsFrom: {localPurchaseItems, localUsers},
    ).watch().map(
      (rows) => rows
          .map(
            (row) => LocalSalesProduct(
              id: row.read<String>('id'),
              categoryId: row.readNullable<String>('category_id'),
              name: row.read<String>('product_name'),
              description: row.readNullable<String>('description'),
              stockQuantity: row.read<int>('stock_quantity'),
              sellingPrice: row.read<double>('selling_price'),
            ),
          )
          .toList(),
    );
  }

  Future<List<LocalPurchaseBundle>> getPendingPurchaseBundles() async {
    final pendingPurchases = await (select(
      localPurchases,
    )..where((purchase) => purchase.syncStatus.equals('pending'))).get();
    final bundles = <LocalPurchaseBundle>[];

    for (final purchase in pendingPurchases) {
      final items = await (select(
        localPurchaseItems,
      )..where((item) => item.purchaseId.equals(purchase.id))).get();
      final payments = await (select(
        localPurchasePayments,
      )..where((payment) => payment.purchaseId.equals(purchase.id))).get();
      bundles.add(
        LocalPurchaseBundle(
          purchase: purchase,
          items: items,
          payments: payments,
        ),
      );
    }

    return bundles;
  }

  Future<void> markPurchaseBundleSynced(String purchaseId) async {
    await transaction(() async {
      await (update(localPurchases)
            ..where((purchase) => purchase.id.equals(purchaseId)))
          .write(const LocalPurchasesCompanion(syncStatus: Value('synced')));
      await (update(
        localPurchaseItems,
      )..where((item) => item.purchaseId.equals(purchaseId))).write(
        const LocalPurchaseItemsCompanion(syncStatus: Value('synced')),
      );
      await (update(
        localPurchasePayments,
      )..where((payment) => payment.purchaseId.equals(purchaseId))).write(
        const LocalPurchasePaymentsCompanion(syncStatus: Value('synced')),
      );
    });
  }

  Future<LocalCategory?> _findCategoryByName({
    required String shopId,
    required String type,
    required String name,
    String? excludedId,
  }) {
    return (select(localCategories)
          ..where(
            (category) =>
                category.shopId.equals(shopId) &
                category.type.equals(type) &
                category.deletedAt.isNull() &
                (excludedId == null
                    ? const Constant(true)
                    : category.id.equals(excludedId).not()) &
                category.name.lower().equals(name.toLowerCase()),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  String? _nullableTrimmed(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }

    return trimmed;
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

class LocalPurchaseBundle {
  const LocalPurchaseBundle({
    required this.purchase,
    required this.items,
    required this.payments,
  });

  final LocalPurchase purchase;
  final List<LocalPurchaseItem> items;
  final List<LocalPurchasePayment> payments;
}

class LocalPurchaseBundleCompanion {
  const LocalPurchaseBundleCompanion({
    required this.purchase,
    required this.items,
    required this.payments,
  });

  final LocalPurchasesCompanion purchase;
  final List<LocalPurchaseItemsCompanion> items;
  final List<LocalPurchasePaymentsCompanion> payments;
}

class LocalPurchaseHistoryEntry {
  const LocalPurchaseHistoryEntry({
    required this.id,
    required this.supplierId,
    required this.supplierName,
    required this.total,
    required this.paidAmount,
    required this.itemCount,
    required this.status,
    required this.createdAt,
    required this.syncStatus,
  });

  final String id;
  final String supplierId;
  final String supplierName;
  final double total;
  final double paidAmount;
  final int itemCount;
  final String status;
  final DateTime createdAt;
  final String syncStatus;

  double get dueAmount => total - paidAmount;
}

class LocalSalesProduct {
  const LocalSalesProduct({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.stockQuantity,
    required this.sellingPrice,
  });

  final String id;
  final String? categoryId;
  final String name;
  final String? description;
  final int stockQuantity;
  final double sellingPrice;
}
