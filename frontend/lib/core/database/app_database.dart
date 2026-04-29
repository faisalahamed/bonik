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
  TextColumn get imageUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [LocalShops, LocalUsers, LocalCategories])
final class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'bonik'));

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(localUsers, localUsers.passwordHash);
      }
      if (from < 3) {
        await migrator.createTable(localCategories);
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

  Future<LocalCategory> createProductCategory(String name) async {
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
      createdAt: Value(now),
      updatedAt: Value(now),
      syncStatus: const Value('pending'),
    );

    await into(localCategories).insert(category);

    return (select(
      localCategories,
    )..where((table) => table.id.equals(id))).getSingle();
  }

  Future<List<LocalCategory>> getPendingProductCategories() {
    return (select(localCategories)..where(
          (category) =>
              category.type.equals('product') &
              category.syncStatus.equals('pending'),
        ))
        .get();
  }

  Future<void> markCategorySynced(String id) async {
    await (update(localCategories)..where((category) => category.id.equals(id)))
        .write(const LocalCategoriesCompanion(syncStatus: Value('synced')));
  }

  Future<void> upsertSyncedCategories(
    List<LocalCategoriesCompanion> rows,
  ) async {
    await transaction(() async {
      for (final row in rows) {
        final serverId = row.id.value;
        final shopId = row.shopId.value;
        final type = row.type.value;
        final name = row.name.value;

        await (delete(localCategories)..where(
              (category) =>
                  category.id.equalsExp(Variable(serverId)).not() &
                  category.shopId.equals(shopId) &
                  category.type.equals(type) &
                  category.name.lower().equals(name.toLowerCase()),
            ))
            .go();

        await into(localCategories).insertOnConflictUpdate(row);
      }
    });
  }

  Future<LocalCategory?> _findCategoryByName({
    required String shopId,
    required String type,
    required String name,
  }) {
    return (select(localCategories)
          ..where(
            (category) =>
                category.shopId.equals(shopId) &
                category.type.equals(type) &
                category.deletedAt.isNull() &
                category.name.lower().equals(name.toLowerCase()),
          )
          ..limit(1))
        .getSingleOrNull();
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});
