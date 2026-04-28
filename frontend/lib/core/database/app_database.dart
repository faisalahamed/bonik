import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

@DriftDatabase(tables: [LocalShops, LocalUsers])
final class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'bonik'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(localUsers, localUsers.passwordHash);
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
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});
