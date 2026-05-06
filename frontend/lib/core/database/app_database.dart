import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../utils/app_time.dart';

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
  DateTimeColumn get deletedAt => dateTime().nullable()();
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
  DateTimeColumn get deletedAt => dateTime().nullable()();
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
  DateTimeColumn get deletedAt => dateTime().nullable()();
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
  DateTimeColumn get deletedAt => dateTime().nullable()();
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
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalSaleReturns extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get saleId => text().references(LocalSales, #id)();
  RealColumn get subtotal => real().withDefault(const Constant(0))();
  RealColumn get restockingFee => real().withDefault(const Constant(0))();
  RealColumn get refundTotal => real().withDefault(const Constant(0))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalSaleReturnItems extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get returnId => text().references(LocalSaleReturns, #id)();
  TextColumn get saleItemId => text().references(LocalSaleItems, #id)();
  TextColumn get productId => text().references(LocalPurchaseItems, #id)();
  TextColumn get productName => text()();
  RealColumn get salePrice => real().withDefault(const Constant(0))();
  IntColumn get quantity => integer().withDefault(const Constant(0))();
  TextColumn get reason => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
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
  DateTimeColumn get deletedAt => dateTime().nullable()();
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
  DateTimeColumn get deletedAt => dateTime().nullable()();
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
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalIncomes extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get categoryId => text().references(LocalCategories, #id)();
  RealColumn get amount => real().withDefault(const Constant(0))();
  TextColumn get reason => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get receiptUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalRecycleBinEntries extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get sourceTableName => text().named('table_name')();
  TextColumn get recordId => text()();
  TextColumn get displayTitle => text()();
  TextColumn get displaySubtitle => text().nullable()();
  TextColumn get deletedData => text()();
  TextColumn get relatedData => text().nullable()();
  TextColumn get deletedByUserId =>
      text().nullable().references(LocalUsers, #id)();
  DateTimeColumn get deletedAt => dateTime()();
  DateTimeColumn get restoredAt => dateTime().nullable()();
  TextColumn get restoreStatus =>
      text().withDefault(const Constant('deleted'))();
  TextColumn get restoreBlockReason => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class LocalNotes extends Table {
  TextColumn get id => text()();
  TextColumn get shopId => text().references(LocalShops, #id)();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get body => text().withDefault(const Constant(''))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get archivedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
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
    LocalSaleReturns,
    LocalSaleReturnItems,
    LocalCustomerPayments,
    LocalCashTransactions,
    LocalExpenses,
    LocalIncomes,
    LocalRecycleBinEntries,
    LocalNotes,
  ],
)
final class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'bonik'));

  @override
  int get schemaVersion => 15;

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
      if (from < 11) {
        await migrator.createTable(localSaleReturns);
        await migrator.createTable(localSaleReturnItems);
      }
      if (from < 12) {
        await migrator.createTable(localIncomes);
      }
      if (from < 13) {
        Future<void> addDeletedAtIfMissing(String tableName) async {
          final columns = await customSelect(
            'PRAGMA table_info($tableName)',
          ).get();
          final hasDeletedAt = columns.any(
            (row) => row.data['name'] == 'deleted_at',
          );
          if (!hasDeletedAt) {
            await customStatement(
              'ALTER TABLE $tableName ADD COLUMN deleted_at INTEGER NULL',
            );
          }
        }

        await addDeletedAtIfMissing('local_purchases');
        await addDeletedAtIfMissing('local_purchase_items');
        await addDeletedAtIfMissing('local_purchase_payments');
        await addDeletedAtIfMissing('local_sales');
        await addDeletedAtIfMissing('local_sale_items');
        await addDeletedAtIfMissing('local_customer_payments');
        await addDeletedAtIfMissing('local_expenses');
        await addDeletedAtIfMissing('local_incomes');
        await addDeletedAtIfMissing('local_cash_transactions');
        await addDeletedAtIfMissing('local_sale_returns');
        await addDeletedAtIfMissing('local_sale_return_items');
      }
      if (from < 14) {
        await migrator.createTable(localRecycleBinEntries);
      }
      if (from < 15) {
        await migrator.createTable(localNotes);
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
        FROM local_sale_returns
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_sale_return_items
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
        UNION ALL
        SELECT 1
        FROM local_incomes
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_recycle_bin_entries
        WHERE sync_status != 'synced'
          AND shop_id IN (SELECT shop_id FROM current_shop)
        UNION ALL
        SELECT 1
        FROM local_notes
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
        localSaleReturns,
        localSaleReturnItems,
        localCustomerPayments,
        localCashTransactions,
        localExpenses,
        localIncomes,
        localRecycleBinEntries,
        localNotes,
      },
    ).watchSingle().map((row) => row.read<bool>('has_unsynced'));
  }

  Future<LocalUser?> getCurrentUser() {
    return (select(
      localUsers,
    )..where((user) => user.isCurrent.equals(true))).getSingleOrNull();
  }

  Stream<List<LocalNote>> watchNotesForCurrentShop({required bool archived}) {
    final currentShopIds = selectOnly(localUsers)
      ..addColumns([localUsers.shopId])
      ..where(localUsers.isCurrent.equals(true));

    return (select(localNotes)
          ..where(
            (note) =>
                note.shopId.isInQuery(currentShopIds) &
                note.deletedAt.isNull() &
                note.isArchived.equals(archived),
          )
          ..orderBy([(note) => OrderingTerm.desc(note.updatedAt)]))
        .watch();
  }

  Future<void> saveNoteLocally({
    String? id,
    required String title,
    required String body,
  }) async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw StateError('No current user found.');
    }

    final trimmedTitle = title.trim();
    final trimmedBody = body.trim();
    if (trimmedTitle.isEmpty && trimmedBody.isEmpty) {
      throw StateError('Please write something.');
    }

    final now = AppTime.nowUtc();
    final noteId = id ?? const Uuid().v4();
    final existing = await (select(
      localNotes,
    )..where((note) => note.id.equals(noteId))).getSingleOrNull();

    await into(localNotes).insertOnConflictUpdate(
      LocalNotesCompanion(
        id: Value(noteId),
        shopId: Value(existing?.shopId ?? currentUser.shopId),
        title: Value(trimmedTitle),
        body: Value(trimmedBody),
        isArchived: Value(existing?.isArchived ?? false),
        archivedAt: Value(existing?.archivedAt),
        createdAt: Value(existing?.createdAt ?? now),
        updatedAt: Value(now),
        deletedAt: const Value(null),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<void> archiveNoteLocally(String id) async {
    final now = AppTime.nowUtc();
    await (update(localNotes)..where((note) => note.id.equals(id))).write(
      LocalNotesCompanion(
        isArchived: const Value(true),
        archivedAt: Value(now),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<void> restoreNoteLocally(String id) async {
    final now = AppTime.nowUtc();
    await (update(localNotes)..where((note) => note.id.equals(id))).write(
      LocalNotesCompanion(
        isArchived: const Value(false),
        archivedAt: const Value(null),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<void> deleteNoteLocally(String id) async {
    final note = await (select(
      localNotes,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (note == null) {
      throw StateError('Note not found.');
    }

    final currentUser = await getCurrentUser();
    final now = AppTime.nowUtc();
    final deletedData = jsonEncode({
      'id': note.id,
      'shop_id': note.shopId,
      'title': note.title,
      'body': note.body,
      'is_archived': note.isArchived,
      'archived_at': AppTime.nullableIsoUtc(note.archivedAt),
      'created_at': AppTime.isoUtc(note.createdAt),
      'updated_at': AppTime.isoUtc(note.updatedAt),
      'deleted_at': AppTime.isoUtc(now),
    });

    await transaction(() async {
      await (update(localNotes)..where((row) => row.id.equals(id))).write(
        LocalNotesCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await into(localRecycleBinEntries).insertOnConflictUpdate(
        LocalRecycleBinEntriesCompanion(
          id: Value(const Uuid().v4()),
          shopId: Value(note.shopId),
          sourceTableName: const Value('local_notes'),
          recordId: Value(note.id),
          displayTitle: Value(
            note.title.trim().isEmpty ? 'Untitled note' : note.title.trim(),
          ),
          displaySubtitle: Value(
            note.body.trim().isEmpty ? 'Note' : note.body.trim(),
          ),
          deletedData: Value(deletedData),
          relatedData: const Value(null),
          deletedByUserId: Value(currentUser?.id),
          deletedAt: Value(now),
          restoredAt: const Value(null),
          restoreStatus: const Value('deleted'),
          restoreBlockReason: const Value(null),
          createdAt: Value(now),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });
  }

  Future<List<LocalNote>> getPendingNotes({String? shopId}) {
    return (select(localNotes)..where(
          (note) =>
              note.syncStatus.equals('pending') &
              (shopId == null
                  ? const Constant(true)
                  : note.shopId.equals(shopId)),
        ))
        .get();
  }

  Future<void> markNoteSynced(String id) async {
    await (update(localNotes)..where((note) => note.id.equals(id))).write(
      const LocalNotesCompanion(syncStatus: Value('synced')),
    );
  }

  Future<void> upsertSyncedNotes(List<LocalNotesCompanion> rows) async {
    await transaction(() async {
      for (final row in rows) {
        await into(localNotes).insertOnConflictUpdate(row);
      }
    });
  }

  Stream<List<LocalRecycleBinEntry>> watchRecycleBinEntriesForCurrentShop() {
    final currentShopIds = selectOnly(localUsers)
      ..addColumns([localUsers.shopId])
      ..where(localUsers.isCurrent.equals(true));

    return (select(localRecycleBinEntries)
          ..where(
            (entry) =>
                entry.restoreStatus.equals('deleted') &
                entry.shopId.isInQuery(currentShopIds),
          )
          ..orderBy([(entry) => OrderingTerm.desc(entry.deletedAt)]))
        .watch();
  }

  Future<List<LocalRecycleBinEntry>> getPendingRecycleBinEntries({
    String? shopId,
  }) {
    return (select(localRecycleBinEntries)..where(
          (entry) =>
              entry.syncStatus.equals('pending') &
              (shopId == null
                  ? const Constant(true)
                  : entry.shopId.equals(shopId)),
        ))
        .get();
  }

  Future<void> markRecycleBinEntrySynced(String id) async {
    await (update(
      localRecycleBinEntries,
    )..where((entry) => entry.id.equals(id))).write(
      const LocalRecycleBinEntriesCompanion(syncStatus: Value('synced')),
    );
  }

  Future<void> upsertSyncedRecycleBinEntries(
    List<LocalRecycleBinEntriesCompanion> rows,
  ) async {
    await transaction(() async {
      for (final row in rows) {
        await into(localRecycleBinEntries).insertOnConflictUpdate(row);
      }
    });
  }

  Future<void> restoreRecycleBinEntry(String id) async {
    final entry = await (select(
      localRecycleBinEntries,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (entry == null) {
      throw StateError('Recycle bin entry not found.');
    }

    final tableName = _localTableNameForRecycleBin(entry.sourceTableName);
    final now = AppTime.nowUtc();

    await transaction(() async {
      final restoredRows = tableName == 'local_categories'
          ? await (update(
              localCategories,
            )..where((category) => category.id.equals(entry.recordId))).write(
              LocalCategoriesCompanion(
                deletedAt: const Value(null),
                updatedAt: Value(now),
                syncStatus: const Value('pending'),
              ),
            )
          : tableName == 'local_notes'
          ? await (update(
              localNotes,
            )..where((note) => note.id.equals(entry.recordId))).write(
              LocalNotesCompanion(
                deletedAt: const Value(null),
                updatedAt: Value(now),
                syncStatus: const Value('pending'),
              ),
            )
          : tableName == 'local_purchase_items'
          ? await (update(
              localPurchaseItems,
            )..where((item) => item.id.equals(entry.recordId))).write(
              LocalPurchaseItemsCompanion(
                deletedAt: const Value(null),
                updatedAt: Value(now),
                syncStatus: const Value('pending'),
              ),
            )
          : await customUpdate(
              'UPDATE $tableName SET deleted_at = NULL, updated_at = ?, sync_status = ? WHERE id = ?',
              variables: [
                Variable<DateTime>(now),
                const Variable<String>('pending'),
                Variable<String>(entry.recordId),
              ],
            );
      if (restoredRows == 0 && tableName == 'local_purchase_items') {
        await _restorePurchaseItemFromRecycleEntry(entry, now);
      } else if (restoredRows == 0 && tableName == 'local_notes') {
        await _restoreNoteFromRecycleEntry(entry, now);
      } else if (restoredRows == 0) {
        throw StateError('Deleted record was not found in local database.');
      }

      await (update(
        localRecycleBinEntries,
      )..where((row) => row.id.equals(entry.id))).write(
        LocalRecycleBinEntriesCompanion(
          restoreStatus: const Value('restored'),
          restoredAt: Value(now),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });
  }

  Future<void> permanentlyDeleteRecycleBinEntry(String id) async {
    final entry = await (select(
      localRecycleBinEntries,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (entry == null) {
      throw StateError('Recycle bin entry not found.');
    }

    final tableName = _localTableNameForRecycleBin(entry.sourceTableName);
    final now = AppTime.nowUtc();

    await transaction(() async {
      if (tableName == 'local_purchase_items') {
        await (delete(
          localPurchaseItems,
        )..where((item) => item.id.equals(entry.recordId))).go();
      } else if (tableName == 'local_categories') {
        await (delete(
          localCategories,
        )..where((category) => category.id.equals(entry.recordId))).go();
      } else if (tableName == 'local_notes') {
        await (delete(
          localNotes,
        )..where((note) => note.id.equals(entry.recordId))).go();
      } else {
        await customUpdate(
          'DELETE FROM $tableName WHERE id = ?',
          variables: [Variable<String>(entry.recordId)],
        );
      }
      await (update(
        localRecycleBinEntries,
      )..where((row) => row.id.equals(entry.id))).write(
        LocalRecycleBinEntriesCompanion(
          restoreStatus: const Value('permanently_deleted'),
          restoredAt: const Value(null),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });
  }

  Future<void> _restoreNoteFromRecycleEntry(
    LocalRecycleBinEntry entry,
    DateTime now,
  ) async {
    final decoded = jsonDecode(entry.deletedData);
    if (decoded is! Map<String, dynamic>) {
      throw StateError('Recycle bin snapshot is invalid.');
    }

    await into(localNotes).insertOnConflictUpdate(
      LocalNotesCompanion(
        id: Value(_jsonString(decoded['id']) ?? entry.recordId),
        shopId: Value(_jsonString(decoded['shop_id']) ?? entry.shopId),
        title: Value(_jsonString(decoded['title']) ?? ''),
        body: Value(_jsonString(decoded['body']) ?? ''),
        isArchived: Value(_jsonBool(decoded['is_archived'])),
        archivedAt: Value(_jsonDateTime(decoded['archived_at'])),
        createdAt: Value(
          _jsonDateTime(decoded['created_at']) ?? entry.deletedAt,
        ),
        updatedAt: Value(now),
        deletedAt: const Value(null),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<void> _restorePurchaseItemFromRecycleEntry(
    LocalRecycleBinEntry entry,
    DateTime now,
  ) async {
    final decoded = jsonDecode(entry.deletedData);
    if (decoded is! Map<String, dynamic>) {
      throw StateError('Recycle bin snapshot is invalid.');
    }

    await into(localPurchaseItems).insertOnConflictUpdate(
      LocalPurchaseItemsCompanion(
        id: Value(_jsonString(decoded['id']) ?? entry.recordId),
        shopId: Value(_jsonString(decoded['shop_id']) ?? entry.shopId),
        purchaseId: Value(_jsonString(decoded['purchase_id'])),
        categoryId: Value(_jsonString(decoded['category_id'])),
        productName: Value(
          _jsonString(decoded['product_name']) ?? entry.displayTitle,
        ),
        buyingPrice: Value(_jsonDouble(decoded['buying_price'])),
        estSellingPrice: Value(
          _jsonNullableDouble(decoded['est_selling_price']),
        ),
        quantity: Value(_jsonInt(decoded['quantity'])),
        barcode: Value(_jsonString(decoded['barcode'])),
        otherCharge: Value(_jsonDouble(decoded['other_charge'])),
        description: Value(_jsonString(decoded['description'])),
        productImage: Value(_jsonString(decoded['product_image'])),
        createdAt: Value(
          _jsonDateTime(decoded['created_at']) ?? entry.deletedAt,
        ),
        updatedAt: Value(now),
        deletedAt: const Value(null),
        syncStatus: const Value('pending'),
      ),
    );
  }

  String? _jsonString(Object? value) {
    if (value == null) {
      return null;
    }
    final text = value.toString();
    return text.isEmpty ? null : text;
  }

  double _jsonDouble(Object? value) {
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  double? _jsonNullableDouble(Object? value) {
    if (value == null) {
      return null;
    }
    return _jsonDouble(value);
  }

  int _jsonInt(Object? value) {
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  bool _jsonBool(Object? value) {
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
    final text = value?.toString().toLowerCase();
    return text == '1' || text == 'true';
  }

  DateTime? _jsonDateTime(Object? value) {
    if (value == null) {
      return null;
    }
    return AppTime.tryParseUtc(value);
  }

  String _localTableNameForRecycleBin(String sourceTableName) {
    final tableName = sourceTableName.startsWith('local_')
        ? sourceTableName
        : 'local_$sourceTableName';
    const allowedTables = {
      'local_shops',
      'local_users',
      'local_categories',
      'local_suppliers',
      'local_purchases',
      'local_purchase_items',
      'local_purchase_payments',
      'local_customers',
      'local_sales',
      'local_sale_items',
      'local_sale_returns',
      'local_sale_return_items',
      'local_customer_payments',
      'local_cash_transactions',
      'local_expenses',
      'local_incomes',
      'local_notes',
    };

    if (!allowedTables.contains(tableName)) {
      throw StateError('Unsupported recycle bin table: $sourceTableName');
    }
    return tableName;
  }

  String recycleBinJsonEncode(Object? value) {
    if (value == null) {
      return '{}';
    }
    return jsonEncode(value);
  }

  Future<bool> isBarcodeUnique(String shopId, String barcode) async {
    final query = select(localPurchaseItems)
      ..where(
        (item) => item.shopId.equals(shopId) & item.barcode.equals(barcode),
      );
    final match = await query.getSingleOrNull();
    return match == null;
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

  Stream<List<LocalPurchaseItem>> watchPurchaseItemsWithBarcodes() {
    final currentShopIds = selectOnly(localUsers)
      ..addColumns([localUsers.shopId])
      ..where(localUsers.isCurrent.equals(true));

    return (select(localPurchaseItems)
          ..where(
            (item) =>
                item.barcode.isNotNull() &
                item.barcode.equals('').not() &
                item.shopId.isInQuery(currentShopIds),
          )
          ..orderBy([(item) => OrderingTerm.asc(item.productName)]))
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
    final start = AppTime.startOfLocalDayUtc();
    final end = AppTime.endOfLocalDayUtc();

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

  Stream<List<LocalCategory>> watchIncomeCategoriesForCurrentShop() {
    final currentShopIds = selectOnly(localUsers)
      ..addColumns([localUsers.shopId])
      ..where(localUsers.isCurrent.equals(true));

    return (select(localCategories)
          ..where(
            (category) =>
                category.type.equals('income') &
                category.deletedAt.isNull() &
                category.shopId.isInQuery(currentShopIds),
          )
          ..orderBy([(category) => OrderingTerm.asc(category.name)]))
        .watch();
  }

  Stream<double> watchTodayIncomeTotalForCurrentShop() {
    final start = AppTime.startOfLocalDayUtc();
    final end = AppTime.endOfLocalDayUtc();

    return customSelect(
      '''
      SELECT COALESCE(SUM(amount), 0.0) AS total
      FROM local_incomes
      WHERE shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
        AND created_at >= ?
        AND created_at < ?
      ''',
      variables: [Variable<DateTime>(start), Variable<DateTime>(end)],
      readsFrom: {localIncomes, localUsers},
    ).watchSingle().map((row) => row.read<double>('total'));
  }

  Stream<double> watchTodaySalesTotalForCurrentShop() {
    final start = AppTime.startOfLocalDayUtc();
    final end = AppTime.endOfLocalDayUtc();

    return customSelect(
      '''
      SELECT COALESCE(SUM(
        MAX(
          s.total - COALESCE((
            SELECT SUM(sr.refund_total)
            FROM local_sale_returns sr
            WHERE sr.sale_id = s.id
          ), 0.0),
          0.0
        )
      ), 0.0) AS total
      FROM local_sales
      s
      WHERE shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
        AND deleted_at IS NULL
        AND created_at >= ?
        AND created_at < ?
      ''',
      variables: [Variable<DateTime>(start), Variable<DateTime>(end)],
      readsFrom: {localSales, localUsers},
    ).watchSingle().map((row) => row.read<double>('total'));
  }

  Stream<List<LocalCategory>> watchDeletedIncomeCategoriesForCurrentShop() {
    final currentShopIds = selectOnly(localUsers)
      ..addColumns([localUsers.shopId])
      ..where(localUsers.isCurrent.equals(true));

    return (select(localCategories)
          ..where(
            (category) =>
                category.type.equals('income') &
                category.deletedAt.isNotNull() &
                category.shopId.isInQuery(currentShopIds),
          )
          ..orderBy([(category) => OrderingTerm.desc(category.deletedAt)]))
        .watch();
  }

  Stream<List<LocalOwnerTransactionEntry>>
  watchOwnerTransactionsForCurrentShop() {
    return customSelect(
      '''
      SELECT
        id,
        type,
        direction,
        amount,
        reference_id,
        reference_type,
        method,
        note,
        created_at,
        sync_status
      FROM local_cash_transactions
      WHERE shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
        AND type IN ('owner_given', 'owner_taken')
      ORDER BY created_at DESC
      ''',
      readsFrom: {localCashTransactions, localUsers},
    ).watch().map(
      (rows) => [
        for (final row in rows)
          LocalOwnerTransactionEntry(
            id: row.read<String>('id'),
            type: row.read<String>('type'),
            direction: row.read<String>('direction'),
            amount: row.read<double>('amount'),
            referenceId: row.readNullable<String>('reference_id'),
            referenceType: row.readNullable<String>('reference_type'),
            method: row.readNullable<String>('method'),
            note: row.readNullable<String>('note'),
            createdAt: row.read<DateTime>('created_at'),
            syncStatus: row.read<String>('sync_status'),
          ),
      ],
    );
  }

  Stream<double> watchTodayOwnerTransactionTotalForCurrentShop() {
    final start = AppTime.startOfLocalDayUtc();
    final end = AppTime.endOfLocalDayUtc();

    return customSelect(
      '''
      SELECT COALESCE(SUM(
        CASE
          WHEN type = 'owner_given' THEN amount
          WHEN type = 'owner_taken' THEN -amount
          ELSE 0.0
        END
      ), 0.0) AS total
      FROM local_cash_transactions
      WHERE shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
        AND deleted_at IS NULL
        AND type IN ('owner_given', 'owner_taken')
        AND created_at >= ?
        AND created_at < ?
      ''',
      variables: [Variable<DateTime>(start), Variable<DateTime>(end)],
      readsFrom: {localCashTransactions, localUsers},
    ).watchSingle().map((row) => row.read<double>('total'));
  }

  Stream<double> watchTodayOnlineWalletTotalForCurrentShop() {
    final start = AppTime.startOfLocalDayUtc();
    final end = AppTime.endOfLocalDayUtc();

    return customSelect(
      '''
      SELECT COALESCE(SUM(
        CASE
          WHEN direction = 'in' THEN amount
          WHEN direction = 'out' THEN -amount
          ELSE 0.0
        END
      ), 0.0) AS total
      FROM local_cash_transactions
      WHERE shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
        AND deleted_at IS NULL
        AND method IN ('online', 'mobile_banking')
        AND created_at >= ?
        AND created_at < ?
      ''',
      variables: [Variable<DateTime>(start), Variable<DateTime>(end)],
      readsFrom: {localCashTransactions, localUsers},
    ).watchSingle().map((row) => row.read<double>('total'));
  }

  Stream<double> watchTodayReceivableDueTotalForCurrentShop() {
    final start = AppTime.startOfLocalDayUtc();
    final end = AppTime.endOfLocalDayUtc();

    return customSelect(
      '''
      SELECT COALESCE(SUM(
        CASE
          WHEN (
            s.total
            - COALESCE((
              SELECT SUM(sr.refund_total)
              FROM local_sale_returns sr
              WHERE sr.sale_id = s.id
            ), 0.0)
            - COALESCE((
              SELECT SUM(cp.payments)
              FROM local_customer_payments cp
              WHERE cp.order_id = s.id
            ), 0.0)
          ) > 0
          THEN (
            s.total
            - COALESCE((
              SELECT SUM(sr.refund_total)
              FROM local_sale_returns sr
              WHERE sr.sale_id = s.id
            ), 0.0)
            - COALESCE((
              SELECT SUM(cp.payments)
              FROM local_customer_payments cp
              WHERE cp.order_id = s.id
            ), 0.0)
          )
          ELSE 0.0
        END
      ), 0.0) AS total
      FROM local_sales s
      WHERE s.shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
        AND s.deleted_at IS NULL
        AND s.created_at >= ?
        AND s.created_at < ?
      ''',
      variables: [Variable<DateTime>(start), Variable<DateTime>(end)],
      readsFrom: {
        localSales,
        localSaleReturns,
        localCustomerPayments,
        localUsers,
      },
    ).watchSingle().map((row) => row.read<double>('total'));
  }

  Stream<double> watchTodayCashBoxTotalForCurrentShop() {
    final start = AppTime.startOfLocalDayUtc();
    final end = AppTime.endOfLocalDayUtc();

    return customSelect(
      '''
      WITH current_shop AS (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      ),
      sales AS (
        SELECT COALESCE(SUM(
          MAX(
            s.total - COALESCE((
              SELECT SUM(sr.refund_total)
              FROM local_sale_returns sr
              WHERE sr.sale_id = s.id
            ), 0.0),
            0.0
          )
        ), 0.0) AS total
        FROM local_sales s
        WHERE s.shop_id IN (SELECT shop_id FROM current_shop)
          AND s.deleted_at IS NULL
          AND s.created_at >= ?
          AND s.created_at < ?
      ),
      due_sales AS (
        SELECT COALESCE(SUM(
          CASE
            WHEN (
              s.total
              - COALESCE((
                SELECT SUM(sr.refund_total)
                FROM local_sale_returns sr
                WHERE sr.sale_id = s.id
              ), 0.0)
              - COALESCE((
                SELECT SUM(cp.payments)
                FROM local_customer_payments cp
                WHERE cp.order_id = s.id
              ), 0.0)
            ) > 0
            THEN (
              s.total
              - COALESCE((
                SELECT SUM(sr.refund_total)
                FROM local_sale_returns sr
                WHERE sr.sale_id = s.id
              ), 0.0)
              - COALESCE((
                SELECT SUM(cp.payments)
                FROM local_customer_payments cp
                WHERE cp.order_id = s.id
              ), 0.0)
            )
            ELSE 0.0
          END
        ), 0.0) AS total
        FROM local_sales s
        WHERE s.shop_id IN (SELECT shop_id FROM current_shop)
          AND s.deleted_at IS NULL
          AND s.created_at >= ?
          AND s.created_at < ?
      ),
      expenses AS (
        SELECT COALESCE(SUM(amount), 0.0) AS total
        FROM local_expenses
        WHERE shop_id IN (SELECT shop_id FROM current_shop)
          AND deleted_at IS NULL
          AND created_at >= ?
          AND created_at < ?
      ),
      incomes AS (
        SELECT COALESCE(SUM(amount), 0.0) AS total
        FROM local_incomes
        WHERE shop_id IN (SELECT shop_id FROM current_shop)
          AND deleted_at IS NULL
          AND created_at >= ?
          AND created_at < ?
      ),
      online_wallet AS (
        SELECT COALESCE(SUM(
          CASE
            WHEN direction = 'in' THEN amount
            WHEN direction = 'out' THEN -amount
            ELSE 0.0
          END
        ), 0.0) AS total
        FROM local_cash_transactions
        WHERE shop_id IN (SELECT shop_id FROM current_shop)
          AND deleted_at IS NULL
          AND method IN ('online', 'mobile_banking')
          AND created_at >= ?
          AND created_at < ?
      ),
      owner_transactions AS (
        SELECT COALESCE(SUM(
          CASE
            WHEN type = 'owner_given' THEN amount
            WHEN type = 'owner_taken' THEN -amount
            ELSE 0.0
          END
        ), 0.0) AS total
        FROM local_cash_transactions
        WHERE shop_id IN (SELECT shop_id FROM current_shop)
          AND deleted_at IS NULL
          AND type IN ('owner_given', 'owner_taken')
          AND created_at >= ?
          AND created_at < ?
      )
      SELECT
        sales.total
        - due_sales.total
        - expenses.total
        + incomes.total
        - online_wallet.total
        + owner_transactions.total AS total
      FROM sales, due_sales, expenses, incomes, online_wallet, owner_transactions
      ''',
      variables: [
        Variable<DateTime>(start),
        Variable<DateTime>(end),
        Variable<DateTime>(start),
        Variable<DateTime>(end),
        Variable<DateTime>(start),
        Variable<DateTime>(end),
        Variable<DateTime>(start),
        Variable<DateTime>(end),
        Variable<DateTime>(start),
        Variable<DateTime>(end),
        Variable<DateTime>(start),
        Variable<DateTime>(end),
      ],
      readsFrom: {
        localSales,
        localSaleReturns,
        localCustomerPayments,
        localExpenses,
        localIncomes,
        localCashTransactions,
        localUsers,
      },
    ).watchSingle().map((row) => row.read<double>('total'));
  }

  Future<String> saveOwnerGivenLocally({
    required double amount,
    required DateTime transactionDate,
    required String note,
  }) async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw StateError('No current user found.');
    }
    if (amount <= 0) {
      throw StateError('Owner given amount is required.');
    }

    final now = AppTime.nowUtc();
    final id = const Uuid().v4();
    await into(localCashTransactions).insert(
      LocalCashTransactionsCompanion(
        id: Value(id),
        shopId: Value(currentUser.shopId),
        type: const Value('owner_given'),
        direction: const Value('in'),
        amount: Value(amount),
        referenceType: const Value('owner'),
        method: const Value('cash'),
        note: Value(_nullableTrimmed(note)),
        createdAt: Value(AppTime.toUtc(transactionDate)),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );

    return id;
  }

  Future<String> saveOwnerTakenLocally({
    required double amount,
    required DateTime transactionDate,
    required String note,
  }) async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw StateError('No current user found.');
    }
    if (amount <= 0) {
      throw StateError('Owner taken amount is required.');
    }

    final now = AppTime.nowUtc();
    final id = const Uuid().v4();
    await into(localCashTransactions).insert(
      LocalCashTransactionsCompanion(
        id: Value(id),
        shopId: Value(currentUser.shopId),
        type: const Value('owner_taken'),
        direction: const Value('out'),
        amount: Value(amount),
        referenceType: const Value('owner'),
        method: const Value('cash'),
        note: Value(_nullableTrimmed(note)),
        createdAt: Value(AppTime.toUtc(transactionDate)),
        updatedAt: Value(now),
        syncStatus: const Value('pending'),
      ),
    );

    return id;
  }

  Future<List<LocalCashTransaction>> getPendingOwnerTransactions({
    String? shopId,
  }) {
    return (select(localCashTransactions)..where(
          (transaction) =>
              transaction.type.isIn(['owner_given', 'owner_taken']) &
              transaction.syncStatus.equals('pending') &
              (shopId == null
                  ? const Constant(true)
                  : transaction.shopId.equals(shopId)),
        ))
        .get();
  }

  Future<void> markOwnerTransactionSynced(String id) async {
    await (update(
      localCashTransactions,
    )..where((transaction) => transaction.id.equals(id))).write(
      const LocalCashTransactionsCompanion(syncStatus: Value('synced')),
    );
  }

  Future<void> upsertSyncedOwnerTransactions(
    List<LocalCashTransactionsCompanion> rows,
  ) async {
    await transaction(() async {
      for (final row in rows) {
        await into(localCashTransactions).insertOnConflictUpdate(row);
      }
    });
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
    final now = AppTime.nowUtc();
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
          createdAt: Value(AppTime.toUtc(expenseDate)),
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
          createdAt: Value(AppTime.toUtc(expenseDate)),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });

    return expenseId;
  }

  Future<LocalCategory> createIncomeCategory(
    String name, {
    String? details,
  }) async {
    return _createCategory(name, type: 'income', details: details);
  }

  Future<void> updateIncomeCategory({
    required String id,
    required String name,
    String? details,
  }) async {
    await _updateCategory(id: id, name: name, details: details);
  }

  Future<void> deleteIncomeCategory(String id) async {
    await _softDeleteCategory(id);
  }

  Future<String> saveIncomeLocally({
    required String categoryName,
    required double amount,
    required String reason,
    required String note,
    required DateTime incomeDate,
    String? receiptUrl,
  }) async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw StateError('No current user found.');
    }
    if (amount <= 0) {
      throw StateError('Income amount is required.');
    }

    final category = await _findCategoryByName(
      shopId: currentUser.shopId,
      type: 'income',
      name: categoryName,
    );
    if (category == null) {
      throw StateError('Income category not found.');
    }

    final incomeId = const Uuid().v4();
    final cashTransactionId = const Uuid().v4();
    final now = AppTime.nowUtc();
    final trimmedReason = _nullableTrimmed(reason);
    final trimmedNote = _nullableTrimmed(note);

    await transaction(() async {
      await into(localIncomes).insert(
        LocalIncomesCompanion(
          id: Value(incomeId),
          shopId: Value(currentUser.shopId),
          categoryId: Value(category.id),
          amount: Value(amount),
          reason: Value(trimmedReason),
          note: Value(trimmedNote),
          receiptUrl: Value(receiptUrl),
          createdAt: Value(AppTime.toUtc(incomeDate)),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await into(localCashTransactions).insert(
        LocalCashTransactionsCompanion(
          id: Value(cashTransactionId),
          shopId: Value(currentUser.shopId),
          type: const Value('income'),
          direction: const Value('in'),
          amount: Value(amount),
          referenceId: Value(incomeId),
          referenceType: const Value('income'),
          method: const Value('cash'),
          note: Value(trimmedReason ?? trimmedNote ?? category.name),
          createdAt: Value(AppTime.toUtc(incomeDate)),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });

    return incomeId;
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

    final now = AppTime.nowUtc();
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
        updatedAt: Value(AppTime.nowUtc()),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<void> deleteProductCategory(String id) async {
    await _softDeleteCategory(id);
  }

  Future<void> _softDeleteCategory(String id) async {
    final category = await (select(
      localCategories,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (category == null) {
      throw StateError('Category not found.');
    }

    final currentUser = await getCurrentUser();
    final now = AppTime.nowUtc();
    final deletedData = jsonEncode({
      'id': category.id,
      'shop_id': category.shopId,
      'name': category.name,
      'type': category.type,
      'details': category.details,
      'image_url': category.imageUrl,
      'created_at': AppTime.isoUtc(category.createdAt),
      'updated_at': AppTime.isoUtc(category.updatedAt),
      'deleted_at': AppTime.isoUtc(now),
    });

    await transaction(() async {
      await (update(
        localCategories,
      )..where((table) => table.id.equals(id))).write(
        LocalCategoriesCompanion(
          updatedAt: Value(now),
          deletedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await into(localRecycleBinEntries).insertOnConflictUpdate(
        LocalRecycleBinEntriesCompanion(
          id: Value(const Uuid().v4()),
          shopId: Value(category.shopId),
          sourceTableName: const Value('local_categories'),
          recordId: Value(category.id),
          displayTitle: Value(category.name),
          displaySubtitle: Value('${category.type} category'),
          deletedData: Value(deletedData),
          relatedData: const Value(null),
          deletedByUserId: Value(currentUser?.id),
          deletedAt: Value(now),
          restoredAt: const Value(null),
          restoreStatus: const Value('deleted'),
          restoreBlockReason: const Value(null),
          createdAt: Value(now),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });
  }

  Future<void> restoreProductCategory(String id) async {
    await (update(
      localCategories,
    )..where((table) => table.id.equals(id))).write(
      LocalCategoriesCompanion(
        updatedAt: Value(AppTime.nowUtc()),
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
    final now = AppTime.nowUtc();
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
    final now = AppTime.nowUtc();
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

    final now = AppTime.nowUtc();
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
        CASE
          WHEN s.sync_status != 'synced'
            OR EXISTS (
              SELECT 1
              FROM local_sale_returns sr_sync
              WHERE sr_sync.sale_id = s.id
                AND sr_sync.sync_status != 'synced'
            )
            OR EXISTS (
              SELECT 1
              FROM local_sale_return_items sri_sync
              INNER JOIN local_sale_returns sr_sync_items
                ON sr_sync_items.id = sri_sync.return_id
              WHERE sr_sync_items.sale_id = s.id
                AND sri_sync.sync_status != 'synced'
            )
            OR EXISTS (
              SELECT 1
              FROM local_cash_transactions ct_sync
              INNER JOIN local_sale_returns sr_sync_cash
                ON sr_sync_cash.id = ct_sync.reference_id
              WHERE sr_sync_cash.sale_id = s.id
                AND ct_sync.type = 'sales_return'
                AND ct_sync.sync_status != 'synced'
            )
          THEN 'pending'
          ELSE 'synced'
        END AS sync_status,
        COALESCE((
          SELECT SUM(payments)
          FROM local_customer_payments
          WHERE order_id = s.id
        ), 0.0) AS paid_amount,
        COALESCE((
          SELECT COUNT(*)
          FROM local_sale_items
          WHERE order_id = s.id
        ), 0) AS item_count,
        COALESCE((
          SELECT SUM(sr.refund_total)
          FROM local_sale_returns sr
          WHERE sr.sale_id = s.id
        ), 0.0) AS return_refund_total,
        COALESCE((
          SELECT SUM(sri.quantity)
          FROM local_sale_return_items sri
          INNER JOIN local_sale_returns sr ON sr.id = sri.return_id
          WHERE sr.sale_id = s.id
        ), 0) AS returned_item_count
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
        localSaleReturns,
        localSaleReturnItems,
        localCashTransactions,
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
              returnRefundTotal: row.read<double>('return_refund_total'),
              returnedItemCount: row.read<int>('returned_item_count'),
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
    final now = AppTime.nowUtc();
    final trimmedNote = _nullableTrimmed(note);

    await transaction(() async {
      await into(localPurchasePayments).insert(
        LocalPurchasePaymentsCompanion(
          id: Value(paymentId),
          shopId: Value(purchase.shopId),
          purchaseId: Value(purchase.id),
          payments: Value(amount),
          description: Value(trimmedNote ?? 'বাকি পরিশোধ'),
          createdAt: Value(AppTime.toUtc(paymentDate)),
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
          createdAt: Value(AppTime.toUtc(paymentDate)),
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
    final now = AppTime.nowUtc();
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
          createdAt: Value(AppTime.toUtc(paymentDate)),
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
          createdAt: Value(AppTime.toUtc(paymentDate)),
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
        pi.description AS description,
        COALESCE((
          SELECT SUM(sri.quantity)
          FROM local_sale_return_items sri
          WHERE sri.sale_item_id = si.id
        ), 0) AS returned_quantity
      FROM local_sale_items si
      LEFT JOIN local_purchase_items pi ON pi.id = si.product_id
      WHERE si.order_id = ?
      ORDER BY si.created_at ASC
      ''',
      variables: [Variable<String>(saleId)],
      readsFrom: {localSaleItems, localPurchaseItems, localSaleReturnItems},
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
              returnedQuantity: row.read<int>('returned_quantity'),
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
        SUM(available_quantity) AS stock_quantity,
        COALESCE(MAX(buying_price), 0.0) AS buying_price,
        COALESCE(MAX(est_selling_price), MAX(buying_price), 0.0) AS selling_price,
        SUM(available_quantity * COALESCE(buying_price, 0.0)) AS stock_value,
        SUM(
          available_quantity *
          (
            COALESCE(est_selling_price, buying_price, 0.0) -
            COALESCE(buying_price, 0.0)
          )
        ) AS expected_profit
      FROM (
        SELECT
          pi.*,
          pi.quantity - COALESCE((
            SELECT SUM(si.quantity)
            FROM local_sale_items si
            WHERE si.product_id = pi.id
          ), 0) + COALESCE((
            SELECT SUM(sri.quantity)
            FROM local_sale_return_items sri
            WHERE sri.product_id = pi.id
          ), 0) AS available_quantity
        FROM local_purchase_items pi
        WHERE pi.shop_id IN (
          SELECT shop_id
          FROM local_users
          WHERE is_current = 1
        )
          AND pi.deleted_at IS NULL
      ) AS available_batches
      GROUP BY COALESCE(category_id, product_name), product_name
      HAVING stock_quantity > 0
      ORDER BY product_name ASC
      ''',
      readsFrom: {
        localPurchaseItems,
        localSaleItems,
        localSaleReturnItems,
        localUsers,
      },
    ).watch().map(
      (rows) => rows
          .map(
            (row) => LocalSalesProduct(
              id: row.read<String>('id'),
              categoryId: row.readNullable<String>('category_id'),
              name: row.read<String>('product_name'),
              description: row.readNullable<String>('description'),
              stockQuantity: row.read<int>('stock_quantity'),
              buyingPrice: row.read<double>('buying_price'),
              sellingPrice: row.read<double>('selling_price'),
              stockValue: row.read<double>('stock_value'),
              expectedProfit: row.read<double>('expected_profit'),
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

    final now = AppTime.nowUtc();
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
        pi.barcode,
        pi.quantity - COALESCE((
          SELECT SUM(si.quantity)
          FROM local_sale_items si
          WHERE si.product_id = pi.id
        ), 0) + COALESCE((
          SELECT SUM(sri.quantity)
          FROM local_sale_return_items sri
          WHERE sri.product_id = pi.id
        ), 0) AS available_quantity,
        pi.created_at
      FROM local_purchase_items pi
      WHERE pi.shop_id = ?
        AND pi.deleted_at IS NULL
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
          ), 0) + COALESCE((
            SELECT SUM(sri.quantity)
            FROM local_sale_return_items sri
            WHERE sri.product_id = pi.id
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
      readsFrom: {localPurchaseItems, localSaleItems, localSaleReturnItems},
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
              barcode: row.readNullable<String>('barcode'),
              availableQuantity: row.read<int>('available_quantity'),
              createdAt: row.read<DateTime>('created_at'),
            ),
          )
          .toList(),
    );
  }

  Stream<List<LocalAvailablePurchaseBatch>>
  watchAvailablePurchaseBatchesForProduct({
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
        pi.barcode,
        pi.quantity - COALESCE((
          SELECT SUM(si.quantity)
          FROM local_sale_items si
          WHERE si.product_id = pi.id
        ), 0) + COALESCE((
          SELECT SUM(sri.quantity)
          FROM local_sale_return_items sri
          WHERE sri.product_id = pi.id
        ), 0) AS available_quantity,
        pi.created_at
      FROM local_purchase_items pi
      WHERE pi.shop_id IN (
        SELECT shop_id
        FROM local_users
        WHERE is_current = 1
      )
        AND pi.deleted_at IS NULL
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
          ), 0) + COALESCE((
            SELECT SUM(sri.quantity)
            FROM local_sale_return_items sri
            WHERE sri.product_id = pi.id
          ), 0)
        ) > 0
      ORDER BY pi.created_at DESC
      ''',
      variables: [
        Variable<String>(productName),
        Variable<int>(categoryId == null ? 1 : 0),
        Variable<String>(categoryId ?? ''),
      ],
      readsFrom: {
        localPurchaseItems,
        localSaleItems,
        localSaleReturnItems,
        localUsers,
      },
    ).watch().map(
      (rows) => rows
          .map(
            (row) => LocalAvailablePurchaseBatch(
              id: row.read<String>('id'),
              shopId: row.read<String>('shop_id'),
              categoryId: row.readNullable<String>('category_id'),
              productName: row.read<String>('product_name'),
              buyingPrice: row.read<double>('buying_price'),
              sellingPrice: row.read<double>('selling_price'),
              barcode: row.readNullable<String>('barcode'),
              availableQuantity: row.read<int>('available_quantity'),
              createdAt: row.read<DateTime>('created_at'),
            ),
          )
          .toList(),
    );
  }

  Future<void> updatePurchaseBatchStockLocally({
    required String id,
    required double buyingPrice,
    required double sellingPrice,
    required int availableQuantity,
  }) async {
    if (availableQuantity < 0) {
      throw ArgumentError.value(
        availableQuantity,
        'availableQuantity',
        'Stock cannot be negative.',
      );
    }

    final usedQuantity = await _usedQuantityForPurchaseItem(id);
    await (update(
      localPurchaseItems,
    )..where((item) => item.id.equals(id))).write(
      LocalPurchaseItemsCompanion(
        buyingPrice: Value(buyingPrice),
        estSellingPrice: Value(sellingPrice),
        quantity: Value(usedQuantity + availableQuantity),
        updatedAt: Value(AppTime.nowUtc()),
        syncStatus: const Value('pending'),
      ),
    );
  }

  Future<void> deletePurchaseBatchStockLocally(String id) async {
    final batch = await (select(
      localPurchaseItems,
    )..where((item) => item.id.equals(id))).getSingleOrNull();
    if (batch == null) {
      throw StateError('Stock batch not found.');
    }

    final currentUser = await getCurrentUser();
    final now = AppTime.nowUtc();
    final deletedData = jsonEncode({
      'id': batch.id,
      'shop_id': batch.shopId,
      'purchase_id': batch.purchaseId,
      'category_id': batch.categoryId,
      'product_name': batch.productName,
      'buying_price': batch.buyingPrice,
      'est_selling_price': batch.estSellingPrice,
      'quantity': batch.quantity,
      'barcode': batch.barcode,
      'other_charge': batch.otherCharge,
      'description': batch.description,
      'product_image': batch.productImage,
      'created_at': AppTime.isoUtc(batch.createdAt),
      'updated_at': AppTime.isoUtc(batch.updatedAt),
      'deleted_at': AppTime.isoUtc(now),
    });

    await transaction(() async {
      await (update(
        localPurchaseItems,
      )..where((item) => item.id.equals(id))).write(
        LocalPurchaseItemsCompanion(
          deletedAt: Value(now),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
      await into(localRecycleBinEntries).insertOnConflictUpdate(
        LocalRecycleBinEntriesCompanion(
          id: Value(const Uuid().v4()),
          shopId: Value(batch.shopId),
          sourceTableName: const Value('local_purchase_items'),
          recordId: Value(batch.id),
          displayTitle: Value(batch.productName),
          displaySubtitle: Value(
            'Stock batch • Qty ${batch.quantity} • Buy ${batch.buyingPrice}',
          ),
          deletedData: Value(deletedData),
          relatedData: const Value(null),
          deletedByUserId: Value(currentUser?.id),
          deletedAt: Value(now),
          restoredAt: const Value(null),
          restoreStatus: const Value('deleted'),
          restoreBlockReason: const Value(null),
          createdAt: Value(now),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });
  }

  Future<int> _usedQuantityForPurchaseItem(String id) async {
    final row = await customSelect(
      '''
          SELECT
            COALESCE((
              SELECT SUM(si.quantity)
              FROM local_sale_items si
              WHERE si.product_id = ?
            ), 0) - COALESCE((
              SELECT SUM(sri.quantity)
              FROM local_sale_return_items sri
              WHERE sri.product_id = ?
            ), 0) AS used_quantity
          ''',
      variables: [Variable<String>(id), Variable<String>(id)],
      readsFrom: {localSaleItems, localSaleReturnItems},
    ).getSingle();

    final usedQuantity = row.read<int>('used_quantity');
    return usedQuantity < 0 ? 0 : usedQuantity;
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

  Future<String> saveSalesReturnLocally({
    required String saleId,
    required List<LocalSaleReturnDraftItem> items,
    required String note,
  }) async {
    final currentUser = await getCurrentUser();
    if (currentUser == null) {
      throw StateError('No current user found.');
    }
    if (items.isEmpty) {
      throw StateError('No return items selected.');
    }

    for (final item in items) {
      final alreadyReturnedRow = await customSelect(
        '''
            SELECT
              si.quantity AS sold_quantity,
              COALESCE((
                SELECT SUM(sri.quantity)
                FROM local_sale_return_items sri
                WHERE sri.sale_item_id = si.id
              ), 0) AS returned_quantity
            FROM local_sale_items si
            WHERE si.id = ?
              AND si.order_id = ?
            LIMIT 1
            ''',
        variables: [
          Variable<String>(item.saleItemId),
          Variable<String>(saleId),
        ],
        readsFrom: {localSaleItems, localSaleReturnItems},
      ).getSingleOrNull();

      if (alreadyReturnedRow == null) {
        throw StateError('Return item was not found in this sale.');
      }

      final soldQuantity = alreadyReturnedRow.read<int>('sold_quantity');
      final returnedQuantity = alreadyReturnedRow.read<int>(
        'returned_quantity',
      );
      final returnableQuantity = soldQuantity - returnedQuantity;
      if (item.quantity > returnableQuantity) {
        throw StateError(
          '${item.productName} এর ফেরতযোগ্য পরিমাণ $returnableQuantityটি।',
        );
      }
    }

    final subtotal = items.fold<double>(
      0,
      (sum, item) => sum + item.salePrice * item.quantity,
    );
    const restockingFee = 0.0;
    final refundTotal = subtotal;
    if (refundTotal <= 0) {
      throw StateError('Return amount must be greater than zero.');
    }

    final now = AppTime.nowUtc();
    final returnId = const Uuid().v4();
    await transaction(() async {
      await into(localSaleReturns).insert(
        LocalSaleReturnsCompanion(
          id: Value(returnId),
          shopId: Value(currentUser.shopId),
          saleId: Value(saleId),
          subtotal: Value(subtotal),
          restockingFee: Value(restockingFee),
          refundTotal: Value(refundTotal),
          note: Value(_nullableTrimmed(note)),
          createdAt: Value(now),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );

      for (final item in items) {
        await into(localSaleReturnItems).insert(
          LocalSaleReturnItemsCompanion(
            id: Value(const Uuid().v4()),
            shopId: Value(currentUser.shopId),
            returnId: Value(returnId),
            saleItemId: Value(item.saleItemId),
            productId: Value(item.productId),
            productName: Value(item.productName),
            salePrice: Value(item.salePrice),
            quantity: Value(item.quantity),
            reason: Value(_nullableTrimmed(item.reason)),
            createdAt: Value(now),
            updatedAt: Value(now),
            syncStatus: const Value('pending'),
          ),
        );
      }

      await into(localCashTransactions).insert(
        LocalCashTransactionsCompanion(
          id: Value(const Uuid().v4()),
          shopId: Value(currentUser.shopId),
          type: const Value('sales_return'),
          direction: const Value('out'),
          amount: Value(refundTotal),
          referenceId: Value(returnId),
          referenceType: const Value('sales_return'),
          method: const Value('cash'),
          note: Value(_nullableTrimmed(note) ?? 'Sales return refund'),
          createdAt: Value(now),
          updatedAt: Value(now),
          syncStatus: const Value('pending'),
        ),
      );
    });

    return returnId;
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

  Future<List<LocalSaleReturnBundle>> getPendingSaleReturnBundles({
    String? shopId,
  }) async {
    final pendingReturnIds = await customSelect(
      '''
      SELECT sr.id
      FROM local_sale_returns sr
      WHERE (?1 IS NULL OR sr.shop_id = ?1)
        AND (
          sr.sync_status != 'synced'
          OR EXISTS (
            SELECT 1 FROM local_sale_return_items sri
            WHERE sri.return_id = sr.id AND sri.sync_status != 'synced'
          )
          OR EXISTS (
            SELECT 1 FROM local_cash_transactions ct
            WHERE ct.reference_id = sr.id
              AND ct.type = 'sales_return'
              AND ct.sync_status != 'synced'
          )
        )
      ''',
      variables: [Variable<String>(shopId)],
      readsFrom: {
        localSaleReturns,
        localSaleReturnItems,
        localCashTransactions,
      },
    ).get();

    final returnIds = pendingReturnIds
        .map((row) => row.read<String>('id'))
        .toList(growable: false);
    if (returnIds.isEmpty) {
      return [];
    }

    final returns = await (select(
      localSaleReturns,
    )..where((row) => row.id.isIn(returnIds))).get();
    final bundles = <LocalSaleReturnBundle>[];

    for (final saleReturn in returns) {
      final items = await (select(
        localSaleReturnItems,
      )..where((item) => item.returnId.equals(saleReturn.id))).get();
      final cashTransactions =
          await (select(localCashTransactions)..where(
                (transaction) =>
                    transaction.referenceId.equals(saleReturn.id) &
                    transaction.type.equals('sales_return'),
              ))
              .get();

      bundles.add(
        LocalSaleReturnBundle(
          saleReturn: saleReturn,
          items: items,
          cashTransactions: cashTransactions,
        ),
      );
    }

    return bundles;
  }

  Future<void> markSaleReturnBundleSynced(String returnId) async {
    await transaction(() async {
      await (update(localSaleReturns)..where((row) => row.id.equals(returnId)))
          .write(const LocalSaleReturnsCompanion(syncStatus: Value('synced')));
      await (update(
        localSaleReturnItems,
      )..where((item) => item.returnId.equals(returnId))).write(
        const LocalSaleReturnItemsCompanion(syncStatus: Value('synced')),
      );
      await (update(localCashTransactions)..where(
            (transaction) =>
                transaction.referenceId.equals(returnId) &
                transaction.type.equals('sales_return'),
          ))
          .write(
            const LocalCashTransactionsCompanion(syncStatus: Value('synced')),
          );
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

  Future<LocalIncomeSyncBundle> getPendingIncomeSyncBundle({
    String? shopId,
  }) async {
    final incomes =
        await (select(localIncomes)..where(
              (income) =>
                  income.syncStatus.equals('pending') &
                  (shopId == null
                      ? const Constant(true)
                      : income.shopId.equals(shopId)),
            ))
            .get();
    final cashTransactions =
        await (select(localCashTransactions)..where(
              (transaction) =>
                  transaction.type.equals('income') &
                  transaction.syncStatus.equals('pending') &
                  (shopId == null
                      ? const Constant(true)
                      : transaction.shopId.equals(shopId)),
            ))
            .get();

    return LocalIncomeSyncBundle(
      incomes: incomes,
      cashTransactions: cashTransactions,
    );
  }

  Future<void> markIncomeSyncBundleSynced(LocalIncomeSyncBundle bundle) async {
    await transaction(() async {
      for (final income in bundle.incomes) {
        await (update(localIncomes)
              ..where((table) => table.id.equals(income.id)))
            .write(const LocalIncomesCompanion(syncStatus: Value('synced')));
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

  Future<void> upsertSyncedIncomeData({
    required List<LocalIncomesCompanion> incomes,
    required List<LocalCashTransactionsCompanion> cashTransactions,
  }) {
    return transaction(() async {
      for (final income in incomes) {
        await into(localIncomes).insertOnConflictUpdate(income);
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
    required this.returnRefundTotal,
    required this.returnedItemCount,
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
  final double returnRefundTotal;
  final int returnedItemCount;
  final String status;
  final String? paymentMethod;
  final DateTime createdAt;
  final String syncStatus;

  double get netTotal =>
      (total - returnRefundTotal) < 0 ? 0 : total - returnRefundTotal;
  double get dueAmount {
    final due = netTotal - paidAmount;
    return due < 0 ? 0 : due;
  }

  bool get hasReturns => returnRefundTotal > 0 || returnedItemCount > 0;
}

class LocalSaleReturnDraftItem {
  const LocalSaleReturnDraftItem({
    required this.saleItemId,
    required this.productId,
    required this.productName,
    required this.salePrice,
    required this.quantity,
    required this.reason,
  });

  final String saleItemId;
  final String productId;
  final String productName;
  final double salePrice;
  final int quantity;
  final String reason;
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
    required this.returnedQuantity,
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
  final int returnedQuantity;

  int get returnableQuantity {
    final quantityLeft = quantity - returnedQuantity;
    return quantityLeft < 0 ? 0 : quantityLeft;
  }
}

class LocalAvailablePurchaseBatch {
  const LocalAvailablePurchaseBatch({
    required this.id,
    required this.shopId,
    required this.categoryId,
    required this.productName,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.barcode,
    required this.availableQuantity,
    required this.createdAt,
  });

  final String id;
  final String shopId;
  final String? categoryId;
  final String productName;
  final double buyingPrice;
  final double sellingPrice;
  final String? barcode;
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

class LocalSaleReturnBundle {
  const LocalSaleReturnBundle({
    required this.saleReturn,
    required this.items,
    required this.cashTransactions,
  });

  final LocalSaleReturn saleReturn;
  final List<LocalSaleReturnItem> items;
  final List<LocalCashTransaction> cashTransactions;
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

class LocalIncomeSyncBundle {
  const LocalIncomeSyncBundle({
    required this.incomes,
    required this.cashTransactions,
  });

  final List<LocalIncome> incomes;
  final List<LocalCashTransaction> cashTransactions;

  bool get isEmpty => incomes.isEmpty && cashTransactions.isEmpty;
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

class LocalOwnerTransactionEntry {
  const LocalOwnerTransactionEntry({
    required this.id,
    required this.type,
    required this.direction,
    required this.amount,
    required this.referenceId,
    required this.referenceType,
    required this.method,
    required this.note,
    required this.createdAt,
    required this.syncStatus,
  });

  final String id;
  final String type;
  final String direction;
  final double amount;
  final String? referenceId;
  final String? referenceType;
  final String? method;
  final String? note;
  final DateTime createdAt;
  final String syncStatus;

  bool get isGiven => type == 'owner_given';
  bool get isTaken => type == 'owner_taken';
}

class LocalSalesProduct {
  const LocalSalesProduct({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.stockQuantity,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.stockValue,
    required this.expectedProfit,
  });

  final String id;
  final String? categoryId;
  final String name;
  final String? description;
  final int stockQuantity;
  final double buyingPrice;
  final double sellingPrice;
  final double stockValue;
  final double expectedProfit;
}
