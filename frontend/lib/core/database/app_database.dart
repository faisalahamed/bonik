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

class LocalCustomers extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get name => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalSales extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get customerId => text().references(LocalCustomers, #id)();
  RealColumn get subtotal => real()();
  RealColumn get discount => real().withDefault(const Constant(0))();
  RealColumn get vat => real().withDefault(const Constant(0))();
  RealColumn get total => real()();
  TextColumn get status => text().withDefault(const Constant('completed'))();
  TextColumn get paymentMethod => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalSaleItems extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get orderId => text().references(LocalSales, #id)();
  TextColumn get productId => text().references(LocalPurchaseItems, #id)();
  RealColumn get buyPrice => real()();
  RealColumn get salePrice => real()();
  IntColumn get quantity => integer().withDefault(const Constant(0))();
  RealColumn get price => real()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalCustomerPayments extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get customerId => text().references(LocalCustomers, #id)();
  TextColumn get orderId => text().references(LocalSales, #id)();
  RealColumn get payments => real()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalCashTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get type => text()();
  TextColumn get direction => text()();
  RealColumn get amount => real().withDefault(const Constant(0))();
  TextColumn get referenceId => text().nullable()();
  TextColumn get referenceType => text().nullable()();
  TextColumn get method => text().nullable()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalExpenses extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get categoryId => text().references(LocalCategories, #id)();
  RealColumn get amount => real().withDefault(const Constant(0))();
  TextColumn get reason => text().nullable()();
  TextColumn get note => text().nullable()();
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
    LocalCustomers,
    LocalSales,
    LocalSaleItems,
    LocalCustomerPayments,
    LocalCashTransactions,
    LocalExpenses,
  ],
)
final class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'bonik'));

  @override
  int get schemaVersion => 10;

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
      if (from < 7) {
        await migrator.createTable(localCustomers);
        await migrator.createTable(localSales);
        await migrator.createTable(localSaleItems);
        await migrator.createTable(localCustomerPayments);
        await migrator.createTable(localCashTransactions);
      }
      if (from < 8) {
        await migrator.createTable(localExpenses);
      }
      if (from >= 8 && from < 9) {
        await migrator.addColumn(localExpenses, localExpenses.amount);
        await migrator.addColumn(localExpenses, localExpenses.reason);
        await migrator.addColumn(localExpenses, localExpenses.note);
        await customStatement(
          'UPDATE local_expenses SET amount = total WHERE amount = 0',
        );
        await customStatement('''
          UPDATE local_expenses
          SET note = COALESCE(
            note,
            (
              SELECT lei.note
              FROM local_expense_items lei
              WHERE lei.shop_id = local_expenses.shop_id
                AND lei.category_id = local_expenses.category_id
                AND lei.amount = local_expenses.amount
                AND lei.created_at = local_expenses.created_at
              LIMIT 1
            )
          )
        ''');
        await customStatement('''
          INSERT OR IGNORE INTO local_expenses (
            id,
            shop_id,
            category_id,
            amount,
            reason,
            note,
            created_at,
            updated_at,
            sync_status
          )
          SELECT
            id,
            shop_id,
            category_id,
            amount,
            NULL,
            note,
            created_at,
            updated_at,
            sync_status
          FROM local_expense_items
        ''');
        await customStatement('DROP TABLE IF EXISTS local_expense_items');
      }
      if (from >= 8 && from < 10) {
        final expenseColumns = await customSelect(
          'PRAGMA table_info(local_expenses)',
        ).get();
        final hasTotalColumn = expenseColumns.any(
          (row) => row.data['name'] == 'total',
        );
        final amountExpression = hasTotalColumn
            ? '''
            CASE
              WHEN amount = 0 THEN total
              ELSE amount
            END
            '''
            : 'amount';

        await customStatement('''
          CREATE TABLE local_expenses_v10 (
            id TEXT NOT NULL PRIMARY KEY,
            shop_id TEXT NOT NULL REFERENCES local_shops (id),
            category_id TEXT NOT NULL REFERENCES local_categories (id),
            amount REAL NOT NULL DEFAULT 0,
            reason TEXT NULL,
            note TEXT NULL,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL,
            sync_status TEXT NOT NULL DEFAULT 'pending'
          )
        ''');
        await customStatement('''
          INSERT OR REPLACE INTO local_expenses_v10 (
            id,
            shop_id,
            category_id,
            amount,
            reason,
            note,
            created_at,
            updated_at,
            sync_status
          )
          SELECT
            id,
            shop_id,
            category_id,
            $amountExpression,
            reason,
            note,
            created_at,
            updated_at,
            sync_status
          FROM local_expenses
        ''');
        await customStatement('DROP TABLE local_expenses');
        await customStatement(
          'ALTER TABLE local_expenses_v10 RENAME TO local_expenses',
        );
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
      WITH current_shop AS (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
        LIMIT 1
      )
      SELECT EXISTS(
        SELECT 1
        FROM local_shops
        WHERE sync_status != 'synced'
          AND id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_users
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_categories
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_suppliers
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_purchases
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_purchase_items
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_purchase_payments
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_customers
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_sales
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_sale_items
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_customer_payments
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_cash_transactions
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_expenses
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
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
        localCustomers,
        localSales,
        localSaleItems,
        localCustomerPayments,
        localCashTransactions,
        localExpenses,
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

  Stream<List<LocalCategory>> watchExpenseCategoriesForCurrentShop() {
    final currentShopIds = selectOnly(localUsers)
      ..addColumns([localUsers.shopId])
      ..where(localUsers.isCurrent.equals(true));

    return (select(localCategories)
          ..where(
            (category) =>
                category.type.equals('expense') &
                category.deletedAt.isNull() &
                category.shopId.isInQuery(currentShopIds),
          )
          ..orderBy([(category) => OrderingTerm.asc(category.name)]))
        .watch();
  }

  Stream<double> watchTodayExpenseTotalForCurrentShop() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));

    return customSelect(
      '''
      SELECT COALESCE(SUM(amount), 0.0) AS total
      FROM local_expenses
      WHERE shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
        AND created_at >= ?
        AND created_at < ?
      ''',
      variables: [Variable<DateTime>(start), Variable<DateTime>(end)],
      readsFrom: {localExpenses, localUsers},
    ).watchSingle().map((row) => row.read<double>('total'));
  }

  Stream<List<LocalExpenseHistoryEntry>> watchExpenseHistoryForCurrentShop() {
    return customSelect(
      '''
      SELECT
        e.id,
        e.category_id,
        COALESCE(c.name, 'ব্যয়') AS category_name,
        e.amount,
        e.reason,
        e.note,
        e.created_at,
        e.sync_status
      FROM local_expenses e
      LEFT JOIN local_categories c ON c.id = e.category_id
      WHERE e.shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
      ORDER BY e.created_at DESC
      ''',
      readsFrom: {localExpenses, localCategories, localUsers},
    ).watch().map(
      (rows) => [
        for (final row in rows)
          LocalExpenseHistoryEntry(
            id: row.read<String>('id'),
            categoryId: row.read<String>('category_id'),
            categoryName: row.read<String>('category_name'),
            amount: row.read<double>('amount'),
            reason: row.readNullable<String>('reason'),
            note: row.readNullable<String>('note'),
            createdAt: row.read<DateTime>('created_at'),
            syncStatus: row.read<String>('sync_status'),
          ),
      ],
    );
  }

  Future<LocalCategory> createExpenseCategory(
    String name, {
    String? details,
  }) async {
    return _createCategory(name, type: 'expense', details: details);
  }

  Future<void> updateExpenseCategory({
    required String id,
    required String name,
    String? details,
  }) async {
    await _updateCategory(id: id, name: name, details: details);
  }

  Future<void> deleteExpenseCategory(String id) async {
    await _softDeleteCategory(id);
  }

  Future<String> saveExpenseLocally({
    required String categoryName,
    required double amount,
    required String reason,
    required String note,
    required DateTime expenseDate,
  }) async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw StateError('No current user found.');
    }
    if (amount <= 0) {
      throw StateError('Expense amount is required.');
    }

    final category = await _findCategoryByName(
      shopId: currentUser.shopId,
      type: 'expense',
      name: categoryName,
    );
    if (category == null) {
      throw StateError('Expense category not found.');
    }

    final expenseId = const Uuid().v4();
    final cashTransactionId = const Uuid().v4();
    final now = DateTime.now();
    final trimmedReason = _nullableTrimmed(reason);
    final trimmedNote = _nullableTrimmed(note);

    await transaction(() async {
      await into(localExpenses).insert(
        LocalExpensesCompanion(
          id: Value(expenseId),
          shopId: Value(currentUser.shopId),
          categoryId: Value(category.id),
          amount: Value(amount),
          reason: Value(trimmedReason),
          note: Value(trimmedNote),
          createdAt: Value(expenseDate),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await into(localCashTransactions).insert(
        LocalCashTransactionsCompanion(
          id: Value(cashTransactionId),
          shopId: Value(currentUser.shopId),
          type: const Value('expense'),
          direction: const Value('out'),
          amount: Value(amount),
          referenceId: Value(expenseId),
          referenceType: const Value('expense'),
          method: const Value('cash'),
          note: Value(trimmedReason ?? trimmedNote ?? category.name),
          createdAt: Value(expenseDate),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });

    return expenseId;
  }

  Future<LocalCategory> createProductCategory(
    String name, {
    String? details,
  }) async {
    return _createCategory(name, type: 'product', details: details);
  }

  Future<LocalCategory> _createCategory(
    String name, {
    required String type,
    String? details,
  }) async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw StateError('No current user found.');
    }

    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      throw StateError('Category name is required.');
    }
    final existingCategory = await _findCategoryByName(
      shopId: currentUser.shopId,
      type: type,
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
      type: Value(type),
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
    await _updateCategory(id: id, name: name, details: details);
  }

  Future<void> _updateCategory({
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
    if (trimmedName.isEmpty) {
      throw StateError('Category name is required.');
    }
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
    await _softDeleteCategory(id);
  }

  Future<void> _softDeleteCategory(String id) async {
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

  Future<List<LocalCategory>> getPendingProductCategories({String? shopId}) {
    return (select(localCategories)..where(
          (category) =>
              category.type.equals('product') &
              category.syncStatus.equals('pending') &
              (shopId == null
                  ? const Constant(true)
                  : category.shopId.equals(shopId)),
        ))
        .get();
  }

  Future<List<LocalCategory>> getPendingCategories({String? shopId}) {
    return (select(localCategories)..where(
          (category) =>
              category.syncStatus.equals('pending') &
              (shopId == null
                  ? const Constant(true)
                  : category.shopId.equals(shopId)),
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

  Future<List<LocalSupplier>> getPendingSuppliers({String? shopId}) {
    return (select(localSuppliers)..where(
          (supplier) =>
              supplier.syncStatus.equals('pending') &
              (shopId == null
                  ? const Constant(true)
                  : supplier.shopId.equals(shopId)),
        ))
        .get();
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
    required LocalCashTransactionsCompanion? cashTransaction,
  }) async {
    await transaction(() async {
      await into(localPurchases).insertOnConflictUpdate(purchase);
      for (final item in items) {
        await into(localPurchaseItems).insertOnConflictUpdate(item);
      }
      if (payment != null) {
        await into(localPurchasePayments).insertOnConflictUpdate(payment);
      }
      if (cashTransaction != null) {
        await into(
          localCashTransactions,
        ).insertOnConflictUpdate(cashTransaction);
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
        for (final cashTransaction in bundle.cashTransactions) {
          await into(
            localCashTransactions,
          ).insertOnConflictUpdate(cashTransaction);
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

  Stream<List<LocalSalesHistoryEntry>> watchSalesHistoryForCurrentShop() {
    return customSelect(
      '''
      SELECT
        s.id,
        s.customer_id,
        COALESCE(c.name, 'Walk-in Customer') AS customer_name,
        COALESCE(c.phone, '') AS customer_phone,
        s.subtotal,
        s.discount,
        s.vat,
        s.total,
        s.status,
        s.payment_method,
        s.created_at,
        s.sync_status,
        COALESCE((
          SELECT SUM(payments)
          FROM local_customer_payments
          WHERE order_id = s.id
        ), 0.0) AS paid_amount,
        COALESCE((
          SELECT COUNT(*)
          FROM local_sale_items
          WHERE order_id = s.id
        ), 0) AS item_count
      FROM local_sales s
      LEFT JOIN local_customers c ON c.id = s.customer_id
      WHERE s.shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
      ORDER BY s.created_at DESC
      ''',
      readsFrom: {
        localSales,
        localCustomers,
        localCustomerPayments,
        localSaleItems,
        localUsers,
      },
    ).watch().map(
      (rows) => rows
          .map(
            (row) => LocalSalesHistoryEntry(
              id: row.read<String>('id'),
              customerId: row.read<String>('customer_id'),
              customerName: row.read<String>('customer_name'),
              customerPhone: row.read<String>('customer_phone'),
              subtotal: row.read<double>('subtotal'),
              discount: row.read<double>('discount'),
              vat: row.read<double>('vat'),
              total: row.read<double>('total'),
              paidAmount: row.read<double>('paid_amount'),
              itemCount: row.read<int>('item_count'),
              status: row.read<String>('status'),
              paymentMethod: row.readNullable<String>('payment_method'),
              createdAt: row.read<DateTime>('created_at'),
              syncStatus: row.read<String>('sync_status'),
            ),
          )
          .toList(),
    );
  }

  Stream<LocalDuesSummary> watchDuesSummaryForCurrentShop() {
    return customSelect(
      '''
      SELECT
        COALESCE((
          SELECT SUM(
            CASE
              WHEN (s.total - COALESCE((
                SELECT SUM(cp.payments)
                FROM local_customer_payments cp
                WHERE cp.order_id = s.id
              ), 0.0)) > 0
              THEN (s.total - COALESCE((
                SELECT SUM(cp.payments)
                FROM local_customer_payments cp
                WHERE cp.order_id = s.id
              ), 0.0))
              ELSE 0
            END
          )
          FROM local_sales s
          WHERE s.shop_id IN (
            SELECT shop_id
            FROM local_users
            WHERE is_current = 1
          )
        ), 0.0) AS receivable,
        COALESCE((
          SELECT SUM(
            CASE
              WHEN (p.total - COALESCE((
                SELECT SUM(pp.payments)
                FROM local_purchase_payments pp
                WHERE pp.purchase_id = p.id
              ), 0.0)) > 0
              THEN (p.total - COALESCE((
                SELECT SUM(pp.payments)
                FROM local_purchase_payments pp
                WHERE pp.purchase_id = p.id
              ), 0.0))
              ELSE 0
            END
          )
          FROM local_purchases p
          WHERE p.shop_id IN (
            SELECT shop_id
            FROM local_users
            WHERE is_current = 1
          )
        ), 0.0) AS payable
      ''',
      readsFrom: {
        localSales,
        localCustomerPayments,
        localPurchases,
        localPurchasePayments,
        localUsers,
      },
    ).watchSingle().map(
      (row) => LocalDuesSummary(
        receivable: row.read<double>('receivable'),
        payable: row.read<double>('payable'),
      ),
    );
  }

  Stream<List<LocalDuesLedgerEntry>> watchDuesLedgerForCurrentShop() {
    return customSelect(
      '''
      SELECT *
      FROM (
        SELECT
          s.id AS id,
          'receivable' AS type,
          s.customer_id AS party_id,
          COALESCE(c.name, 'Walk-in Customer') AS name,
          COALESCE(c.phone, '') AS phone,
          (s.total - COALESCE((
            SELECT SUM(cp.payments)
            FROM local_customer_payments cp
            WHERE cp.order_id = s.id
          ), 0.0)) AS due_amount,
          s.created_at AS created_at,
          s.sync_status AS sync_status
        FROM local_sales s
        LEFT JOIN local_customers c ON c.id = s.customer_id
        WHERE s.shop_id IN (
          SELECT shop_id
          FROM local_users
          WHERE is_current = 1
        )

        UNION ALL

        SELECT
          p.id AS id,
          'payable' AS type,
          p.supplier_id AS party_id,
          COALESCE(sup.name, 'সাপ্লায়ার') AS name,
          COALESCE(sup.mobile, '') AS phone,
          (p.total - COALESCE((
            SELECT SUM(pp.payments)
            FROM local_purchase_payments pp
            WHERE pp.purchase_id = p.id
          ), 0.0)) AS due_amount,
          p.created_at AS created_at,
          p.sync_status AS sync_status
        FROM local_purchases p
        LEFT JOIN local_suppliers sup ON sup.id = p.supplier_id
        WHERE p.shop_id IN (
          SELECT shop_id
          FROM local_users
          WHERE is_current = 1
        )
      ) ledger
      WHERE due_amount > 0
      ORDER BY created_at DESC
      ''',
      readsFrom: {
        localSales,
        localCustomers,
        localCustomerPayments,
        localPurchases,
        localSuppliers,
        localPurchasePayments,
        localUsers,
      },
    ).watch().map(
      (rows) => [
        for (final row in rows)
          LocalDuesLedgerEntry(
            id: row.read<String>('id'),
            type: row.read<String>('type'),
            partyId: row.read<String>('party_id'),
            name: row.read<String>('name'),
            phone: row.read<String>('phone'),
            dueAmount: row.read<double>('due_amount'),
            createdAt: row.read<DateTime>('created_at'),
            syncStatus: row.read<String>('sync_status'),
          ),
      ],
    );
  }

  Stream<List<LocalDueHistoryEntry>> watchDueHistoryForLedgerEntry(
    LocalDuesLedgerEntry entry,
  ) {
    final query = entry.isReceivable
        ? '''
      SELECT id, total AS amount, created_at, 'sale' AS source_type
      FROM local_sales
      WHERE id = ?

      UNION ALL

      SELECT id, payments AS amount, created_at, 'customer_payment' AS source_type
      FROM local_customer_payments
      WHERE order_id = ?
      '''
        : '''
      SELECT id, total AS amount, created_at, 'purchase' AS source_type
      FROM local_purchases
      WHERE id = ?

      UNION ALL

      SELECT id, payments AS amount, created_at, 'purchase_payment' AS source_type
      FROM local_purchase_payments
      WHERE purchase_id = ?
      ''';

    return customSelect(
      query,
      variables: [Variable<String>(entry.id), Variable<String>(entry.id)],
      readsFrom: entry.isReceivable
          ? {localSales, localCustomerPayments}
          : {localPurchases, localPurchasePayments},
    ).watch().map((rows) {
      final entries = [
        for (final row in rows)
          LocalDueHistoryEntry(
            id: row.read<String>('id'),
            sourceType: row.read<String>('source_type'),
            amount: row.read<double>('amount'),
            createdAt: row.read<DateTime>('created_at'),
          ),
      ]..sort((a, b) => a.createdAt.compareTo(b.createdAt));

      var balance = 0.0;
      final withBalance = <LocalDueHistoryEntry>[];
      for (final item in entries) {
        final increasesDue = entry.isReceivable
            ? item.sourceType == 'sale'
            : item.sourceType == 'purchase';
        balance += increasesDue ? item.amount : -item.amount;
        withBalance.add(item.copyWith(balance: balance < 0 ? 0 : balance));
      }

      return withBalance.reversed.toList();
    });
  }

  Future<void> saveDueGivingPayment({
    required LocalDuesLedgerEntry entry,
    required double amount,
    required DateTime paymentDate,
    String? note,
  }) async {
    if (entry.isReceivable) {
      throw StateError('পাওনা আদায়ের জন্য নিচ্ছি ব্যবহার করুন।');
    }
    if (amount <= 0) {
      throw StateError('টাকার পরিমাণ দিন।');
    }
    if (amount > entry.dueAmount) {
      throw StateError('দেনার চেয়ে বেশি টাকা দেয়া যাবে না।');
    }

    final purchase = await (select(
      localPurchases,
    )..where((table) => table.id.equals(entry.id))).getSingleOrNull();
    if (purchase == null) {
      throw StateError('কেনার তথ্য পাওয়া যায়নি।');
    }

    final paymentId = const Uuid().v4();
    final cashTransactionId = const Uuid().v4();
    final now = DateTime.now();
    final trimmedNote = _nullableTrimmed(note);

    await transaction(() async {
      await into(localPurchasePayments).insert(
        LocalPurchasePaymentsCompanion(
          id: Value(paymentId),
          shopId: Value(purchase.shopId),
          purchaseId: Value(purchase.id),
          payments: Value(amount),
          description: Value(trimmedNote ?? 'বাকি পরিশোধ'),
          createdAt: Value(paymentDate),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await into(localCashTransactions).insert(
        LocalCashTransactionsCompanion(
          id: Value(cashTransactionId),
          shopId: Value(purchase.shopId),
          type: const Value('purchase_payment'),
          direction: const Value('out'),
          amount: Value(amount),
          referenceId: Value(purchase.id),
          referenceType: const Value('purchase'),
          method: const Value('cash'),
          note: Value(trimmedNote ?? 'বাকি পরিশোধ'),
          createdAt: Value(paymentDate),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await (update(
        localPurchases,
      )..where((table) => table.id.equals(entry.id))).write(
        LocalPurchasesCompanion(
          status: Value(
            amount >= entry.dueAmount ? 'completed' : purchase.status,
          ),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });
  }

  Future<void> saveDueTakingPayment({
    required LocalDuesLedgerEntry entry,
    required double amount,
    required DateTime paymentDate,
    String? note,
  }) async {
    if (!entry.isReceivable) {
      throw StateError('দেনা পরিশোধের জন্য দিচ্ছি ব্যবহার করুন।');
    }
    if (amount <= 0) {
      throw StateError('টাকার পরিমাণ দিন।');
    }
    if (amount > entry.dueAmount) {
      throw StateError('পাওনার চেয়ে বেশি টাকা নেয়া যাবে না।');
    }

    final sale = await (select(
      localSales,
    )..where((table) => table.id.equals(entry.id))).getSingleOrNull();
    if (sale == null) {
      throw StateError('বিক্রির তথ্য পাওয়া যায়নি।');
    }

    final paymentId = const Uuid().v4();
    final cashTransactionId = const Uuid().v4();
    final now = DateTime.now();
    final trimmedNote = _nullableTrimmed(note);

    await transaction(() async {
      await into(localCustomerPayments).insert(
        LocalCustomerPaymentsCompanion(
          id: Value(paymentId),
          shopId: Value(sale.shopId),
          customerId: Value(sale.customerId),
          orderId: Value(sale.id),
          payments: Value(amount),
          description: Value(trimmedNote ?? 'বাকি আদায়'),
          createdAt: Value(paymentDate),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await into(localCashTransactions).insert(
        LocalCashTransactionsCompanion(
          id: Value(cashTransactionId),
          shopId: Value(sale.shopId),
          type: const Value('customer_payment'),
          direction: const Value('in'),
          amount: Value(amount),
          referenceId: Value(sale.id),
          referenceType: const Value('sale'),
          method: const Value('cash'),
          note: Value(trimmedNote ?? 'বাকি আদায়'),
          createdAt: Value(paymentDate),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await (update(
        localSales,
      )..where((table) => table.id.equals(entry.id))).write(
        LocalSalesCompanion(
          status: Value(amount >= entry.dueAmount ? 'completed' : sale.status),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });
  }

  Stream<LocalSale?> watchSaleById(String id) {
    return (select(
      localSales,
    )..where((sale) => sale.id.equals(id))).watchSingleOrNull();
  }

  Stream<LocalCustomer?> watchCustomerById(String id) {
    return (select(
      localCustomers,
    )..where((customer) => customer.id.equals(id))).watchSingleOrNull();
  }

  Stream<List<LocalSaleItemDetail>> watchSaleItemDetails(String saleId) {
    return customSelect(
      '''
      SELECT
        si.id,
        si.shop_id,
        si.order_id,
        si.product_id,
        si.buy_price,
        si.sale_price,
        si.quantity,
        si.price,
        si.created_at,
        si.updated_at,
        si.sync_status,
        COALESCE(pi.product_name, 'পণ্য') AS product_name,
        pi.description AS description
      FROM local_sale_items si
      LEFT JOIN local_purchase_items pi ON pi.id = si.product_id
      WHERE si.order_id = ?
      ORDER BY si.created_at ASC
      ''',
      variables: [Variable<String>(saleId)],
      readsFrom: {localSaleItems, localPurchaseItems},
    ).watch().map(
      (rows) => rows
          .map(
            (row) => LocalSaleItemDetail(
              id: row.read<String>('id'),
              shopId: row.read<String>('shop_id'),
              orderId: row.read<String>('order_id'),
              productId: row.read<String>('product_id'),
              buyPrice: row.read<double>('buy_price'),
              salePrice: row.read<double>('sale_price'),
              quantity: row.read<int>('quantity'),
              price: row.read<double>('price'),
              createdAt: row.read<DateTime>('created_at'),
              updatedAt: row.read<DateTime>('updated_at'),
              syncStatus: row.read<String>('sync_status'),
              productName: row.read<String>('product_name'),
              description: row.readNullable<String>('description'),
            ),
          )
          .toList(),
    );
  }

  Stream<List<LocalCustomerPayment>> watchCustomerPayments(String saleId) {
    return (select(localCustomerPayments)
          ..where((payment) => payment.orderId.equals(saleId))
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
        SUM(
          quantity - COALESCE((
            SELECT SUM(si.quantity)
            FROM local_sale_items si
            WHERE si.product_id = local_purchase_items.id
          ), 0)
        ) AS stock_quantity,
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
      readsFrom: {localPurchaseItems, localSaleItems, localUsers},
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

  Future<LocalCustomer> getOrCreateCustomer({
    required String shopId,
    required String name,
    String? phone,
  }) async {
    final trimmedName = name.trim().isEmpty ? 'Walk-in Customer' : name.trim();
    final trimmedPhone = _nullableTrimmed(phone);

    if (trimmedPhone != null) {
      final existingByPhone =
          await (select(localCustomers)
                ..where(
                  (customer) =>
                      customer.shopId.equals(shopId) &
                      customer.phone.equals(trimmedPhone),
                )
                ..limit(1))
              .getSingleOrNull();
      if (existingByPhone != null) {
        return existingByPhone;
      }
    }

    final existing =
        await (select(localCustomers)
              ..where(
                (customer) =>
                    customer.shopId.equals(shopId) &
                    customer.name.lower().equals(trimmedName.toLowerCase()) &
                    (trimmedPhone == null
                        ? customer.phone.isNull()
                        : customer.phone.equals(trimmedPhone)),
              )
              ..limit(1))
            .getSingleOrNull();
    if (existing != null) {
      return existing;
    }

    final now = DateTime.now();
    final id = const Uuid().v4();
    await into(localCustomers).insert(
      LocalCustomersCompanion(
        id: Value(id),
        shopId: Value(shopId),
        name: Value(trimmedName),
        phone: Value(trimmedPhone),
        createdAt: Value(now),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );

    return (select(
      localCustomers,
    )..where((customer) => customer.id.equals(id))).getSingle();
  }

  Future<List<LocalAvailablePurchaseBatch>> getAvailablePurchaseBatches({
    required String shopId,
    required String productName,
    required String? categoryId,
  }) {
    return customSelect(
      '''
      SELECT
        pi.id,
        pi.shop_id,
        pi.category_id,
        pi.product_name,
        pi.buying_price,
        COALESCE(pi.est_selling_price, pi.buying_price, 0.0) AS selling_price,
        pi.quantity - COALESCE((
          SELECT SUM(si.quantity)
          FROM local_sale_items si
          WHERE si.product_id = pi.id
        ), 0) AS available_quantity,
        pi.created_at
      FROM local_purchase_items pi
      WHERE pi.shop_id = ?
        AND pi.product_name = ?
        AND (
          (? = 1 AND pi.category_id IS NULL)
          OR pi.category_id = ?
        )
        AND (
          pi.quantity - COALESCE((
            SELECT SUM(si.quantity)
            FROM local_sale_items si
            WHERE si.product_id = pi.id
          ), 0)
        ) > 0
      ORDER BY pi.created_at ASC
      ''',
      variables: [
        Variable<String>(shopId),
        Variable<String>(productName),
        Variable<int>(categoryId == null ? 1 : 0),
        Variable<String>(categoryId ?? ''),
      ],
      readsFrom: {localPurchaseItems, localSaleItems},
    ).get().then(
      (rows) => rows
          .map(
            (row) => LocalAvailablePurchaseBatch(
              id: row.read<String>('id'),
              shopId: row.read<String>('shop_id'),
              categoryId: row.readNullable<String>('category_id'),
              productName: row.read<String>('product_name'),
              buyingPrice: row.read<double>('buying_price'),
              sellingPrice: row.read<double>('selling_price'),
              availableQuantity: row.read<int>('available_quantity'),
              createdAt: row.read<DateTime>('created_at'),
            ),
          )
          .toList(),
    );
  }

  Future<void> insertSaleBundle({
    required LocalSalesCompanion sale,
    required LocalCustomersCompanion customer,
    required List<LocalSaleItemsCompanion> items,
    required LocalCustomerPaymentsCompanion? payment,
    required LocalCashTransactionsCompanion? cashTransaction,
  }) async {
    await transaction(() async {
      await into(localCustomers).insertOnConflictUpdate(customer);
      await into(localSales).insertOnConflictUpdate(sale);
      for (final item in items) {
        await into(localSaleItems).insertOnConflictUpdate(item);
      }
      if (payment != null) {
        await into(localCustomerPayments).insertOnConflictUpdate(payment);
      }
      if (cashTransaction != null) {
        await into(
          localCashTransactions,
        ).insertOnConflictUpdate(cashTransaction);
      }
    });
  }

  Future<List<LocalCustomer>> getPendingCustomers({String? shopId}) {
    return (select(localCustomers)..where(
          (customer) =>
              customer.syncStatus.equals('pending') &
              (shopId == null
                  ? const Constant(true)
                  : customer.shopId.equals(shopId)),
        ))
        .get();
  }

  Future<void> markCustomerSynced(String id) async {
    await (update(localCustomers)..where((customer) => customer.id.equals(id)))
        .write(const LocalCustomersCompanion(syncStatus: Value('synced')));
  }

  Future<void> mergeCustomerId({
    required String localId,
    required LocalCustomersCompanion syncedCustomer,
    required String syncedId,
  }) {
    return transaction(() async {
      await into(localCustomers).insertOnConflictUpdate(syncedCustomer);
      await (update(localSales)
            ..where((sale) => sale.customerId.equals(localId)))
          .write(LocalSalesCompanion(customerId: Value(syncedId)));
      await (update(localCustomerPayments)
            ..where((payment) => payment.customerId.equals(localId)))
          .write(LocalCustomerPaymentsCompanion(customerId: Value(syncedId)));
      await (delete(
        localCustomers,
      )..where((customer) => customer.id.equals(localId))).go();
    });
  }

  Future<void> upsertSyncedCustomers(List<LocalCustomersCompanion> rows) async {
    await transaction(() async {
      for (final row in rows) {
        await into(localCustomers).insertOnConflictUpdate(row);
      }
    });
  }

  Future<List<LocalSaleBundle>> getPendingSaleBundles({String? shopId}) async {
    final pendingSaleIds = await customSelect(
      '''
      SELECT s.id
      FROM local_sales s
      WHERE (?1 IS NULL OR s.shop_id = ?1)
        AND (
          s.sync_status != 'synced'
        OR EXISTS (
          SELECT 1 FROM local_sale_items si
          WHERE si.order_id = s.id AND si.sync_status != 'synced'
        )
        OR EXISTS (
          SELECT 1 FROM local_customer_payments cp
          WHERE cp.order_id = s.id AND cp.sync_status != 'synced'
        )
        OR EXISTS (
          SELECT 1 FROM local_cash_transactions ct
          WHERE ct.reference_id = s.id
            AND ct.type IN ('sale', 'customer_payment')
            AND ct.sync_status != 'synced'
        )
        )
      ''',
      variables: [Variable<String>(shopId)],
      readsFrom: {
        localSales,
        localSaleItems,
        localCustomerPayments,
        localCashTransactions,
      },
    ).get();
    final saleIds = pendingSaleIds
        .map((row) => row.read<String>('id'))
        .toList(growable: false);
    if (saleIds.isEmpty) {
      return [];
    }

    final pendingSales = await (select(
      localSales,
    )..where((sale) => sale.id.isIn(saleIds))).get();
    final bundles = <LocalSaleBundle>[];

    for (final sale in pendingSales) {
      final items = await (select(
        localSaleItems,
      )..where((item) => item.orderId.equals(sale.id))).get();
      final payments = await (select(
        localCustomerPayments,
      )..where((payment) => payment.orderId.equals(sale.id))).get();
      final cashTransactions =
          await (select(localCashTransactions)..where(
                (transaction) =>
                    transaction.referenceId.equals(sale.id) &
                    transaction.type.isIn(['sale', 'customer_payment']) &
                    transaction.syncStatus.equals('pending'),
              ))
              .get();
      bundles.add(
        LocalSaleBundle(
          sale: sale,
          items: items,
          payments: payments,
          cashTransactions: cashTransactions,
        ),
      );
    }

    return bundles;
  }

  Future<void> markSaleBundleSynced(String saleId) async {
    await transaction(() async {
      await (update(localSales)..where((sale) => sale.id.equals(saleId))).write(
        const LocalSalesCompanion(syncStatus: Value('synced')),
      );
      await (update(localSaleItems)
            ..where((item) => item.orderId.equals(saleId)))
          .write(const LocalSaleItemsCompanion(syncStatus: Value('synced')));
      await (update(
        localCustomerPayments,
      )..where((payment) => payment.orderId.equals(saleId))).write(
        const LocalCustomerPaymentsCompanion(syncStatus: Value('synced')),
      );
      await (update(localCashTransactions)..where(
            (transaction) =>
                transaction.referenceId.equals(saleId) &
                transaction.type.isIn(['sale', 'customer_payment']),
          ))
          .write(
            const LocalCashTransactionsCompanion(syncStatus: Value('synced')),
          );
    });
  }

  Future<void> upsertSyncedSaleBundles(List<LocalSaleBundleCompanion> bundles) {
    return transaction(() async {
      for (final bundle in bundles) {
        await into(localSales).insertOnConflictUpdate(bundle.sale);
        for (final item in bundle.items) {
          await into(localSaleItems).insertOnConflictUpdate(item);
        }
        for (final payment in bundle.payments) {
          await into(localCustomerPayments).insertOnConflictUpdate(payment);
        }
        for (final cashTransaction in bundle.cashTransactions) {
          await into(
            localCashTransactions,
          ).insertOnConflictUpdate(cashTransaction);
        }
      }
    });
  }

  Future<LocalExpenseSyncBundle> getPendingExpenseSyncBundle({
    String? shopId,
  }) async {
    final expenses =
        await (select(localExpenses)..where(
              (expense) =>
                  expense.syncStatus.equals('pending') &
                  (shopId == null
                      ? const Constant(true)
                      : expense.shopId.equals(shopId)),
            ))
            .get();
    final cashTransactions =
        await (select(localCashTransactions)..where(
              (transaction) =>
                  transaction.type.equals('expense') &
                  transaction.syncStatus.equals('pending') &
                  (shopId == null
                      ? const Constant(true)
                      : transaction.shopId.equals(shopId)),
            ))
            .get();

    return LocalExpenseSyncBundle(
      expenses: expenses,
      cashTransactions: cashTransactions,
    );
  }

  Future<void> markExpenseSyncBundleSynced(
    LocalExpenseSyncBundle bundle,
  ) async {
    await transaction(() async {
      for (final expense in bundle.expenses) {
        await (update(localExpenses)
              ..where((table) => table.id.equals(expense.id)))
            .write(const LocalExpensesCompanion(syncStatus: Value('synced')));
      }
      for (final cashTransaction in bundle.cashTransactions) {
        await (update(
          localCashTransactions,
        )..where((table) => table.id.equals(cashTransaction.id))).write(
          const LocalCashTransactionsCompanion(syncStatus: Value('synced')),
        );
      }
    });
  }

  Future<void> upsertSyncedExpenseData({
    required List<LocalExpensesCompanion> expenses,
    required List<LocalCashTransactionsCompanion> cashTransactions,
  }) {
    return transaction(() async {
      for (final expense in expenses) {
        await into(localExpenses).insertOnConflictUpdate(expense);
      }
      for (final cashTransaction in cashTransactions) {
        await into(
          localCashTransactions,
        ).insertOnConflictUpdate(cashTransaction);
      }
    });
  }

  Future<List<LocalPurchaseBundle>> getPendingPurchaseBundles({
    String? shopId,
  }) async {
    await ensurePurchasePaymentCashTransactions(shopId: shopId);

    final pendingPurchaseIds = await customSelect(
      '''
      SELECT p.id
      FROM local_purchases p
      WHERE (?1 IS NULL OR p.shop_id = ?1)
        AND (
          p.sync_status != 'synced'
        OR EXISTS (
          SELECT 1 FROM local_purchase_items pi
          WHERE pi.purchase_id = p.id AND pi.sync_status != 'synced'
        )
        OR EXISTS (
          SELECT 1 FROM local_purchase_payments pp
          WHERE pp.purchase_id = p.id AND pp.sync_status != 'synced'
        )
        OR EXISTS (
          SELECT 1 FROM local_cash_transactions ct
          WHERE ct.reference_id = p.id
            AND ct.type = 'purchase_payment'
            AND ct.sync_status != 'synced'
        )
        )
      ''',
      variables: [Variable<String>(shopId)],
      readsFrom: {
        localPurchases,
        localPurchaseItems,
        localPurchasePayments,
        localCashTransactions,
      },
    ).get();
    final purchaseIds = pendingPurchaseIds
        .map((row) => row.read<String>('id'))
        .toList(growable: false);
    if (purchaseIds.isEmpty) {
      return [];
    }

    final pendingPurchases = await (select(
      localPurchases,
    )..where((purchase) => purchase.id.isIn(purchaseIds))).get();
    final bundles = <LocalPurchaseBundle>[];

    for (final purchase in pendingPurchases) {
      final items = await (select(
        localPurchaseItems,
      )..where((item) => item.purchaseId.equals(purchase.id))).get();
      final payments = await (select(
        localPurchasePayments,
      )..where((payment) => payment.purchaseId.equals(purchase.id))).get();
      final cashTransactions =
          await (select(localCashTransactions)..where(
                (cashTransaction) =>
                    cashTransaction.referenceId.equals(purchase.id) &
                    cashTransaction.type.equals('purchase_payment') &
                    cashTransaction.syncStatus.equals('pending'),
              ))
              .get();
      bundles.add(
        LocalPurchaseBundle(
          purchase: purchase,
          items: items,
          payments: payments,
          cashTransactions: cashTransactions,
        ),
      );
    }

    return bundles;
  }

  Future<void> ensurePurchasePaymentCashTransactions({String? shopId}) async {
    final rows = await customSelect(
      '''
      SELECT
        pp.id,
        pp.shop_id,
        pp.purchase_id,
        pp.payments,
        pp.description,
        pp.created_at,
        pp.updated_at,
        pp.sync_status
      FROM local_purchase_payments pp
      WHERE pp.payments > 0
        AND (?1 IS NULL OR pp.shop_id = ?1)
        AND NOT EXISTS (
          SELECT 1
          FROM local_cash_transactions ct
          WHERE ct.reference_id = pp.purchase_id
            AND ct.type = 'purchase_payment'
        )
      ''',
      variables: [Variable<String>(shopId)],
      readsFrom: {localPurchasePayments, localCashTransactions},
    ).get();

    if (rows.isEmpty) {
      return;
    }

    await transaction(() async {
      for (final row in rows) {
        await into(localCashTransactions).insert(
          LocalCashTransactionsCompanion(
            id: Value(const Uuid().v4()),
            shopId: Value(row.read<String>('shop_id')),
            type: const Value('purchase_payment'),
            direction: const Value('out'),
            amount: Value(row.read<double>('payments')),
            referenceId: Value(row.read<String>('purchase_id')),
            referenceType: const Value('purchase'),
            method: const Value('cash'),
            note: Value(row.readNullable<String>('description')),
            createdAt: Value(row.read<DateTime>('created_at')),
            updatedAt: Value(row.read<DateTime>('updated_at')),
            syncStatus: Value(row.read<String>('sync_status')),
          ),
        );
      }
    });
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
      await (update(localCashTransactions)..where(
            (cashTransaction) =>
                cashTransaction.referenceId.equals(purchaseId) &
                cashTransaction.type.equals('purchase_payment'),
          ))
          .write(
            const LocalCashTransactionsCompanion(syncStatus: Value('synced')),
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
    required this.cashTransactions,
  });

  final LocalPurchase purchase;
  final List<LocalPurchaseItem> items;
  final List<LocalPurchasePayment> payments;
  final List<LocalCashTransaction> cashTransactions;
}

class LocalPurchaseBundleCompanion {
  const LocalPurchaseBundleCompanion({
    required this.purchase,
    required this.items,
    required this.payments,
    this.cashTransactions = const [],
  });

  final LocalPurchasesCompanion purchase;
  final List<LocalPurchaseItemsCompanion> items;
  final List<LocalPurchasePaymentsCompanion> payments;
  final List<LocalCashTransactionsCompanion> cashTransactions;
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

class LocalSalesHistoryEntry {
  const LocalSalesHistoryEntry({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.subtotal,
    required this.discount,
    required this.vat,
    required this.total,
    required this.paidAmount,
    required this.itemCount,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
    required this.syncStatus,
  });

  final String id;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final double subtotal;
  final double discount;
  final double vat;
  final double total;
  final double paidAmount;
  final int itemCount;
  final String status;
  final String? paymentMethod;
  final DateTime createdAt;
  final String syncStatus;

  double get dueAmount => total - paidAmount;
}

class LocalDuesSummary {
  const LocalDuesSummary({required this.receivable, required this.payable});

  final double receivable;
  final double payable;
}

class LocalDuesLedgerEntry {
  const LocalDuesLedgerEntry({
    required this.id,
    required this.type,
    required this.partyId,
    required this.name,
    required this.phone,
    required this.dueAmount,
    required this.createdAt,
    required this.syncStatus,
  });

  final String id;
  final String type;
  final String partyId;
  final String name;
  final String phone;
  final double dueAmount;
  final DateTime createdAt;
  final String syncStatus;

  bool get isReceivable => type == 'receivable';
}

class LocalDueHistoryEntry {
  const LocalDueHistoryEntry({
    required this.id,
    required this.sourceType,
    required this.amount,
    required this.createdAt,
    this.balance = 0,
  });

  final String id;
  final String sourceType;
  final double amount;
  final DateTime createdAt;
  final double balance;

  LocalDueHistoryEntry copyWith({double? balance}) {
    return LocalDueHistoryEntry(
      id: id,
      sourceType: sourceType,
      amount: amount,
      createdAt: createdAt,
      balance: balance ?? this.balance,
    );
  }
}

class LocalSaleItemDetail {
  const LocalSaleItemDetail({
    required this.id,
    required this.shopId,
    required this.orderId,
    required this.productId,
    required this.buyPrice,
    required this.salePrice,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    required this.productName,
    required this.description,
  });

  final String id;
  final String shopId;
  final String orderId;
  final String productId;
  final double buyPrice;
  final double salePrice;
  final int quantity;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  final String productName;
  final String? description;
}

class LocalAvailablePurchaseBatch {
  const LocalAvailablePurchaseBatch({
    required this.id,
    required this.shopId,
    required this.categoryId,
    required this.productName,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.availableQuantity,
    required this.createdAt,
  });

  final String id;
  final String shopId;
  final String? categoryId;
  final String productName;
  final double buyingPrice;
  final double sellingPrice;
  final int availableQuantity;
  final DateTime createdAt;
}

class LocalSaleBundle {
  const LocalSaleBundle({
    required this.sale,
    required this.items,
    required this.payments,
    required this.cashTransactions,
  });

  final LocalSale sale;
  final List<LocalSaleItem> items;
  final List<LocalCustomerPayment> payments;
  final List<LocalCashTransaction> cashTransactions;
}

class LocalSaleBundleCompanion {
  const LocalSaleBundleCompanion({
    required this.sale,
    required this.items,
    required this.payments,
    required this.cashTransactions,
  });

  final LocalSalesCompanion sale;
  final List<LocalSaleItemsCompanion> items;
  final List<LocalCustomerPaymentsCompanion> payments;
  final List<LocalCashTransactionsCompanion> cashTransactions;
}

class LocalExpenseSyncBundle {
  const LocalExpenseSyncBundle({
    required this.expenses,
    required this.cashTransactions,
  });

  final List<LocalExpense> expenses;
  final List<LocalCashTransaction> cashTransactions;

  bool get isEmpty => expenses.isEmpty && cashTransactions.isEmpty;
}

class LocalExpenseHistoryEntry {
  const LocalExpenseHistoryEntry({
    required this.id,
    required this.categoryId,
    required this.categoryName,
    required this.amount,
    required this.reason,
    required this.note,
    required this.createdAt,
    required this.syncStatus,
  });

  final String id;
  final String categoryId;
  final String categoryName;
  final double amount;
  final String? reason;
  final String? note;
  final DateTime createdAt;
  final String syncStatus;
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
