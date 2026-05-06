// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalShopsTable extends LocalShops
    with TableInfo<$LocalShopsTable, LocalShop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalShopsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopNameMeta = const VerificationMeta(
    'shopName',
  );
  @override
  late final GeneratedColumn<String> shopName = GeneratedColumn<String>(
    'shop_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopMobileMeta = const VerificationMeta(
    'shopMobile',
  );
  @override
  late final GeneratedColumn<String> shopMobile = GeneratedColumn<String>(
    'shop_mobile',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopWebsiteMeta = const VerificationMeta(
    'shopWebsite',
  );
  @override
  late final GeneratedColumn<String> shopWebsite = GeneratedColumn<String>(
    'shop_website',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shopAddressMeta = const VerificationMeta(
    'shopAddress',
  );
  @override
  late final GeneratedColumn<String> shopAddress = GeneratedColumn<String>(
    'shop_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopName,
    email,
    shopMobile,
    shopWebsite,
    shopAddress,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_shops';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalShop> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_name')) {
      context.handle(
        _shopNameMeta,
        shopName.isAcceptableOrUnknown(data['shop_name']!, _shopNameMeta),
      );
    } else if (isInserting) {
      context.missing(_shopNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('shop_mobile')) {
      context.handle(
        _shopMobileMeta,
        shopMobile.isAcceptableOrUnknown(data['shop_mobile']!, _shopMobileMeta),
      );
    } else if (isInserting) {
      context.missing(_shopMobileMeta);
    }
    if (data.containsKey('shop_website')) {
      context.handle(
        _shopWebsiteMeta,
        shopWebsite.isAcceptableOrUnknown(
          data['shop_website']!,
          _shopWebsiteMeta,
        ),
      );
    }
    if (data.containsKey('shop_address')) {
      context.handle(
        _shopAddressMeta,
        shopAddress.isAcceptableOrUnknown(
          data['shop_address']!,
          _shopAddressMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalShop map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalShop(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      shopMobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_mobile'],
      )!,
      shopWebsite: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_website'],
      ),
      shopAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_address'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalShopsTable createAlias(String alias) {
    return $LocalShopsTable(attachedDatabase, alias);
  }
}

class LocalShop extends DataClass implements Insertable<LocalShop> {
  final String id;
  final String shopName;
  final String email;
  final String shopMobile;
  final String? shopWebsite;
  final String? shopAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalShop({
    required this.id,
    required this.shopName,
    required this.email,
    required this.shopMobile,
    this.shopWebsite,
    this.shopAddress,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_name'] = Variable<String>(shopName);
    map['email'] = Variable<String>(email);
    map['shop_mobile'] = Variable<String>(shopMobile);
    if (!nullToAbsent || shopWebsite != null) {
      map['shop_website'] = Variable<String>(shopWebsite);
    }
    if (!nullToAbsent || shopAddress != null) {
      map['shop_address'] = Variable<String>(shopAddress);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalShopsCompanion toCompanion(bool nullToAbsent) {
    return LocalShopsCompanion(
      id: Value(id),
      shopName: Value(shopName),
      email: Value(email),
      shopMobile: Value(shopMobile),
      shopWebsite: shopWebsite == null && nullToAbsent
          ? const Value.absent()
          : Value(shopWebsite),
      shopAddress: shopAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(shopAddress),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalShop.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalShop(
      id: serializer.fromJson<String>(json['id']),
      shopName: serializer.fromJson<String>(json['shopName']),
      email: serializer.fromJson<String>(json['email']),
      shopMobile: serializer.fromJson<String>(json['shopMobile']),
      shopWebsite: serializer.fromJson<String?>(json['shopWebsite']),
      shopAddress: serializer.fromJson<String?>(json['shopAddress']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopName': serializer.toJson<String>(shopName),
      'email': serializer.toJson<String>(email),
      'shopMobile': serializer.toJson<String>(shopMobile),
      'shopWebsite': serializer.toJson<String?>(shopWebsite),
      'shopAddress': serializer.toJson<String?>(shopAddress),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalShop copyWith({
    String? id,
    String? shopName,
    String? email,
    String? shopMobile,
    Value<String?> shopWebsite = const Value.absent(),
    Value<String?> shopAddress = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalShop(
    id: id ?? this.id,
    shopName: shopName ?? this.shopName,
    email: email ?? this.email,
    shopMobile: shopMobile ?? this.shopMobile,
    shopWebsite: shopWebsite.present ? shopWebsite.value : this.shopWebsite,
    shopAddress: shopAddress.present ? shopAddress.value : this.shopAddress,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalShop copyWithCompanion(LocalShopsCompanion data) {
    return LocalShop(
      id: data.id.present ? data.id.value : this.id,
      shopName: data.shopName.present ? data.shopName.value : this.shopName,
      email: data.email.present ? data.email.value : this.email,
      shopMobile: data.shopMobile.present
          ? data.shopMobile.value
          : this.shopMobile,
      shopWebsite: data.shopWebsite.present
          ? data.shopWebsite.value
          : this.shopWebsite,
      shopAddress: data.shopAddress.present
          ? data.shopAddress.value
          : this.shopAddress,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalShop(')
          ..write('id: $id, ')
          ..write('shopName: $shopName, ')
          ..write('email: $email, ')
          ..write('shopMobile: $shopMobile, ')
          ..write('shopWebsite: $shopWebsite, ')
          ..write('shopAddress: $shopAddress, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopName,
    email,
    shopMobile,
    shopWebsite,
    shopAddress,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalShop &&
          other.id == this.id &&
          other.shopName == this.shopName &&
          other.email == this.email &&
          other.shopMobile == this.shopMobile &&
          other.shopWebsite == this.shopWebsite &&
          other.shopAddress == this.shopAddress &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalShopsCompanion extends UpdateCompanion<LocalShop> {
  final Value<String> id;
  final Value<String> shopName;
  final Value<String> email;
  final Value<String> shopMobile;
  final Value<String?> shopWebsite;
  final Value<String?> shopAddress;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalShopsCompanion({
    this.id = const Value.absent(),
    this.shopName = const Value.absent(),
    this.email = const Value.absent(),
    this.shopMobile = const Value.absent(),
    this.shopWebsite = const Value.absent(),
    this.shopAddress = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalShopsCompanion.insert({
    required String id,
    required String shopName,
    required String email,
    required String shopMobile,
    this.shopWebsite = const Value.absent(),
    this.shopAddress = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopName = Value(shopName),
       email = Value(email),
       shopMobile = Value(shopMobile),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalShop> custom({
    Expression<String>? id,
    Expression<String>? shopName,
    Expression<String>? email,
    Expression<String>? shopMobile,
    Expression<String>? shopWebsite,
    Expression<String>? shopAddress,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopName != null) 'shop_name': shopName,
      if (email != null) 'email': email,
      if (shopMobile != null) 'shop_mobile': shopMobile,
      if (shopWebsite != null) 'shop_website': shopWebsite,
      if (shopAddress != null) 'shop_address': shopAddress,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalShopsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopName,
    Value<String>? email,
    Value<String>? shopMobile,
    Value<String?>? shopWebsite,
    Value<String?>? shopAddress,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalShopsCompanion(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      email: email ?? this.email,
      shopMobile: shopMobile ?? this.shopMobile,
      shopWebsite: shopWebsite ?? this.shopWebsite,
      shopAddress: shopAddress ?? this.shopAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopName.present) {
      map['shop_name'] = Variable<String>(shopName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (shopMobile.present) {
      map['shop_mobile'] = Variable<String>(shopMobile.value);
    }
    if (shopWebsite.present) {
      map['shop_website'] = Variable<String>(shopWebsite.value);
    }
    if (shopAddress.present) {
      map['shop_address'] = Variable<String>(shopAddress.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalShopsCompanion(')
          ..write('id: $id, ')
          ..write('shopName: $shopName, ')
          ..write('email: $email, ')
          ..write('shopMobile: $shopMobile, ')
          ..write('shopWebsite: $shopWebsite, ')
          ..write('shopAddress: $shopAddress, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalUsersTable extends LocalUsers
    with TableInfo<$LocalUsersTable, LocalUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailVerifiedAtMeta = const VerificationMeta(
    'emailVerifiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> emailVerifiedAt =
      GeneratedColumn<DateTime>(
        'email_verified_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _isCurrentMeta = const VerificationMeta(
    'isCurrent',
  );
  @override
  late final GeneratedColumn<bool> isCurrent = GeneratedColumn<bool>(
    'is_current',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_current" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    name,
    email,
    passwordHash,
    role,
    emailVerifiedAt,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    isCurrent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_users';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalUser> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('email_verified_at')) {
      context.handle(
        _emailVerifiedAtMeta,
        emailVerifiedAt.isAcceptableOrUnknown(
          data['email_verified_at']!,
          _emailVerifiedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('is_current')) {
      context.handle(
        _isCurrentMeta,
        isCurrent.isAcceptableOrUnknown(data['is_current']!, _isCurrentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUser(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      emailVerifiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}email_verified_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      isCurrent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_current'],
      )!,
    );
  }

  @override
  $LocalUsersTable createAlias(String alias) {
    return $LocalUsersTable(attachedDatabase, alias);
  }
}

class LocalUser extends DataClass implements Insertable<LocalUser> {
  final String id;
  final String shopId;
  final String name;
  final String email;
  final String? passwordHash;
  final String role;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  final bool isCurrent;
  const LocalUser({
    required this.id,
    required this.shopId,
    required this.name,
    required this.email,
    this.passwordHash,
    required this.role,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
    required this.isCurrent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || passwordHash != null) {
      map['password_hash'] = Variable<String>(passwordHash);
    }
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || emailVerifiedAt != null) {
      map['email_verified_at'] = Variable<DateTime>(emailVerifiedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['is_current'] = Variable<bool>(isCurrent);
    return map;
  }

  LocalUsersCompanion toCompanion(bool nullToAbsent) {
    return LocalUsersCompanion(
      id: Value(id),
      shopId: Value(shopId),
      name: Value(name),
      email: Value(email),
      passwordHash: passwordHash == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordHash),
      role: Value(role),
      emailVerifiedAt: emailVerifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(emailVerifiedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
      isCurrent: Value(isCurrent),
    );
  }

  factory LocalUser.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUser(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String?>(json['passwordHash']),
      role: serializer.fromJson<String>(json['role']),
      emailVerifiedAt: serializer.fromJson<DateTime?>(json['emailVerifiedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      isCurrent: serializer.fromJson<bool>(json['isCurrent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String?>(passwordHash),
      'role': serializer.toJson<String>(role),
      'emailVerifiedAt': serializer.toJson<DateTime?>(emailVerifiedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'isCurrent': serializer.toJson<bool>(isCurrent),
    };
  }

  LocalUser copyWith({
    String? id,
    String? shopId,
    String? name,
    String? email,
    Value<String?> passwordHash = const Value.absent(),
    String? role,
    Value<DateTime?> emailVerifiedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
    bool? isCurrent,
  }) => LocalUser(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    name: name ?? this.name,
    email: email ?? this.email,
    passwordHash: passwordHash.present ? passwordHash.value : this.passwordHash,
    role: role ?? this.role,
    emailVerifiedAt: emailVerifiedAt.present
        ? emailVerifiedAt.value
        : this.emailVerifiedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    isCurrent: isCurrent ?? this.isCurrent,
  );
  LocalUser copyWithCompanion(LocalUsersCompanion data) {
    return LocalUser(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      role: data.role.present ? data.role.value : this.role,
      emailVerifiedAt: data.emailVerifiedAt.present
          ? data.emailVerifiedAt.value
          : this.emailVerifiedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      isCurrent: data.isCurrent.present ? data.isCurrent.value : this.isCurrent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUser(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('emailVerifiedAt: $emailVerifiedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isCurrent: $isCurrent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    name,
    email,
    passwordHash,
    role,
    emailVerifiedAt,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
    isCurrent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUser &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.name == this.name &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.role == this.role &&
          other.emailVerifiedAt == this.emailVerifiedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus &&
          other.isCurrent == this.isCurrent);
}

class LocalUsersCompanion extends UpdateCompanion<LocalUser> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> name;
  final Value<String> email;
  final Value<String?> passwordHash;
  final Value<String> role;
  final Value<DateTime?> emailVerifiedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<bool> isCurrent;
  final Value<int> rowid;
  const LocalUsersCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.role = const Value.absent(),
    this.emailVerifiedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isCurrent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUsersCompanion.insert({
    required String id,
    required String shopId,
    required String name,
    required String email,
    this.passwordHash = const Value.absent(),
    required String role,
    this.emailVerifiedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.isCurrent = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       name = Value(name),
       email = Value(email),
       role = Value(role),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalUser> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<String>? role,
    Expression<DateTime>? emailVerifiedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<bool>? isCurrent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (role != null) 'role': role,
      if (emailVerifiedAt != null) 'email_verified_at': emailVerifiedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (isCurrent != null) 'is_current': isCurrent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUsersCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? name,
    Value<String>? email,
    Value<String?>? passwordHash,
    Value<String>? role,
    Value<DateTime?>? emailVerifiedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<bool>? isCurrent,
    Value<int>? rowid,
  }) {
    return LocalUsersCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      role: role ?? this.role,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      isCurrent: isCurrent ?? this.isCurrent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (emailVerifiedAt.present) {
      map['email_verified_at'] = Variable<DateTime>(emailVerifiedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (isCurrent.present) {
      map['is_current'] = Variable<bool>(isCurrent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalUsersCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('role: $role, ')
          ..write('emailVerifiedAt: $emailVerifiedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('isCurrent: $isCurrent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCategoriesTable extends LocalCategories
    with TableInfo<$LocalCategoriesTable, LocalCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    name,
    type,
    details,
    imageUrl,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalCategoriesTable createAlias(String alias) {
    return $LocalCategoriesTable(attachedDatabase, alias);
  }
}

class LocalCategory extends DataClass implements Insertable<LocalCategory> {
  final String id;
  final String shopId;
  final String name;
  final String type;
  final String? details;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalCategory({
    required this.id,
    required this.shopId,
    required this.name,
    required this.type,
    this.details,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalCategoriesCompanion toCompanion(bool nullToAbsent) {
    return LocalCategoriesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      name: Value(name),
      type: Value(type),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCategory(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      details: serializer.fromJson<String?>(json['details']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'details': serializer.toJson<String?>(details),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalCategory copyWith({
    String? id,
    String? shopId,
    String? name,
    String? type,
    Value<String?> details = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalCategory(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    name: name ?? this.name,
    type: type ?? this.type,
    details: details.present ? details.value : this.details,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalCategory copyWithCompanion(LocalCategoriesCompanion data) {
    return LocalCategory(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      details: data.details.present ? data.details.value : this.details,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCategory(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('details: $details, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    name,
    type,
    details,
    imageUrl,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCategory &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.name == this.name &&
          other.type == this.type &&
          other.details == this.details &&
          other.imageUrl == this.imageUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalCategoriesCompanion extends UpdateCompanion<LocalCategory> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> name;
  final Value<String> type;
  final Value<String?> details;
  final Value<String?> imageUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalCategoriesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.details = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCategoriesCompanion.insert({
    required String id,
    required String shopId,
    required String name,
    required String type,
    this.details = const Value.absent(),
    this.imageUrl = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       name = Value(name),
       type = Value(type),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalCategory> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? details,
    Expression<String>? imageUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (details != null) 'details': details,
      if (imageUrl != null) 'image_url': imageUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? name,
    Value<String>? type,
    Value<String?>? details,
    Value<String?>? imageUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalCategoriesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      type: type ?? this.type,
      details: details ?? this.details,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('details: $details, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSuppliersTable extends LocalSuppliers
    with TableInfo<$LocalSuppliersTable, LocalSupplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
    'mobile',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    name,
    image,
    mobile,
    address,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_suppliers';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSupplier> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    }
    if (data.containsKey('mobile')) {
      context.handle(
        _mobileMeta,
        mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSupplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSupplier(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      ),
      mobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalSuppliersTable createAlias(String alias) {
    return $LocalSuppliersTable(attachedDatabase, alias);
  }
}

class LocalSupplier extends DataClass implements Insertable<LocalSupplier> {
  final String id;
  final String shopId;
  final String name;
  final String? image;
  final String? mobile;
  final String? address;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalSupplier({
    required this.id,
    required this.shopId,
    required this.name,
    this.image,
    this.mobile,
    this.address,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || mobile != null) {
      map['mobile'] = Variable<String>(mobile);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalSuppliersCompanion toCompanion(bool nullToAbsent) {
    return LocalSuppliersCompanion(
      id: Value(id),
      shopId: Value(shopId),
      name: Value(name),
      image: image == null && nullToAbsent
          ? const Value.absent()
          : Value(image),
      mobile: mobile == null && nullToAbsent
          ? const Value.absent()
          : Value(mobile),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalSupplier.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSupplier(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String?>(json['image']),
      mobile: serializer.fromJson<String?>(json['mobile']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String?>(image),
      'mobile': serializer.toJson<String?>(mobile),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalSupplier copyWith({
    String? id,
    String? shopId,
    String? name,
    Value<String?> image = const Value.absent(),
    Value<String?> mobile = const Value.absent(),
    Value<String?> address = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalSupplier(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    name: name ?? this.name,
    image: image.present ? image.value : this.image,
    mobile: mobile.present ? mobile.value : this.mobile,
    address: address.present ? address.value : this.address,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalSupplier copyWithCompanion(LocalSuppliersCompanion data) {
    return LocalSupplier(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      name: data.name.present ? data.name.value : this.name,
      image: data.image.present ? data.image.value : this.image,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSupplier(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('mobile: $mobile, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    name,
    image,
    mobile,
    address,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSupplier &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.name == this.name &&
          other.image == this.image &&
          other.mobile == this.mobile &&
          other.address == this.address &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalSuppliersCompanion extends UpdateCompanion<LocalSupplier> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> name;
  final Value<String?> image;
  final Value<String?> mobile;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalSuppliersCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.mobile = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSuppliersCompanion.insert({
    required String id,
    required String shopId,
    required String name,
    this.image = const Value.absent(),
    this.mobile = const Value.absent(),
    this.address = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalSupplier> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? name,
    Expression<String>? image,
    Expression<String>? mobile,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (mobile != null) 'mobile': mobile,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSuppliersCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? name,
    Value<String?>? image,
    Value<String?>? mobile,
    Value<String?>? address,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalSuppliersCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      image: image ?? this.image,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSuppliersCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('mobile: $mobile, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalPurchasesTable extends LocalPurchases
    with TableInfo<$LocalPurchasesTable, LocalPurchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta(
    'supplierId',
  );
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_suppliers (id)',
    ),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _otherChargeMeta = const VerificationMeta(
    'otherCharge',
  );
  @override
  late final GeneratedColumn<double> otherCharge = GeneratedColumn<double>(
    'other_charge',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _buyingMemoUrlMeta = const VerificationMeta(
    'buyingMemoUrl',
  );
  @override
  late final GeneratedColumn<String> buyingMemoUrl = GeneratedColumn<String>(
    'buying_memo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    supplierId,
    total,
    otherCharge,
    description,
    buyingMemoUrl,
    status,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_purchases';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalPurchase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
        _supplierIdMeta,
        supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('other_charge')) {
      context.handle(
        _otherChargeMeta,
        otherCharge.isAcceptableOrUnknown(
          data['other_charge']!,
          _otherChargeMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('buying_memo_url')) {
      context.handle(
        _buyingMemoUrlMeta,
        buyingMemoUrl.isAcceptableOrUnknown(
          data['buying_memo_url']!,
          _buyingMemoUrlMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalPurchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPurchase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_id'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      otherCharge: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}other_charge'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      buyingMemoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}buying_memo_url'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalPurchasesTable createAlias(String alias) {
    return $LocalPurchasesTable(attachedDatabase, alias);
  }
}

class LocalPurchase extends DataClass implements Insertable<LocalPurchase> {
  final String id;
  final String shopId;
  final String supplierId;
  final double total;
  final double otherCharge;
  final String? description;
  final String? buyingMemoUrl;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalPurchase({
    required this.id,
    required this.shopId,
    required this.supplierId,
    required this.total,
    required this.otherCharge,
    this.description,
    this.buyingMemoUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['supplier_id'] = Variable<String>(supplierId);
    map['total'] = Variable<double>(total);
    map['other_charge'] = Variable<double>(otherCharge);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || buyingMemoUrl != null) {
      map['buying_memo_url'] = Variable<String>(buyingMemoUrl);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalPurchasesCompanion toCompanion(bool nullToAbsent) {
    return LocalPurchasesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      supplierId: Value(supplierId),
      total: Value(total),
      otherCharge: Value(otherCharge),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      buyingMemoUrl: buyingMemoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(buyingMemoUrl),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalPurchase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPurchase(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      total: serializer.fromJson<double>(json['total']),
      otherCharge: serializer.fromJson<double>(json['otherCharge']),
      description: serializer.fromJson<String?>(json['description']),
      buyingMemoUrl: serializer.fromJson<String?>(json['buyingMemoUrl']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'supplierId': serializer.toJson<String>(supplierId),
      'total': serializer.toJson<double>(total),
      'otherCharge': serializer.toJson<double>(otherCharge),
      'description': serializer.toJson<String?>(description),
      'buyingMemoUrl': serializer.toJson<String?>(buyingMemoUrl),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalPurchase copyWith({
    String? id,
    String? shopId,
    String? supplierId,
    double? total,
    double? otherCharge,
    Value<String?> description = const Value.absent(),
    Value<String?> buyingMemoUrl = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalPurchase(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    supplierId: supplierId ?? this.supplierId,
    total: total ?? this.total,
    otherCharge: otherCharge ?? this.otherCharge,
    description: description.present ? description.value : this.description,
    buyingMemoUrl: buyingMemoUrl.present
        ? buyingMemoUrl.value
        : this.buyingMemoUrl,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalPurchase copyWithCompanion(LocalPurchasesCompanion data) {
    return LocalPurchase(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      supplierId: data.supplierId.present
          ? data.supplierId.value
          : this.supplierId,
      total: data.total.present ? data.total.value : this.total,
      otherCharge: data.otherCharge.present
          ? data.otherCharge.value
          : this.otherCharge,
      description: data.description.present
          ? data.description.value
          : this.description,
      buyingMemoUrl: data.buyingMemoUrl.present
          ? data.buyingMemoUrl.value
          : this.buyingMemoUrl,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalPurchase(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('supplierId: $supplierId, ')
          ..write('total: $total, ')
          ..write('otherCharge: $otherCharge, ')
          ..write('description: $description, ')
          ..write('buyingMemoUrl: $buyingMemoUrl, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    supplierId,
    total,
    otherCharge,
    description,
    buyingMemoUrl,
    status,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPurchase &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.supplierId == this.supplierId &&
          other.total == this.total &&
          other.otherCharge == this.otherCharge &&
          other.description == this.description &&
          other.buyingMemoUrl == this.buyingMemoUrl &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalPurchasesCompanion extends UpdateCompanion<LocalPurchase> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> supplierId;
  final Value<double> total;
  final Value<double> otherCharge;
  final Value<String?> description;
  final Value<String?> buyingMemoUrl;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalPurchasesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.total = const Value.absent(),
    this.otherCharge = const Value.absent(),
    this.description = const Value.absent(),
    this.buyingMemoUrl = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalPurchasesCompanion.insert({
    required String id,
    required String shopId,
    required String supplierId,
    required double total,
    this.otherCharge = const Value.absent(),
    this.description = const Value.absent(),
    this.buyingMemoUrl = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       supplierId = Value(supplierId),
       total = Value(total),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalPurchase> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? supplierId,
    Expression<double>? total,
    Expression<double>? otherCharge,
    Expression<String>? description,
    Expression<String>? buyingMemoUrl,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (supplierId != null) 'supplier_id': supplierId,
      if (total != null) 'total': total,
      if (otherCharge != null) 'other_charge': otherCharge,
      if (description != null) 'description': description,
      if (buyingMemoUrl != null) 'buying_memo_url': buyingMemoUrl,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalPurchasesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? supplierId,
    Value<double>? total,
    Value<double>? otherCharge,
    Value<String?>? description,
    Value<String?>? buyingMemoUrl,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalPurchasesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      supplierId: supplierId ?? this.supplierId,
      total: total ?? this.total,
      otherCharge: otherCharge ?? this.otherCharge,
      description: description ?? this.description,
      buyingMemoUrl: buyingMemoUrl ?? this.buyingMemoUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (otherCharge.present) {
      map['other_charge'] = Variable<double>(otherCharge.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (buyingMemoUrl.present) {
      map['buying_memo_url'] = Variable<String>(buyingMemoUrl.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPurchasesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('supplierId: $supplierId, ')
          ..write('total: $total, ')
          ..write('otherCharge: $otherCharge, ')
          ..write('description: $description, ')
          ..write('buyingMemoUrl: $buyingMemoUrl, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalPurchaseItemsTable extends LocalPurchaseItems
    with TableInfo<$LocalPurchaseItemsTable, LocalPurchaseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPurchaseItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<String> purchaseId = GeneratedColumn<String>(
    'purchase_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_purchases (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_categories (id)',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _buyingPriceMeta = const VerificationMeta(
    'buyingPrice',
  );
  @override
  late final GeneratedColumn<double> buyingPrice = GeneratedColumn<double>(
    'buying_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estSellingPriceMeta = const VerificationMeta(
    'estSellingPrice',
  );
  @override
  late final GeneratedColumn<double> estSellingPrice = GeneratedColumn<double>(
    'est_selling_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _otherChargeMeta = const VerificationMeta(
    'otherCharge',
  );
  @override
  late final GeneratedColumn<double> otherCharge = GeneratedColumn<double>(
    'other_charge',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productImageMeta = const VerificationMeta(
    'productImage',
  );
  @override
  late final GeneratedColumn<String> productImage = GeneratedColumn<String>(
    'product_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    purchaseId,
    categoryId,
    productName,
    buyingPrice,
    estSellingPrice,
    quantity,
    barcode,
    otherCharge,
    description,
    productImage,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_purchase_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalPurchaseItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('buying_price')) {
      context.handle(
        _buyingPriceMeta,
        buyingPrice.isAcceptableOrUnknown(
          data['buying_price']!,
          _buyingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_buyingPriceMeta);
    }
    if (data.containsKey('est_selling_price')) {
      context.handle(
        _estSellingPriceMeta,
        estSellingPrice.isAcceptableOrUnknown(
          data['est_selling_price']!,
          _estSellingPriceMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('other_charge')) {
      context.handle(
        _otherChargeMeta,
        otherCharge.isAcceptableOrUnknown(
          data['other_charge']!,
          _otherChargeMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('product_image')) {
      context.handle(
        _productImageMeta,
        productImage.isAcceptableOrUnknown(
          data['product_image']!,
          _productImageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalPurchaseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPurchaseItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_id'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      buyingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}buying_price'],
      )!,
      estSellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}est_selling_price'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      otherCharge: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}other_charge'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      productImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_image'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalPurchaseItemsTable createAlias(String alias) {
    return $LocalPurchaseItemsTable(attachedDatabase, alias);
  }
}

class LocalPurchaseItem extends DataClass
    implements Insertable<LocalPurchaseItem> {
  final String id;
  final String shopId;
  final String? purchaseId;
  final String? categoryId;
  final String productName;
  final double buyingPrice;
  final double? estSellingPrice;
  final int quantity;
  final String? barcode;
  final double otherCharge;
  final String? description;
  final String? productImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalPurchaseItem({
    required this.id,
    required this.shopId,
    this.purchaseId,
    this.categoryId,
    required this.productName,
    required this.buyingPrice,
    this.estSellingPrice,
    required this.quantity,
    this.barcode,
    required this.otherCharge,
    this.description,
    this.productImage,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    if (!nullToAbsent || purchaseId != null) {
      map['purchase_id'] = Variable<String>(purchaseId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['product_name'] = Variable<String>(productName);
    map['buying_price'] = Variable<double>(buyingPrice);
    if (!nullToAbsent || estSellingPrice != null) {
      map['est_selling_price'] = Variable<double>(estSellingPrice);
    }
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['other_charge'] = Variable<double>(otherCharge);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || productImage != null) {
      map['product_image'] = Variable<String>(productImage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalPurchaseItemsCompanion toCompanion(bool nullToAbsent) {
    return LocalPurchaseItemsCompanion(
      id: Value(id),
      shopId: Value(shopId),
      purchaseId: purchaseId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      productName: Value(productName),
      buyingPrice: Value(buyingPrice),
      estSellingPrice: estSellingPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(estSellingPrice),
      quantity: Value(quantity),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      otherCharge: Value(otherCharge),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      productImage: productImage == null && nullToAbsent
          ? const Value.absent()
          : Value(productImage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalPurchaseItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPurchaseItem(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      purchaseId: serializer.fromJson<String?>(json['purchaseId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      productName: serializer.fromJson<String>(json['productName']),
      buyingPrice: serializer.fromJson<double>(json['buyingPrice']),
      estSellingPrice: serializer.fromJson<double?>(json['estSellingPrice']),
      quantity: serializer.fromJson<int>(json['quantity']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      otherCharge: serializer.fromJson<double>(json['otherCharge']),
      description: serializer.fromJson<String?>(json['description']),
      productImage: serializer.fromJson<String?>(json['productImage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'purchaseId': serializer.toJson<String?>(purchaseId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'productName': serializer.toJson<String>(productName),
      'buyingPrice': serializer.toJson<double>(buyingPrice),
      'estSellingPrice': serializer.toJson<double?>(estSellingPrice),
      'quantity': serializer.toJson<int>(quantity),
      'barcode': serializer.toJson<String?>(barcode),
      'otherCharge': serializer.toJson<double>(otherCharge),
      'description': serializer.toJson<String?>(description),
      'productImage': serializer.toJson<String?>(productImage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalPurchaseItem copyWith({
    String? id,
    String? shopId,
    Value<String?> purchaseId = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    String? productName,
    double? buyingPrice,
    Value<double?> estSellingPrice = const Value.absent(),
    int? quantity,
    Value<String?> barcode = const Value.absent(),
    double? otherCharge,
    Value<String?> description = const Value.absent(),
    Value<String?> productImage = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalPurchaseItem(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    purchaseId: purchaseId.present ? purchaseId.value : this.purchaseId,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    productName: productName ?? this.productName,
    buyingPrice: buyingPrice ?? this.buyingPrice,
    estSellingPrice: estSellingPrice.present
        ? estSellingPrice.value
        : this.estSellingPrice,
    quantity: quantity ?? this.quantity,
    barcode: barcode.present ? barcode.value : this.barcode,
    otherCharge: otherCharge ?? this.otherCharge,
    description: description.present ? description.value : this.description,
    productImage: productImage.present ? productImage.value : this.productImage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalPurchaseItem copyWithCompanion(LocalPurchaseItemsCompanion data) {
    return LocalPurchaseItem(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      buyingPrice: data.buyingPrice.present
          ? data.buyingPrice.value
          : this.buyingPrice,
      estSellingPrice: data.estSellingPrice.present
          ? data.estSellingPrice.value
          : this.estSellingPrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      otherCharge: data.otherCharge.present
          ? data.otherCharge.value
          : this.otherCharge,
      description: data.description.present
          ? data.description.value
          : this.description,
      productImage: data.productImage.present
          ? data.productImage.value
          : this.productImage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalPurchaseItem(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('categoryId: $categoryId, ')
          ..write('productName: $productName, ')
          ..write('buyingPrice: $buyingPrice, ')
          ..write('estSellingPrice: $estSellingPrice, ')
          ..write('quantity: $quantity, ')
          ..write('barcode: $barcode, ')
          ..write('otherCharge: $otherCharge, ')
          ..write('description: $description, ')
          ..write('productImage: $productImage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    purchaseId,
    categoryId,
    productName,
    buyingPrice,
    estSellingPrice,
    quantity,
    barcode,
    otherCharge,
    description,
    productImage,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPurchaseItem &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.purchaseId == this.purchaseId &&
          other.categoryId == this.categoryId &&
          other.productName == this.productName &&
          other.buyingPrice == this.buyingPrice &&
          other.estSellingPrice == this.estSellingPrice &&
          other.quantity == this.quantity &&
          other.barcode == this.barcode &&
          other.otherCharge == this.otherCharge &&
          other.description == this.description &&
          other.productImage == this.productImage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalPurchaseItemsCompanion extends UpdateCompanion<LocalPurchaseItem> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String?> purchaseId;
  final Value<String?> categoryId;
  final Value<String> productName;
  final Value<double> buyingPrice;
  final Value<double?> estSellingPrice;
  final Value<int> quantity;
  final Value<String?> barcode;
  final Value<double> otherCharge;
  final Value<String?> description;
  final Value<String?> productImage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalPurchaseItemsCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.productName = const Value.absent(),
    this.buyingPrice = const Value.absent(),
    this.estSellingPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.barcode = const Value.absent(),
    this.otherCharge = const Value.absent(),
    this.description = const Value.absent(),
    this.productImage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalPurchaseItemsCompanion.insert({
    required String id,
    required String shopId,
    this.purchaseId = const Value.absent(),
    this.categoryId = const Value.absent(),
    required String productName,
    required double buyingPrice,
    this.estSellingPrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.barcode = const Value.absent(),
    this.otherCharge = const Value.absent(),
    this.description = const Value.absent(),
    this.productImage = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       productName = Value(productName),
       buyingPrice = Value(buyingPrice),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalPurchaseItem> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? purchaseId,
    Expression<String>? categoryId,
    Expression<String>? productName,
    Expression<double>? buyingPrice,
    Expression<double>? estSellingPrice,
    Expression<int>? quantity,
    Expression<String>? barcode,
    Expression<double>? otherCharge,
    Expression<String>? description,
    Expression<String>? productImage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (categoryId != null) 'category_id': categoryId,
      if (productName != null) 'product_name': productName,
      if (buyingPrice != null) 'buying_price': buyingPrice,
      if (estSellingPrice != null) 'est_selling_price': estSellingPrice,
      if (quantity != null) 'quantity': quantity,
      if (barcode != null) 'barcode': barcode,
      if (otherCharge != null) 'other_charge': otherCharge,
      if (description != null) 'description': description,
      if (productImage != null) 'product_image': productImage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalPurchaseItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String?>? purchaseId,
    Value<String?>? categoryId,
    Value<String>? productName,
    Value<double>? buyingPrice,
    Value<double?>? estSellingPrice,
    Value<int>? quantity,
    Value<String?>? barcode,
    Value<double>? otherCharge,
    Value<String?>? description,
    Value<String?>? productImage,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalPurchaseItemsCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      purchaseId: purchaseId ?? this.purchaseId,
      categoryId: categoryId ?? this.categoryId,
      productName: productName ?? this.productName,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      estSellingPrice: estSellingPrice ?? this.estSellingPrice,
      quantity: quantity ?? this.quantity,
      barcode: barcode ?? this.barcode,
      otherCharge: otherCharge ?? this.otherCharge,
      description: description ?? this.description,
      productImage: productImage ?? this.productImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<String>(purchaseId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (buyingPrice.present) {
      map['buying_price'] = Variable<double>(buyingPrice.value);
    }
    if (estSellingPrice.present) {
      map['est_selling_price'] = Variable<double>(estSellingPrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (otherCharge.present) {
      map['other_charge'] = Variable<double>(otherCharge.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (productImage.present) {
      map['product_image'] = Variable<String>(productImage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPurchaseItemsCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('categoryId: $categoryId, ')
          ..write('productName: $productName, ')
          ..write('buyingPrice: $buyingPrice, ')
          ..write('estSellingPrice: $estSellingPrice, ')
          ..write('quantity: $quantity, ')
          ..write('barcode: $barcode, ')
          ..write('otherCharge: $otherCharge, ')
          ..write('description: $description, ')
          ..write('productImage: $productImage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalPurchasePaymentsTable extends LocalPurchasePayments
    with TableInfo<$LocalPurchasePaymentsTable, LocalPurchasePayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPurchasePaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta(
    'purchaseId',
  );
  @override
  late final GeneratedColumn<String> purchaseId = GeneratedColumn<String>(
    'purchase_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_purchases (id)',
    ),
  );
  static const VerificationMeta _paymentsMeta = const VerificationMeta(
    'payments',
  );
  @override
  late final GeneratedColumn<double> payments = GeneratedColumn<double>(
    'payments',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    purchaseId,
    payments,
    description,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_purchase_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalPurchasePayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('purchase_id')) {
      context.handle(
        _purchaseIdMeta,
        purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_purchaseIdMeta);
    }
    if (data.containsKey('payments')) {
      context.handle(
        _paymentsMeta,
        payments.isAcceptableOrUnknown(data['payments']!, _paymentsMeta),
      );
    } else if (isInserting) {
      context.missing(_paymentsMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalPurchasePayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPurchasePayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      purchaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}purchase_id'],
      )!,
      payments: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}payments'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalPurchasePaymentsTable createAlias(String alias) {
    return $LocalPurchasePaymentsTable(attachedDatabase, alias);
  }
}

class LocalPurchasePayment extends DataClass
    implements Insertable<LocalPurchasePayment> {
  final String id;
  final String shopId;
  final String purchaseId;
  final double payments;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalPurchasePayment({
    required this.id,
    required this.shopId,
    required this.purchaseId,
    required this.payments,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['purchase_id'] = Variable<String>(purchaseId);
    map['payments'] = Variable<double>(payments);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalPurchasePaymentsCompanion toCompanion(bool nullToAbsent) {
    return LocalPurchasePaymentsCompanion(
      id: Value(id),
      shopId: Value(shopId),
      purchaseId: Value(purchaseId),
      payments: Value(payments),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalPurchasePayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPurchasePayment(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      purchaseId: serializer.fromJson<String>(json['purchaseId']),
      payments: serializer.fromJson<double>(json['payments']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'purchaseId': serializer.toJson<String>(purchaseId),
      'payments': serializer.toJson<double>(payments),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalPurchasePayment copyWith({
    String? id,
    String? shopId,
    String? purchaseId,
    double? payments,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalPurchasePayment(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    purchaseId: purchaseId ?? this.purchaseId,
    payments: payments ?? this.payments,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalPurchasePayment copyWithCompanion(LocalPurchasePaymentsCompanion data) {
    return LocalPurchasePayment(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      purchaseId: data.purchaseId.present
          ? data.purchaseId.value
          : this.purchaseId,
      payments: data.payments.present ? data.payments.value : this.payments,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalPurchasePayment(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('payments: $payments, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    purchaseId,
    payments,
    description,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPurchasePayment &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.purchaseId == this.purchaseId &&
          other.payments == this.payments &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalPurchasePaymentsCompanion
    extends UpdateCompanion<LocalPurchasePayment> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> purchaseId;
  final Value<double> payments;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalPurchasePaymentsCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.payments = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalPurchasePaymentsCompanion.insert({
    required String id,
    required String shopId,
    required String purchaseId,
    required double payments,
    this.description = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       purchaseId = Value(purchaseId),
       payments = Value(payments),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalPurchasePayment> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? purchaseId,
    Expression<double>? payments,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (payments != null) 'payments': payments,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalPurchasePaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? purchaseId,
    Value<double>? payments,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalPurchasePaymentsCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      purchaseId: purchaseId ?? this.purchaseId,
      payments: payments ?? this.payments,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<String>(purchaseId.value);
    }
    if (payments.present) {
      map['payments'] = Variable<double>(payments.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPurchasePaymentsCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('payments: $payments, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCustomersTable extends LocalCustomers
    with TableInfo<$LocalCustomersTable, LocalCustomer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    name,
    email,
    phone,
    address,
    notes,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCustomer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCustomer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCustomer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalCustomersTable createAlias(String alias) {
    return $LocalCustomersTable(attachedDatabase, alias);
  }
}

class LocalCustomer extends DataClass implements Insertable<LocalCustomer> {
  final String id;
  final String shopId;
  final String name;
  final String? email;
  final String? phone;
  final String? address;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalCustomer({
    required this.id,
    required this.shopId,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalCustomersCompanion toCompanion(bool nullToAbsent) {
    return LocalCustomersCompanion(
      id: Value(id),
      shopId: Value(shopId),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalCustomer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCustomer(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalCustomer copyWith({
    String? id,
    String? shopId,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalCustomer(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalCustomer copyWithCompanion(LocalCustomersCompanion data) {
    return LocalCustomer(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCustomer(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    name,
    email,
    phone,
    address,
    notes,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCustomer &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalCustomersCompanion extends UpdateCompanion<LocalCustomer> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalCustomersCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCustomersCompanion.insert({
    required String id,
    required String shopId,
    required String name,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalCustomer> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCustomersCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? phone,
    Value<String?>? address,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalCustomersCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCustomersCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSalesTable extends LocalSales
    with TableInfo<$LocalSalesTable, LocalSale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_customers (id)',
    ),
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _vatMeta = const VerificationMeta('vat');
  @override
  late final GeneratedColumn<double> vat = GeneratedColumn<double>(
    'vat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('completed'),
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    customerId,
    subtotal,
    discount,
    vat,
    total,
    status,
    paymentMethod,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('vat')) {
      context.handle(
        _vatMeta,
        vat.isAcceptableOrUnknown(data['vat']!, _vatMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      vat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vat'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalSalesTable createAlias(String alias) {
    return $LocalSalesTable(attachedDatabase, alias);
  }
}

class LocalSale extends DataClass implements Insertable<LocalSale> {
  final String id;
  final String shopId;
  final String customerId;
  final double subtotal;
  final double discount;
  final double vat;
  final double total;
  final String status;
  final String? paymentMethod;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalSale({
    required this.id,
    required this.shopId,
    required this.customerId,
    required this.subtotal,
    required this.discount,
    required this.vat,
    required this.total,
    required this.status,
    this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['customer_id'] = Variable<String>(customerId);
    map['subtotal'] = Variable<double>(subtotal);
    map['discount'] = Variable<double>(discount);
    map['vat'] = Variable<double>(vat);
    map['total'] = Variable<double>(total);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalSalesCompanion toCompanion(bool nullToAbsent) {
    return LocalSalesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      customerId: Value(customerId),
      subtotal: Value(subtotal),
      discount: Value(discount),
      vat: Value(vat),
      total: Value(total),
      status: Value(status),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalSale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSale(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      customerId: serializer.fromJson<String>(json['customerId']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      discount: serializer.fromJson<double>(json['discount']),
      vat: serializer.fromJson<double>(json['vat']),
      total: serializer.fromJson<double>(json['total']),
      status: serializer.fromJson<String>(json['status']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'customerId': serializer.toJson<String>(customerId),
      'subtotal': serializer.toJson<double>(subtotal),
      'discount': serializer.toJson<double>(discount),
      'vat': serializer.toJson<double>(vat),
      'total': serializer.toJson<double>(total),
      'status': serializer.toJson<String>(status),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalSale copyWith({
    String? id,
    String? shopId,
    String? customerId,
    double? subtotal,
    double? discount,
    double? vat,
    double? total,
    String? status,
    Value<String?> paymentMethod = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalSale(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    customerId: customerId ?? this.customerId,
    subtotal: subtotal ?? this.subtotal,
    discount: discount ?? this.discount,
    vat: vat ?? this.vat,
    total: total ?? this.total,
    status: status ?? this.status,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalSale copyWithCompanion(LocalSalesCompanion data) {
    return LocalSale(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discount: data.discount.present ? data.discount.value : this.discount,
      vat: data.vat.present ? data.vat.value : this.vat,
      total: data.total.present ? data.total.value : this.total,
      status: data.status.present ? data.status.value : this.status,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSale(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('customerId: $customerId, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('vat: $vat, ')
          ..write('total: $total, ')
          ..write('status: $status, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    customerId,
    subtotal,
    discount,
    vat,
    total,
    status,
    paymentMethod,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSale &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.customerId == this.customerId &&
          other.subtotal == this.subtotal &&
          other.discount == this.discount &&
          other.vat == this.vat &&
          other.total == this.total &&
          other.status == this.status &&
          other.paymentMethod == this.paymentMethod &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalSalesCompanion extends UpdateCompanion<LocalSale> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> customerId;
  final Value<double> subtotal;
  final Value<double> discount;
  final Value<double> vat;
  final Value<double> total;
  final Value<String> status;
  final Value<String?> paymentMethod;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalSalesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discount = const Value.absent(),
    this.vat = const Value.absent(),
    this.total = const Value.absent(),
    this.status = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSalesCompanion.insert({
    required String id,
    required String shopId,
    required String customerId,
    required double subtotal,
    this.discount = const Value.absent(),
    this.vat = const Value.absent(),
    required double total,
    this.status = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       customerId = Value(customerId),
       subtotal = Value(subtotal),
       total = Value(total),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalSale> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? customerId,
    Expression<double>? subtotal,
    Expression<double>? discount,
    Expression<double>? vat,
    Expression<double>? total,
    Expression<String>? status,
    Expression<String>? paymentMethod,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (customerId != null) 'customer_id': customerId,
      if (subtotal != null) 'subtotal': subtotal,
      if (discount != null) 'discount': discount,
      if (vat != null) 'vat': vat,
      if (total != null) 'total': total,
      if (status != null) 'status': status,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSalesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? customerId,
    Value<double>? subtotal,
    Value<double>? discount,
    Value<double>? vat,
    Value<double>? total,
    Value<String>? status,
    Value<String?>? paymentMethod,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalSalesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      customerId: customerId ?? this.customerId,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      vat: vat ?? this.vat,
      total: total ?? this.total,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (vat.present) {
      map['vat'] = Variable<double>(vat.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSalesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('customerId: $customerId, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('vat: $vat, ')
          ..write('total: $total, ')
          ..write('status: $status, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSaleItemsTable extends LocalSaleItems
    with TableInfo<$LocalSaleItemsTable, LocalSaleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSaleItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_sales (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_purchase_items (id)',
    ),
  );
  static const VerificationMeta _buyPriceMeta = const VerificationMeta(
    'buyPrice',
  );
  @override
  late final GeneratedColumn<double> buyPrice = GeneratedColumn<double>(
    'buy_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _salePriceMeta = const VerificationMeta(
    'salePrice',
  );
  @override
  late final GeneratedColumn<double> salePrice = GeneratedColumn<double>(
    'sale_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    orderId,
    productId,
    buyPrice,
    salePrice,
    quantity,
    price,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sale_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSaleItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('buy_price')) {
      context.handle(
        _buyPriceMeta,
        buyPrice.isAcceptableOrUnknown(data['buy_price']!, _buyPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_buyPriceMeta);
    }
    if (data.containsKey('sale_price')) {
      context.handle(
        _salePriceMeta,
        salePrice.isAcceptableOrUnknown(data['sale_price']!, _salePriceMeta),
      );
    } else if (isInserting) {
      context.missing(_salePriceMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSaleItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      buyPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}buy_price'],
      )!,
      salePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sale_price'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalSaleItemsTable createAlias(String alias) {
    return $LocalSaleItemsTable(attachedDatabase, alias);
  }
}

class LocalSaleItem extends DataClass implements Insertable<LocalSaleItem> {
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
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalSaleItem({
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
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['order_id'] = Variable<String>(orderId);
    map['product_id'] = Variable<String>(productId);
    map['buy_price'] = Variable<double>(buyPrice);
    map['sale_price'] = Variable<double>(salePrice);
    map['quantity'] = Variable<int>(quantity);
    map['price'] = Variable<double>(price);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalSaleItemsCompanion toCompanion(bool nullToAbsent) {
    return LocalSaleItemsCompanion(
      id: Value(id),
      shopId: Value(shopId),
      orderId: Value(orderId),
      productId: Value(productId),
      buyPrice: Value(buyPrice),
      salePrice: Value(salePrice),
      quantity: Value(quantity),
      price: Value(price),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalSaleItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSaleItem(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      orderId: serializer.fromJson<String>(json['orderId']),
      productId: serializer.fromJson<String>(json['productId']),
      buyPrice: serializer.fromJson<double>(json['buyPrice']),
      salePrice: serializer.fromJson<double>(json['salePrice']),
      quantity: serializer.fromJson<int>(json['quantity']),
      price: serializer.fromJson<double>(json['price']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'orderId': serializer.toJson<String>(orderId),
      'productId': serializer.toJson<String>(productId),
      'buyPrice': serializer.toJson<double>(buyPrice),
      'salePrice': serializer.toJson<double>(salePrice),
      'quantity': serializer.toJson<int>(quantity),
      'price': serializer.toJson<double>(price),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalSaleItem copyWith({
    String? id,
    String? shopId,
    String? orderId,
    String? productId,
    double? buyPrice,
    double? salePrice,
    int? quantity,
    double? price,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalSaleItem(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    orderId: orderId ?? this.orderId,
    productId: productId ?? this.productId,
    buyPrice: buyPrice ?? this.buyPrice,
    salePrice: salePrice ?? this.salePrice,
    quantity: quantity ?? this.quantity,
    price: price ?? this.price,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalSaleItem copyWithCompanion(LocalSaleItemsCompanion data) {
    return LocalSaleItem(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      productId: data.productId.present ? data.productId.value : this.productId,
      buyPrice: data.buyPrice.present ? data.buyPrice.value : this.buyPrice,
      salePrice: data.salePrice.present ? data.salePrice.value : this.salePrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      price: data.price.present ? data.price.value : this.price,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSaleItem(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('buyPrice: $buyPrice, ')
          ..write('salePrice: $salePrice, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    orderId,
    productId,
    buyPrice,
    salePrice,
    quantity,
    price,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSaleItem &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.orderId == this.orderId &&
          other.productId == this.productId &&
          other.buyPrice == this.buyPrice &&
          other.salePrice == this.salePrice &&
          other.quantity == this.quantity &&
          other.price == this.price &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalSaleItemsCompanion extends UpdateCompanion<LocalSaleItem> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> orderId;
  final Value<String> productId;
  final Value<double> buyPrice;
  final Value<double> salePrice;
  final Value<int> quantity;
  final Value<double> price;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalSaleItemsCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.productId = const Value.absent(),
    this.buyPrice = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.price = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSaleItemsCompanion.insert({
    required String id,
    required String shopId,
    required String orderId,
    required String productId,
    required double buyPrice,
    required double salePrice,
    this.quantity = const Value.absent(),
    required double price,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       orderId = Value(orderId),
       productId = Value(productId),
       buyPrice = Value(buyPrice),
       salePrice = Value(salePrice),
       price = Value(price),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalSaleItem> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? orderId,
    Expression<String>? productId,
    Expression<double>? buyPrice,
    Expression<double>? salePrice,
    Expression<int>? quantity,
    Expression<double>? price,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (orderId != null) 'order_id': orderId,
      if (productId != null) 'product_id': productId,
      if (buyPrice != null) 'buy_price': buyPrice,
      if (salePrice != null) 'sale_price': salePrice,
      if (quantity != null) 'quantity': quantity,
      if (price != null) 'price': price,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSaleItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? orderId,
    Value<String>? productId,
    Value<double>? buyPrice,
    Value<double>? salePrice,
    Value<int>? quantity,
    Value<double>? price,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalSaleItemsCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      buyPrice: buyPrice ?? this.buyPrice,
      salePrice: salePrice ?? this.salePrice,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (buyPrice.present) {
      map['buy_price'] = Variable<double>(buyPrice.value);
    }
    if (salePrice.present) {
      map['sale_price'] = Variable<double>(salePrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSaleItemsCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('orderId: $orderId, ')
          ..write('productId: $productId, ')
          ..write('buyPrice: $buyPrice, ')
          ..write('salePrice: $salePrice, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSaleReturnsTable extends LocalSaleReturns
    with TableInfo<$LocalSaleReturnsTable, LocalSaleReturn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSaleReturnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_sales (id)',
    ),
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _restockingFeeMeta = const VerificationMeta(
    'restockingFee',
  );
  @override
  late final GeneratedColumn<double> restockingFee = GeneratedColumn<double>(
    'restocking_fee',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _refundTotalMeta = const VerificationMeta(
    'refundTotal',
  );
  @override
  late final GeneratedColumn<double> refundTotal = GeneratedColumn<double>(
    'refund_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    saleId,
    subtotal,
    restockingFee,
    refundTotal,
    note,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sale_returns';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSaleReturn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    }
    if (data.containsKey('restocking_fee')) {
      context.handle(
        _restockingFeeMeta,
        restockingFee.isAcceptableOrUnknown(
          data['restocking_fee']!,
          _restockingFeeMeta,
        ),
      );
    }
    if (data.containsKey('refund_total')) {
      context.handle(
        _refundTotalMeta,
        refundTotal.isAcceptableOrUnknown(
          data['refund_total']!,
          _refundTotalMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSaleReturn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSaleReturn(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_id'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      restockingFee: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}restocking_fee'],
      )!,
      refundTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}refund_total'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalSaleReturnsTable createAlias(String alias) {
    return $LocalSaleReturnsTable(attachedDatabase, alias);
  }
}

class LocalSaleReturn extends DataClass implements Insertable<LocalSaleReturn> {
  final String id;
  final String shopId;
  final String saleId;
  final double subtotal;
  final double restockingFee;
  final double refundTotal;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalSaleReturn({
    required this.id,
    required this.shopId,
    required this.saleId,
    required this.subtotal,
    required this.restockingFee,
    required this.refundTotal,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['sale_id'] = Variable<String>(saleId);
    map['subtotal'] = Variable<double>(subtotal);
    map['restocking_fee'] = Variable<double>(restockingFee);
    map['refund_total'] = Variable<double>(refundTotal);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalSaleReturnsCompanion toCompanion(bool nullToAbsent) {
    return LocalSaleReturnsCompanion(
      id: Value(id),
      shopId: Value(shopId),
      saleId: Value(saleId),
      subtotal: Value(subtotal),
      restockingFee: Value(restockingFee),
      refundTotal: Value(refundTotal),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalSaleReturn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSaleReturn(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      saleId: serializer.fromJson<String>(json['saleId']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      restockingFee: serializer.fromJson<double>(json['restockingFee']),
      refundTotal: serializer.fromJson<double>(json['refundTotal']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'saleId': serializer.toJson<String>(saleId),
      'subtotal': serializer.toJson<double>(subtotal),
      'restockingFee': serializer.toJson<double>(restockingFee),
      'refundTotal': serializer.toJson<double>(refundTotal),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalSaleReturn copyWith({
    String? id,
    String? shopId,
    String? saleId,
    double? subtotal,
    double? restockingFee,
    double? refundTotal,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalSaleReturn(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    saleId: saleId ?? this.saleId,
    subtotal: subtotal ?? this.subtotal,
    restockingFee: restockingFee ?? this.restockingFee,
    refundTotal: refundTotal ?? this.refundTotal,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalSaleReturn copyWithCompanion(LocalSaleReturnsCompanion data) {
    return LocalSaleReturn(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      restockingFee: data.restockingFee.present
          ? data.restockingFee.value
          : this.restockingFee,
      refundTotal: data.refundTotal.present
          ? data.refundTotal.value
          : this.refundTotal,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSaleReturn(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('saleId: $saleId, ')
          ..write('subtotal: $subtotal, ')
          ..write('restockingFee: $restockingFee, ')
          ..write('refundTotal: $refundTotal, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    saleId,
    subtotal,
    restockingFee,
    refundTotal,
    note,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSaleReturn &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.saleId == this.saleId &&
          other.subtotal == this.subtotal &&
          other.restockingFee == this.restockingFee &&
          other.refundTotal == this.refundTotal &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalSaleReturnsCompanion extends UpdateCompanion<LocalSaleReturn> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> saleId;
  final Value<double> subtotal;
  final Value<double> restockingFee;
  final Value<double> refundTotal;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalSaleReturnsCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.saleId = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.restockingFee = const Value.absent(),
    this.refundTotal = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSaleReturnsCompanion.insert({
    required String id,
    required String shopId,
    required String saleId,
    this.subtotal = const Value.absent(),
    this.restockingFee = const Value.absent(),
    this.refundTotal = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       saleId = Value(saleId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalSaleReturn> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? saleId,
    Expression<double>? subtotal,
    Expression<double>? restockingFee,
    Expression<double>? refundTotal,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (saleId != null) 'sale_id': saleId,
      if (subtotal != null) 'subtotal': subtotal,
      if (restockingFee != null) 'restocking_fee': restockingFee,
      if (refundTotal != null) 'refund_total': refundTotal,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSaleReturnsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? saleId,
    Value<double>? subtotal,
    Value<double>? restockingFee,
    Value<double>? refundTotal,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalSaleReturnsCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      saleId: saleId ?? this.saleId,
      subtotal: subtotal ?? this.subtotal,
      restockingFee: restockingFee ?? this.restockingFee,
      refundTotal: refundTotal ?? this.refundTotal,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (restockingFee.present) {
      map['restocking_fee'] = Variable<double>(restockingFee.value);
    }
    if (refundTotal.present) {
      map['refund_total'] = Variable<double>(refundTotal.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSaleReturnsCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('saleId: $saleId, ')
          ..write('subtotal: $subtotal, ')
          ..write('restockingFee: $restockingFee, ')
          ..write('refundTotal: $refundTotal, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSaleReturnItemsTable extends LocalSaleReturnItems
    with TableInfo<$LocalSaleReturnItemsTable, LocalSaleReturnItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSaleReturnItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _returnIdMeta = const VerificationMeta(
    'returnId',
  );
  @override
  late final GeneratedColumn<String> returnId = GeneratedColumn<String>(
    'return_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_sale_returns (id)',
    ),
  );
  static const VerificationMeta _saleItemIdMeta = const VerificationMeta(
    'saleItemId',
  );
  @override
  late final GeneratedColumn<String> saleItemId = GeneratedColumn<String>(
    'sale_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_sale_items (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_purchase_items (id)',
    ),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _salePriceMeta = const VerificationMeta(
    'salePrice',
  );
  @override
  late final GeneratedColumn<double> salePrice = GeneratedColumn<double>(
    'sale_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    returnId,
    saleItemId,
    productId,
    productName,
    salePrice,
    quantity,
    reason,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sale_return_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSaleReturnItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('return_id')) {
      context.handle(
        _returnIdMeta,
        returnId.isAcceptableOrUnknown(data['return_id']!, _returnIdMeta),
      );
    } else if (isInserting) {
      context.missing(_returnIdMeta);
    }
    if (data.containsKey('sale_item_id')) {
      context.handle(
        _saleItemIdMeta,
        saleItemId.isAcceptableOrUnknown(
          data['sale_item_id']!,
          _saleItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_saleItemIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('sale_price')) {
      context.handle(
        _salePriceMeta,
        salePrice.isAcceptableOrUnknown(data['sale_price']!, _salePriceMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSaleReturnItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSaleReturnItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      returnId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}return_id'],
      )!,
      saleItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_item_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      salePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sale_price'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalSaleReturnItemsTable createAlias(String alias) {
    return $LocalSaleReturnItemsTable(attachedDatabase, alias);
  }
}

class LocalSaleReturnItem extends DataClass
    implements Insertable<LocalSaleReturnItem> {
  final String id;
  final String shopId;
  final String returnId;
  final String saleItemId;
  final String productId;
  final String productName;
  final double salePrice;
  final int quantity;
  final String? reason;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalSaleReturnItem({
    required this.id,
    required this.shopId,
    required this.returnId,
    required this.saleItemId,
    required this.productId,
    required this.productName,
    required this.salePrice,
    required this.quantity,
    this.reason,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['return_id'] = Variable<String>(returnId);
    map['sale_item_id'] = Variable<String>(saleItemId);
    map['product_id'] = Variable<String>(productId);
    map['product_name'] = Variable<String>(productName);
    map['sale_price'] = Variable<double>(salePrice);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalSaleReturnItemsCompanion toCompanion(bool nullToAbsent) {
    return LocalSaleReturnItemsCompanion(
      id: Value(id),
      shopId: Value(shopId),
      returnId: Value(returnId),
      saleItemId: Value(saleItemId),
      productId: Value(productId),
      productName: Value(productName),
      salePrice: Value(salePrice),
      quantity: Value(quantity),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalSaleReturnItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSaleReturnItem(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      returnId: serializer.fromJson<String>(json['returnId']),
      saleItemId: serializer.fromJson<String>(json['saleItemId']),
      productId: serializer.fromJson<String>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      salePrice: serializer.fromJson<double>(json['salePrice']),
      quantity: serializer.fromJson<int>(json['quantity']),
      reason: serializer.fromJson<String?>(json['reason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'returnId': serializer.toJson<String>(returnId),
      'saleItemId': serializer.toJson<String>(saleItemId),
      'productId': serializer.toJson<String>(productId),
      'productName': serializer.toJson<String>(productName),
      'salePrice': serializer.toJson<double>(salePrice),
      'quantity': serializer.toJson<int>(quantity),
      'reason': serializer.toJson<String?>(reason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalSaleReturnItem copyWith({
    String? id,
    String? shopId,
    String? returnId,
    String? saleItemId,
    String? productId,
    String? productName,
    double? salePrice,
    int? quantity,
    Value<String?> reason = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalSaleReturnItem(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    returnId: returnId ?? this.returnId,
    saleItemId: saleItemId ?? this.saleItemId,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    salePrice: salePrice ?? this.salePrice,
    quantity: quantity ?? this.quantity,
    reason: reason.present ? reason.value : this.reason,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalSaleReturnItem copyWithCompanion(LocalSaleReturnItemsCompanion data) {
    return LocalSaleReturnItem(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      returnId: data.returnId.present ? data.returnId.value : this.returnId,
      saleItemId: data.saleItemId.present
          ? data.saleItemId.value
          : this.saleItemId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      salePrice: data.salePrice.present ? data.salePrice.value : this.salePrice,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      reason: data.reason.present ? data.reason.value : this.reason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSaleReturnItem(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('returnId: $returnId, ')
          ..write('saleItemId: $saleItemId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('salePrice: $salePrice, ')
          ..write('quantity: $quantity, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    returnId,
    saleItemId,
    productId,
    productName,
    salePrice,
    quantity,
    reason,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSaleReturnItem &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.returnId == this.returnId &&
          other.saleItemId == this.saleItemId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.salePrice == this.salePrice &&
          other.quantity == this.quantity &&
          other.reason == this.reason &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalSaleReturnItemsCompanion
    extends UpdateCompanion<LocalSaleReturnItem> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> returnId;
  final Value<String> saleItemId;
  final Value<String> productId;
  final Value<String> productName;
  final Value<double> salePrice;
  final Value<int> quantity;
  final Value<String?> reason;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalSaleReturnItemsCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.returnId = const Value.absent(),
    this.saleItemId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSaleReturnItemsCompanion.insert({
    required String id,
    required String shopId,
    required String returnId,
    required String saleItemId,
    required String productId,
    required String productName,
    this.salePrice = const Value.absent(),
    this.quantity = const Value.absent(),
    this.reason = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       returnId = Value(returnId),
       saleItemId = Value(saleItemId),
       productId = Value(productId),
       productName = Value(productName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalSaleReturnItem> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? returnId,
    Expression<String>? saleItemId,
    Expression<String>? productId,
    Expression<String>? productName,
    Expression<double>? salePrice,
    Expression<int>? quantity,
    Expression<String>? reason,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (returnId != null) 'return_id': returnId,
      if (saleItemId != null) 'sale_item_id': saleItemId,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (salePrice != null) 'sale_price': salePrice,
      if (quantity != null) 'quantity': quantity,
      if (reason != null) 'reason': reason,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSaleReturnItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? returnId,
    Value<String>? saleItemId,
    Value<String>? productId,
    Value<String>? productName,
    Value<double>? salePrice,
    Value<int>? quantity,
    Value<String?>? reason,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalSaleReturnItemsCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      returnId: returnId ?? this.returnId,
      saleItemId: saleItemId ?? this.saleItemId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      salePrice: salePrice ?? this.salePrice,
      quantity: quantity ?? this.quantity,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (returnId.present) {
      map['return_id'] = Variable<String>(returnId.value);
    }
    if (saleItemId.present) {
      map['sale_item_id'] = Variable<String>(saleItemId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (salePrice.present) {
      map['sale_price'] = Variable<double>(salePrice.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSaleReturnItemsCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('returnId: $returnId, ')
          ..write('saleItemId: $saleItemId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('salePrice: $salePrice, ')
          ..write('quantity: $quantity, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCustomerPaymentsTable extends LocalCustomerPayments
    with TableInfo<$LocalCustomerPaymentsTable, LocalCustomerPayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCustomerPaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_customers (id)',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_sales (id)',
    ),
  );
  static const VerificationMeta _paymentsMeta = const VerificationMeta(
    'payments',
  );
  @override
  late final GeneratedColumn<double> payments = GeneratedColumn<double>(
    'payments',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    customerId,
    orderId,
    payments,
    description,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_customer_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCustomerPayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('payments')) {
      context.handle(
        _paymentsMeta,
        payments.isAcceptableOrUnknown(data['payments']!, _paymentsMeta),
      );
    } else if (isInserting) {
      context.missing(_paymentsMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCustomerPayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCustomerPayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      payments: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}payments'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalCustomerPaymentsTable createAlias(String alias) {
    return $LocalCustomerPaymentsTable(attachedDatabase, alias);
  }
}

class LocalCustomerPayment extends DataClass
    implements Insertable<LocalCustomerPayment> {
  final String id;
  final String shopId;
  final String customerId;
  final String orderId;
  final double payments;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalCustomerPayment({
    required this.id,
    required this.shopId,
    required this.customerId,
    required this.orderId,
    required this.payments,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['customer_id'] = Variable<String>(customerId);
    map['order_id'] = Variable<String>(orderId);
    map['payments'] = Variable<double>(payments);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalCustomerPaymentsCompanion toCompanion(bool nullToAbsent) {
    return LocalCustomerPaymentsCompanion(
      id: Value(id),
      shopId: Value(shopId),
      customerId: Value(customerId),
      orderId: Value(orderId),
      payments: Value(payments),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalCustomerPayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCustomerPayment(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      customerId: serializer.fromJson<String>(json['customerId']),
      orderId: serializer.fromJson<String>(json['orderId']),
      payments: serializer.fromJson<double>(json['payments']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'customerId': serializer.toJson<String>(customerId),
      'orderId': serializer.toJson<String>(orderId),
      'payments': serializer.toJson<double>(payments),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalCustomerPayment copyWith({
    String? id,
    String? shopId,
    String? customerId,
    String? orderId,
    double? payments,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalCustomerPayment(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    customerId: customerId ?? this.customerId,
    orderId: orderId ?? this.orderId,
    payments: payments ?? this.payments,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalCustomerPayment copyWithCompanion(LocalCustomerPaymentsCompanion data) {
    return LocalCustomerPayment(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      payments: data.payments.present ? data.payments.value : this.payments,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCustomerPayment(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('customerId: $customerId, ')
          ..write('orderId: $orderId, ')
          ..write('payments: $payments, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    customerId,
    orderId,
    payments,
    description,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCustomerPayment &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.customerId == this.customerId &&
          other.orderId == this.orderId &&
          other.payments == this.payments &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalCustomerPaymentsCompanion
    extends UpdateCompanion<LocalCustomerPayment> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> customerId;
  final Value<String> orderId;
  final Value<double> payments;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalCustomerPaymentsCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.payments = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCustomerPaymentsCompanion.insert({
    required String id,
    required String shopId,
    required String customerId,
    required String orderId,
    required double payments,
    this.description = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       customerId = Value(customerId),
       orderId = Value(orderId),
       payments = Value(payments),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalCustomerPayment> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? customerId,
    Expression<String>? orderId,
    Expression<double>? payments,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (customerId != null) 'customer_id': customerId,
      if (orderId != null) 'order_id': orderId,
      if (payments != null) 'payments': payments,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCustomerPaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? customerId,
    Value<String>? orderId,
    Value<double>? payments,
    Value<String?>? description,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalCustomerPaymentsCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      customerId: customerId ?? this.customerId,
      orderId: orderId ?? this.orderId,
      payments: payments ?? this.payments,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (payments.present) {
      map['payments'] = Variable<double>(payments.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCustomerPaymentsCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('customerId: $customerId, ')
          ..write('orderId: $orderId, ')
          ..write('payments: $payments, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCashTransactionsTable extends LocalCashTransactions
    with TableInfo<$LocalCashTransactionsTable, LocalCashTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCashTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
    'reference_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceTypeMeta = const VerificationMeta(
    'referenceType',
  );
  @override
  late final GeneratedColumn<String> referenceType = GeneratedColumn<String>(
    'reference_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    type,
    direction,
    amount,
    referenceId,
    referenceType,
    method,
    note,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_cash_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCashTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    }
    if (data.containsKey('reference_type')) {
      context.handle(
        _referenceTypeMeta,
        referenceType.isAcceptableOrUnknown(
          data['reference_type']!,
          _referenceTypeMeta,
        ),
      );
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCashTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCashTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_id'],
      ),
      referenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_type'],
      ),
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalCashTransactionsTable createAlias(String alias) {
    return $LocalCashTransactionsTable(attachedDatabase, alias);
  }
}

class LocalCashTransaction extends DataClass
    implements Insertable<LocalCashTransaction> {
  final String id;
  final String shopId;
  final String type;
  final String direction;
  final double amount;
  final String? referenceId;
  final String? referenceType;
  final String? method;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalCashTransaction({
    required this.id,
    required this.shopId,
    required this.type,
    required this.direction,
    required this.amount,
    this.referenceId,
    this.referenceType,
    this.method,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['type'] = Variable<String>(type);
    map['direction'] = Variable<String>(direction);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    if (!nullToAbsent || referenceType != null) {
      map['reference_type'] = Variable<String>(referenceType);
    }
    if (!nullToAbsent || method != null) {
      map['method'] = Variable<String>(method);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalCashTransactionsCompanion toCompanion(bool nullToAbsent) {
    return LocalCashTransactionsCompanion(
      id: Value(id),
      shopId: Value(shopId),
      type: Value(type),
      direction: Value(direction),
      amount: Value(amount),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      referenceType: referenceType == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceType),
      method: method == null && nullToAbsent
          ? const Value.absent()
          : Value(method),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalCashTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCashTransaction(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      type: serializer.fromJson<String>(json['type']),
      direction: serializer.fromJson<String>(json['direction']),
      amount: serializer.fromJson<double>(json['amount']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      referenceType: serializer.fromJson<String?>(json['referenceType']),
      method: serializer.fromJson<String?>(json['method']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'type': serializer.toJson<String>(type),
      'direction': serializer.toJson<String>(direction),
      'amount': serializer.toJson<double>(amount),
      'referenceId': serializer.toJson<String?>(referenceId),
      'referenceType': serializer.toJson<String?>(referenceType),
      'method': serializer.toJson<String?>(method),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalCashTransaction copyWith({
    String? id,
    String? shopId,
    String? type,
    String? direction,
    double? amount,
    Value<String?> referenceId = const Value.absent(),
    Value<String?> referenceType = const Value.absent(),
    Value<String?> method = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalCashTransaction(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    type: type ?? this.type,
    direction: direction ?? this.direction,
    amount: amount ?? this.amount,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    referenceType: referenceType.present
        ? referenceType.value
        : this.referenceType,
    method: method.present ? method.value : this.method,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalCashTransaction copyWithCompanion(LocalCashTransactionsCompanion data) {
    return LocalCashTransaction(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      type: data.type.present ? data.type.value : this.type,
      direction: data.direction.present ? data.direction.value : this.direction,
      amount: data.amount.present ? data.amount.value : this.amount,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      referenceType: data.referenceType.present
          ? data.referenceType.value
          : this.referenceType,
      method: data.method.present ? data.method.value : this.method,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCashTransaction(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('type: $type, ')
          ..write('direction: $direction, ')
          ..write('amount: $amount, ')
          ..write('referenceId: $referenceId, ')
          ..write('referenceType: $referenceType, ')
          ..write('method: $method, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    type,
    direction,
    amount,
    referenceId,
    referenceType,
    method,
    note,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCashTransaction &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.type == this.type &&
          other.direction == this.direction &&
          other.amount == this.amount &&
          other.referenceId == this.referenceId &&
          other.referenceType == this.referenceType &&
          other.method == this.method &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalCashTransactionsCompanion
    extends UpdateCompanion<LocalCashTransaction> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> type;
  final Value<String> direction;
  final Value<double> amount;
  final Value<String?> referenceId;
  final Value<String?> referenceType;
  final Value<String?> method;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalCashTransactionsCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.type = const Value.absent(),
    this.direction = const Value.absent(),
    this.amount = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.method = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCashTransactionsCompanion.insert({
    required String id,
    required String shopId,
    required String type,
    required String direction,
    this.amount = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.method = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       type = Value(type),
       direction = Value(direction),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalCashTransaction> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? type,
    Expression<String>? direction,
    Expression<double>? amount,
    Expression<String>? referenceId,
    Expression<String>? referenceType,
    Expression<String>? method,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (type != null) 'type': type,
      if (direction != null) 'direction': direction,
      if (amount != null) 'amount': amount,
      if (referenceId != null) 'reference_id': referenceId,
      if (referenceType != null) 'reference_type': referenceType,
      if (method != null) 'method': method,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCashTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? type,
    Value<String>? direction,
    Value<double>? amount,
    Value<String?>? referenceId,
    Value<String?>? referenceType,
    Value<String?>? method,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalCashTransactionsCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      type: type ?? this.type,
      direction: direction ?? this.direction,
      amount: amount ?? this.amount,
      referenceId: referenceId ?? this.referenceId,
      referenceType: referenceType ?? this.referenceType,
      method: method ?? this.method,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (referenceType.present) {
      map['reference_type'] = Variable<String>(referenceType.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCashTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('type: $type, ')
          ..write('direction: $direction, ')
          ..write('amount: $amount, ')
          ..write('referenceId: $referenceId, ')
          ..write('referenceType: $referenceType, ')
          ..write('method: $method, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalExpensesTable extends LocalExpenses
    with TableInfo<$LocalExpensesTable, LocalExpense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_categories (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    categoryId,
    amount,
    reason,
    note,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalExpense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalExpense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalExpense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalExpensesTable createAlias(String alias) {
    return $LocalExpensesTable(attachedDatabase, alias);
  }
}

class LocalExpense extends DataClass implements Insertable<LocalExpense> {
  final String id;
  final String shopId;
  final String categoryId;
  final double amount;
  final String? reason;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalExpense({
    required this.id,
    required this.shopId,
    required this.categoryId,
    required this.amount,
    this.reason,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['category_id'] = Variable<String>(categoryId);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalExpensesCompanion toCompanion(bool nullToAbsent) {
    return LocalExpensesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      categoryId: Value(categoryId),
      amount: Value(amount),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalExpense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalExpense(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      amount: serializer.fromJson<double>(json['amount']),
      reason: serializer.fromJson<String?>(json['reason']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'categoryId': serializer.toJson<String>(categoryId),
      'amount': serializer.toJson<double>(amount),
      'reason': serializer.toJson<String?>(reason),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalExpense copyWith({
    String? id,
    String? shopId,
    String? categoryId,
    double? amount,
    Value<String?> reason = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalExpense(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    categoryId: categoryId ?? this.categoryId,
    amount: amount ?? this.amount,
    reason: reason.present ? reason.value : this.reason,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalExpense copyWithCompanion(LocalExpensesCompanion data) {
    return LocalExpense(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      reason: data.reason.present ? data.reason.value : this.reason,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalExpense(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    categoryId,
    amount,
    reason,
    note,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalExpense &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount &&
          other.reason == this.reason &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalExpensesCompanion extends UpdateCompanion<LocalExpense> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> categoryId;
  final Value<double> amount;
  final Value<String?> reason;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalExpensesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalExpensesCompanion.insert({
    required String id,
    required String shopId,
    required String categoryId,
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       categoryId = Value(categoryId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalExpense> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? categoryId,
    Expression<double>? amount,
    Expression<String>? reason,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (reason != null) 'reason': reason,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalExpensesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? categoryId,
    Value<double>? amount,
    Value<String?>? reason,
    Value<String?>? note,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalExpensesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalExpensesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalIncomesTable extends LocalIncomes
    with TableInfo<$LocalIncomesTable, LocalIncome> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalIncomesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_categories (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptUrlMeta = const VerificationMeta(
    'receiptUrl',
  );
  @override
  late final GeneratedColumn<String> receiptUrl = GeneratedColumn<String>(
    'receipt_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    categoryId,
    amount,
    reason,
    note,
    receiptUrl,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_incomes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalIncome> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('receipt_url')) {
      context.handle(
        _receiptUrlMeta,
        receiptUrl.isAcceptableOrUnknown(data['receipt_url']!, _receiptUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalIncome map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalIncome(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      receiptUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalIncomesTable createAlias(String alias) {
    return $LocalIncomesTable(attachedDatabase, alias);
  }
}

class LocalIncome extends DataClass implements Insertable<LocalIncome> {
  final String id;
  final String shopId;
  final String categoryId;
  final double amount;
  final String? reason;
  final String? note;
  final String? receiptUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalIncome({
    required this.id,
    required this.shopId,
    required this.categoryId,
    required this.amount,
    this.reason,
    this.note,
    this.receiptUrl,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['category_id'] = Variable<String>(categoryId);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || receiptUrl != null) {
      map['receipt_url'] = Variable<String>(receiptUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalIncomesCompanion toCompanion(bool nullToAbsent) {
    return LocalIncomesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      categoryId: Value(categoryId),
      amount: Value(amount),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      receiptUrl: receiptUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalIncome.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalIncome(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      amount: serializer.fromJson<double>(json['amount']),
      reason: serializer.fromJson<String?>(json['reason']),
      note: serializer.fromJson<String?>(json['note']),
      receiptUrl: serializer.fromJson<String?>(json['receiptUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'categoryId': serializer.toJson<String>(categoryId),
      'amount': serializer.toJson<double>(amount),
      'reason': serializer.toJson<String?>(reason),
      'note': serializer.toJson<String?>(note),
      'receiptUrl': serializer.toJson<String?>(receiptUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalIncome copyWith({
    String? id,
    String? shopId,
    String? categoryId,
    double? amount,
    Value<String?> reason = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> receiptUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalIncome(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    categoryId: categoryId ?? this.categoryId,
    amount: amount ?? this.amount,
    reason: reason.present ? reason.value : this.reason,
    note: note.present ? note.value : this.note,
    receiptUrl: receiptUrl.present ? receiptUrl.value : this.receiptUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalIncome copyWithCompanion(LocalIncomesCompanion data) {
    return LocalIncome(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      amount: data.amount.present ? data.amount.value : this.amount,
      reason: data.reason.present ? data.reason.value : this.reason,
      note: data.note.present ? data.note.value : this.note,
      receiptUrl: data.receiptUrl.present
          ? data.receiptUrl.value
          : this.receiptUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalIncome(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('note: $note, ')
          ..write('receiptUrl: $receiptUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    categoryId,
    amount,
    reason,
    note,
    receiptUrl,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalIncome &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.categoryId == this.categoryId &&
          other.amount == this.amount &&
          other.reason == this.reason &&
          other.note == this.note &&
          other.receiptUrl == this.receiptUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalIncomesCompanion extends UpdateCompanion<LocalIncome> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> categoryId;
  final Value<double> amount;
  final Value<String?> reason;
  final Value<String?> note;
  final Value<String?> receiptUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalIncomesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.note = const Value.absent(),
    this.receiptUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalIncomesCompanion.insert({
    required String id,
    required String shopId,
    required String categoryId,
    this.amount = const Value.absent(),
    this.reason = const Value.absent(),
    this.note = const Value.absent(),
    this.receiptUrl = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       categoryId = Value(categoryId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalIncome> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? categoryId,
    Expression<double>? amount,
    Expression<String>? reason,
    Expression<String>? note,
    Expression<String>? receiptUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (reason != null) 'reason': reason,
      if (note != null) 'note': note,
      if (receiptUrl != null) 'receipt_url': receiptUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalIncomesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? categoryId,
    Value<double>? amount,
    Value<String?>? reason,
    Value<String?>? note,
    Value<String?>? receiptUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalIncomesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
      reason: reason ?? this.reason,
      note: note ?? this.note,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (receiptUrl.present) {
      map['receipt_url'] = Variable<String>(receiptUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalIncomesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('categoryId: $categoryId, ')
          ..write('amount: $amount, ')
          ..write('reason: $reason, ')
          ..write('note: $note, ')
          ..write('receiptUrl: $receiptUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalRecycleBinEntriesTable extends LocalRecycleBinEntries
    with TableInfo<$LocalRecycleBinEntriesTable, LocalRecycleBinEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalRecycleBinEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _sourceTableNameMeta = const VerificationMeta(
    'sourceTableName',
  );
  @override
  late final GeneratedColumn<String> sourceTableName = GeneratedColumn<String>(
    'table_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayTitleMeta = const VerificationMeta(
    'displayTitle',
  );
  @override
  late final GeneratedColumn<String> displayTitle = GeneratedColumn<String>(
    'display_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displaySubtitleMeta = const VerificationMeta(
    'displaySubtitle',
  );
  @override
  late final GeneratedColumn<String> displaySubtitle = GeneratedColumn<String>(
    'display_subtitle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedDataMeta = const VerificationMeta(
    'deletedData',
  );
  @override
  late final GeneratedColumn<String> deletedData = GeneratedColumn<String>(
    'deleted_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relatedDataMeta = const VerificationMeta(
    'relatedData',
  );
  @override
  late final GeneratedColumn<String> relatedData = GeneratedColumn<String>(
    'related_data',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedByUserIdMeta = const VerificationMeta(
    'deletedByUserId',
  );
  @override
  late final GeneratedColumn<String> deletedByUserId = GeneratedColumn<String>(
    'deleted_by_user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_users (id)',
    ),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restoredAtMeta = const VerificationMeta(
    'restoredAt',
  );
  @override
  late final GeneratedColumn<DateTime> restoredAt = GeneratedColumn<DateTime>(
    'restored_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _restoreStatusMeta = const VerificationMeta(
    'restoreStatus',
  );
  @override
  late final GeneratedColumn<String> restoreStatus = GeneratedColumn<String>(
    'restore_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('deleted'),
  );
  static const VerificationMeta _restoreBlockReasonMeta =
      const VerificationMeta('restoreBlockReason');
  @override
  late final GeneratedColumn<String> restoreBlockReason =
      GeneratedColumn<String>(
        'restore_block_reason',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    sourceTableName,
    recordId,
    displayTitle,
    displaySubtitle,
    deletedData,
    relatedData,
    deletedByUserId,
    deletedAt,
    restoredAt,
    restoreStatus,
    restoreBlockReason,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_recycle_bin_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalRecycleBinEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('table_name')) {
      context.handle(
        _sourceTableNameMeta,
        sourceTableName.isAcceptableOrUnknown(
          data['table_name']!,
          _sourceTableNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceTableNameMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('display_title')) {
      context.handle(
        _displayTitleMeta,
        displayTitle.isAcceptableOrUnknown(
          data['display_title']!,
          _displayTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayTitleMeta);
    }
    if (data.containsKey('display_subtitle')) {
      context.handle(
        _displaySubtitleMeta,
        displaySubtitle.isAcceptableOrUnknown(
          data['display_subtitle']!,
          _displaySubtitleMeta,
        ),
      );
    }
    if (data.containsKey('deleted_data')) {
      context.handle(
        _deletedDataMeta,
        deletedData.isAcceptableOrUnknown(
          data['deleted_data']!,
          _deletedDataMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deletedDataMeta);
    }
    if (data.containsKey('related_data')) {
      context.handle(
        _relatedDataMeta,
        relatedData.isAcceptableOrUnknown(
          data['related_data']!,
          _relatedDataMeta,
        ),
      );
    }
    if (data.containsKey('deleted_by_user_id')) {
      context.handle(
        _deletedByUserIdMeta,
        deletedByUserId.isAcceptableOrUnknown(
          data['deleted_by_user_id']!,
          _deletedByUserIdMeta,
        ),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_deletedAtMeta);
    }
    if (data.containsKey('restored_at')) {
      context.handle(
        _restoredAtMeta,
        restoredAt.isAcceptableOrUnknown(data['restored_at']!, _restoredAtMeta),
      );
    }
    if (data.containsKey('restore_status')) {
      context.handle(
        _restoreStatusMeta,
        restoreStatus.isAcceptableOrUnknown(
          data['restore_status']!,
          _restoreStatusMeta,
        ),
      );
    }
    if (data.containsKey('restore_block_reason')) {
      context.handle(
        _restoreBlockReasonMeta,
        restoreBlockReason.isAcceptableOrUnknown(
          data['restore_block_reason']!,
          _restoreBlockReasonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalRecycleBinEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalRecycleBinEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      sourceTableName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}table_name'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
      displayTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_title'],
      )!,
      displaySubtitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_subtitle'],
      ),
      deletedData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_data'],
      )!,
      relatedData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_data'],
      ),
      deletedByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_by_user_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      )!,
      restoredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}restored_at'],
      ),
      restoreStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}restore_status'],
      )!,
      restoreBlockReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}restore_block_reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalRecycleBinEntriesTable createAlias(String alias) {
    return $LocalRecycleBinEntriesTable(attachedDatabase, alias);
  }
}

class LocalRecycleBinEntry extends DataClass
    implements Insertable<LocalRecycleBinEntry> {
  final String id;
  final String shopId;
  final String sourceTableName;
  final String recordId;
  final String displayTitle;
  final String? displaySubtitle;
  final String deletedData;
  final String? relatedData;
  final String? deletedByUserId;
  final DateTime deletedAt;
  final DateTime? restoredAt;
  final String restoreStatus;
  final String? restoreBlockReason;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const LocalRecycleBinEntry({
    required this.id,
    required this.shopId,
    required this.sourceTableName,
    required this.recordId,
    required this.displayTitle,
    this.displaySubtitle,
    required this.deletedData,
    this.relatedData,
    this.deletedByUserId,
    required this.deletedAt,
    this.restoredAt,
    required this.restoreStatus,
    this.restoreBlockReason,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['table_name'] = Variable<String>(sourceTableName);
    map['record_id'] = Variable<String>(recordId);
    map['display_title'] = Variable<String>(displayTitle);
    if (!nullToAbsent || displaySubtitle != null) {
      map['display_subtitle'] = Variable<String>(displaySubtitle);
    }
    map['deleted_data'] = Variable<String>(deletedData);
    if (!nullToAbsent || relatedData != null) {
      map['related_data'] = Variable<String>(relatedData);
    }
    if (!nullToAbsent || deletedByUserId != null) {
      map['deleted_by_user_id'] = Variable<String>(deletedByUserId);
    }
    map['deleted_at'] = Variable<DateTime>(deletedAt);
    if (!nullToAbsent || restoredAt != null) {
      map['restored_at'] = Variable<DateTime>(restoredAt);
    }
    map['restore_status'] = Variable<String>(restoreStatus);
    if (!nullToAbsent || restoreBlockReason != null) {
      map['restore_block_reason'] = Variable<String>(restoreBlockReason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalRecycleBinEntriesCompanion toCompanion(bool nullToAbsent) {
    return LocalRecycleBinEntriesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      sourceTableName: Value(sourceTableName),
      recordId: Value(recordId),
      displayTitle: Value(displayTitle),
      displaySubtitle: displaySubtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(displaySubtitle),
      deletedData: Value(deletedData),
      relatedData: relatedData == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedData),
      deletedByUserId: deletedByUserId == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedByUserId),
      deletedAt: Value(deletedAt),
      restoredAt: restoredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(restoredAt),
      restoreStatus: Value(restoreStatus),
      restoreBlockReason: restoreBlockReason == null && nullToAbsent
          ? const Value.absent()
          : Value(restoreBlockReason),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalRecycleBinEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalRecycleBinEntry(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      sourceTableName: serializer.fromJson<String>(json['sourceTableName']),
      recordId: serializer.fromJson<String>(json['recordId']),
      displayTitle: serializer.fromJson<String>(json['displayTitle']),
      displaySubtitle: serializer.fromJson<String?>(json['displaySubtitle']),
      deletedData: serializer.fromJson<String>(json['deletedData']),
      relatedData: serializer.fromJson<String?>(json['relatedData']),
      deletedByUserId: serializer.fromJson<String?>(json['deletedByUserId']),
      deletedAt: serializer.fromJson<DateTime>(json['deletedAt']),
      restoredAt: serializer.fromJson<DateTime?>(json['restoredAt']),
      restoreStatus: serializer.fromJson<String>(json['restoreStatus']),
      restoreBlockReason: serializer.fromJson<String?>(
        json['restoreBlockReason'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'sourceTableName': serializer.toJson<String>(sourceTableName),
      'recordId': serializer.toJson<String>(recordId),
      'displayTitle': serializer.toJson<String>(displayTitle),
      'displaySubtitle': serializer.toJson<String?>(displaySubtitle),
      'deletedData': serializer.toJson<String>(deletedData),
      'relatedData': serializer.toJson<String?>(relatedData),
      'deletedByUserId': serializer.toJson<String?>(deletedByUserId),
      'deletedAt': serializer.toJson<DateTime>(deletedAt),
      'restoredAt': serializer.toJson<DateTime?>(restoredAt),
      'restoreStatus': serializer.toJson<String>(restoreStatus),
      'restoreBlockReason': serializer.toJson<String?>(restoreBlockReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalRecycleBinEntry copyWith({
    String? id,
    String? shopId,
    String? sourceTableName,
    String? recordId,
    String? displayTitle,
    Value<String?> displaySubtitle = const Value.absent(),
    String? deletedData,
    Value<String?> relatedData = const Value.absent(),
    Value<String?> deletedByUserId = const Value.absent(),
    DateTime? deletedAt,
    Value<DateTime?> restoredAt = const Value.absent(),
    String? restoreStatus,
    Value<String?> restoreBlockReason = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => LocalRecycleBinEntry(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    sourceTableName: sourceTableName ?? this.sourceTableName,
    recordId: recordId ?? this.recordId,
    displayTitle: displayTitle ?? this.displayTitle,
    displaySubtitle: displaySubtitle.present
        ? displaySubtitle.value
        : this.displaySubtitle,
    deletedData: deletedData ?? this.deletedData,
    relatedData: relatedData.present ? relatedData.value : this.relatedData,
    deletedByUserId: deletedByUserId.present
        ? deletedByUserId.value
        : this.deletedByUserId,
    deletedAt: deletedAt ?? this.deletedAt,
    restoredAt: restoredAt.present ? restoredAt.value : this.restoredAt,
    restoreStatus: restoreStatus ?? this.restoreStatus,
    restoreBlockReason: restoreBlockReason.present
        ? restoreBlockReason.value
        : this.restoreBlockReason,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalRecycleBinEntry copyWithCompanion(LocalRecycleBinEntriesCompanion data) {
    return LocalRecycleBinEntry(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      sourceTableName: data.sourceTableName.present
          ? data.sourceTableName.value
          : this.sourceTableName,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      displayTitle: data.displayTitle.present
          ? data.displayTitle.value
          : this.displayTitle,
      displaySubtitle: data.displaySubtitle.present
          ? data.displaySubtitle.value
          : this.displaySubtitle,
      deletedData: data.deletedData.present
          ? data.deletedData.value
          : this.deletedData,
      relatedData: data.relatedData.present
          ? data.relatedData.value
          : this.relatedData,
      deletedByUserId: data.deletedByUserId.present
          ? data.deletedByUserId.value
          : this.deletedByUserId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      restoredAt: data.restoredAt.present
          ? data.restoredAt.value
          : this.restoredAt,
      restoreStatus: data.restoreStatus.present
          ? data.restoreStatus.value
          : this.restoreStatus,
      restoreBlockReason: data.restoreBlockReason.present
          ? data.restoreBlockReason.value
          : this.restoreBlockReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalRecycleBinEntry(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('sourceTableName: $sourceTableName, ')
          ..write('recordId: $recordId, ')
          ..write('displayTitle: $displayTitle, ')
          ..write('displaySubtitle: $displaySubtitle, ')
          ..write('deletedData: $deletedData, ')
          ..write('relatedData: $relatedData, ')
          ..write('deletedByUserId: $deletedByUserId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('restoredAt: $restoredAt, ')
          ..write('restoreStatus: $restoreStatus, ')
          ..write('restoreBlockReason: $restoreBlockReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    sourceTableName,
    recordId,
    displayTitle,
    displaySubtitle,
    deletedData,
    relatedData,
    deletedByUserId,
    deletedAt,
    restoredAt,
    restoreStatus,
    restoreBlockReason,
    createdAt,
    updatedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalRecycleBinEntry &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.sourceTableName == this.sourceTableName &&
          other.recordId == this.recordId &&
          other.displayTitle == this.displayTitle &&
          other.displaySubtitle == this.displaySubtitle &&
          other.deletedData == this.deletedData &&
          other.relatedData == this.relatedData &&
          other.deletedByUserId == this.deletedByUserId &&
          other.deletedAt == this.deletedAt &&
          other.restoredAt == this.restoredAt &&
          other.restoreStatus == this.restoreStatus &&
          other.restoreBlockReason == this.restoreBlockReason &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalRecycleBinEntriesCompanion
    extends UpdateCompanion<LocalRecycleBinEntry> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> sourceTableName;
  final Value<String> recordId;
  final Value<String> displayTitle;
  final Value<String?> displaySubtitle;
  final Value<String> deletedData;
  final Value<String?> relatedData;
  final Value<String?> deletedByUserId;
  final Value<DateTime> deletedAt;
  final Value<DateTime?> restoredAt;
  final Value<String> restoreStatus;
  final Value<String?> restoreBlockReason;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalRecycleBinEntriesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.sourceTableName = const Value.absent(),
    this.recordId = const Value.absent(),
    this.displayTitle = const Value.absent(),
    this.displaySubtitle = const Value.absent(),
    this.deletedData = const Value.absent(),
    this.relatedData = const Value.absent(),
    this.deletedByUserId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.restoredAt = const Value.absent(),
    this.restoreStatus = const Value.absent(),
    this.restoreBlockReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalRecycleBinEntriesCompanion.insert({
    required String id,
    required String shopId,
    required String sourceTableName,
    required String recordId,
    required String displayTitle,
    this.displaySubtitle = const Value.absent(),
    required String deletedData,
    this.relatedData = const Value.absent(),
    this.deletedByUserId = const Value.absent(),
    required DateTime deletedAt,
    this.restoredAt = const Value.absent(),
    this.restoreStatus = const Value.absent(),
    this.restoreBlockReason = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       sourceTableName = Value(sourceTableName),
       recordId = Value(recordId),
       displayTitle = Value(displayTitle),
       deletedData = Value(deletedData),
       deletedAt = Value(deletedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalRecycleBinEntry> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? sourceTableName,
    Expression<String>? recordId,
    Expression<String>? displayTitle,
    Expression<String>? displaySubtitle,
    Expression<String>? deletedData,
    Expression<String>? relatedData,
    Expression<String>? deletedByUserId,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? restoredAt,
    Expression<String>? restoreStatus,
    Expression<String>? restoreBlockReason,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (sourceTableName != null) 'table_name': sourceTableName,
      if (recordId != null) 'record_id': recordId,
      if (displayTitle != null) 'display_title': displayTitle,
      if (displaySubtitle != null) 'display_subtitle': displaySubtitle,
      if (deletedData != null) 'deleted_data': deletedData,
      if (relatedData != null) 'related_data': relatedData,
      if (deletedByUserId != null) 'deleted_by_user_id': deletedByUserId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (restoredAt != null) 'restored_at': restoredAt,
      if (restoreStatus != null) 'restore_status': restoreStatus,
      if (restoreBlockReason != null)
        'restore_block_reason': restoreBlockReason,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalRecycleBinEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? sourceTableName,
    Value<String>? recordId,
    Value<String>? displayTitle,
    Value<String?>? displaySubtitle,
    Value<String>? deletedData,
    Value<String?>? relatedData,
    Value<String?>? deletedByUserId,
    Value<DateTime>? deletedAt,
    Value<DateTime?>? restoredAt,
    Value<String>? restoreStatus,
    Value<String?>? restoreBlockReason,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalRecycleBinEntriesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      sourceTableName: sourceTableName ?? this.sourceTableName,
      recordId: recordId ?? this.recordId,
      displayTitle: displayTitle ?? this.displayTitle,
      displaySubtitle: displaySubtitle ?? this.displaySubtitle,
      deletedData: deletedData ?? this.deletedData,
      relatedData: relatedData ?? this.relatedData,
      deletedByUserId: deletedByUserId ?? this.deletedByUserId,
      deletedAt: deletedAt ?? this.deletedAt,
      restoredAt: restoredAt ?? this.restoredAt,
      restoreStatus: restoreStatus ?? this.restoreStatus,
      restoreBlockReason: restoreBlockReason ?? this.restoreBlockReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (sourceTableName.present) {
      map['table_name'] = Variable<String>(sourceTableName.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (displayTitle.present) {
      map['display_title'] = Variable<String>(displayTitle.value);
    }
    if (displaySubtitle.present) {
      map['display_subtitle'] = Variable<String>(displaySubtitle.value);
    }
    if (deletedData.present) {
      map['deleted_data'] = Variable<String>(deletedData.value);
    }
    if (relatedData.present) {
      map['related_data'] = Variable<String>(relatedData.value);
    }
    if (deletedByUserId.present) {
      map['deleted_by_user_id'] = Variable<String>(deletedByUserId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (restoredAt.present) {
      map['restored_at'] = Variable<DateTime>(restoredAt.value);
    }
    if (restoreStatus.present) {
      map['restore_status'] = Variable<String>(restoreStatus.value);
    }
    if (restoreBlockReason.present) {
      map['restore_block_reason'] = Variable<String>(restoreBlockReason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalRecycleBinEntriesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('sourceTableName: $sourceTableName, ')
          ..write('recordId: $recordId, ')
          ..write('displayTitle: $displayTitle, ')
          ..write('displaySubtitle: $displaySubtitle, ')
          ..write('deletedData: $deletedData, ')
          ..write('relatedData: $relatedData, ')
          ..write('deletedByUserId: $deletedByUserId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('restoredAt: $restoredAt, ')
          ..write('restoreStatus: $restoreStatus, ')
          ..write('restoreBlockReason: $restoreBlockReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalNotesTable extends LocalNotes
    with TableInfo<$LocalNotesTable, LocalNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_shops (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    title,
    body,
    isArchived,
    archivedAt,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalNote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalNote(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $LocalNotesTable createAlias(String alias) {
    return $LocalNotesTable(attachedDatabase, alias);
  }
}

class LocalNote extends DataClass implements Insertable<LocalNote> {
  final String id;
  final String shopId;
  final String title;
  final String body;
  final bool isArchived;
  final DateTime? archivedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String syncStatus;
  const LocalNote({
    required this.id,
    required this.shopId,
    required this.title,
    required this.body,
    required this.isArchived,
    this.archivedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['is_archived'] = Variable<bool>(isArchived);
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  LocalNotesCompanion toCompanion(bool nullToAbsent) {
    return LocalNotesCompanion(
      id: Value(id),
      shopId: Value(shopId),
      title: Value(title),
      body: Value(body),
      isArchived: Value(isArchived),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory LocalNote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalNote(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'isArchived': serializer.toJson<bool>(isArchived),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  LocalNote copyWith({
    String? id,
    String? shopId,
    String? title,
    String? body,
    bool? isArchived,
    Value<DateTime?> archivedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? syncStatus,
  }) => LocalNote(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    title: title ?? this.title,
    body: body ?? this.body,
    isArchived: isArchived ?? this.isArchived,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  LocalNote copyWithCompanion(LocalNotesCompanion data) {
    return LocalNote(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalNote(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('isArchived: $isArchived, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    title,
    body,
    isArchived,
    archivedAt,
    createdAt,
    updatedAt,
    deletedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalNote &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.title == this.title &&
          other.body == this.body &&
          other.isArchived == this.isArchived &&
          other.archivedAt == this.archivedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.syncStatus == this.syncStatus);
}

class LocalNotesCompanion extends UpdateCompanion<LocalNote> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> title;
  final Value<String> body;
  final Value<bool> isArchived;
  final Value<DateTime?> archivedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const LocalNotesCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalNotesCompanion.insert({
    required String id,
    required String shopId,
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.archivedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LocalNote> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? title,
    Expression<String>? body,
    Expression<bool>? isArchived,
    Expression<DateTime>? archivedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (isArchived != null) 'is_archived': isArchived,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalNotesCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? title,
    Value<String>? body,
    Value<bool>? isArchived,
    Value<DateTime?>? archivedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return LocalNotesCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      title: title ?? this.title,
      body: body ?? this.body,
      isArchived: isArchived ?? this.isArchived,
      archivedAt: archivedAt ?? this.archivedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalNotesCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('isArchived: $isArchived, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalShopsTable localShops = $LocalShopsTable(this);
  late final $LocalUsersTable localUsers = $LocalUsersTable(this);
  late final $LocalCategoriesTable localCategories = $LocalCategoriesTable(
    this,
  );
  late final $LocalSuppliersTable localSuppliers = $LocalSuppliersTable(this);
  late final $LocalPurchasesTable localPurchases = $LocalPurchasesTable(this);
  late final $LocalPurchaseItemsTable localPurchaseItems =
      $LocalPurchaseItemsTable(this);
  late final $LocalPurchasePaymentsTable localPurchasePayments =
      $LocalPurchasePaymentsTable(this);
  late final $LocalCustomersTable localCustomers = $LocalCustomersTable(this);
  late final $LocalSalesTable localSales = $LocalSalesTable(this);
  late final $LocalSaleItemsTable localSaleItems = $LocalSaleItemsTable(this);
  late final $LocalSaleReturnsTable localSaleReturns = $LocalSaleReturnsTable(
    this,
  );
  late final $LocalSaleReturnItemsTable localSaleReturnItems =
      $LocalSaleReturnItemsTable(this);
  late final $LocalCustomerPaymentsTable localCustomerPayments =
      $LocalCustomerPaymentsTable(this);
  late final $LocalCashTransactionsTable localCashTransactions =
      $LocalCashTransactionsTable(this);
  late final $LocalExpensesTable localExpenses = $LocalExpensesTable(this);
  late final $LocalIncomesTable localIncomes = $LocalIncomesTable(this);
  late final $LocalRecycleBinEntriesTable localRecycleBinEntries =
      $LocalRecycleBinEntriesTable(this);
  late final $LocalNotesTable localNotes = $LocalNotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
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
  ];
}

typedef $$LocalShopsTableCreateCompanionBuilder =
    LocalShopsCompanion Function({
      required String id,
      required String shopName,
      required String email,
      required String shopMobile,
      Value<String?> shopWebsite,
      Value<String?> shopAddress,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalShopsTableUpdateCompanionBuilder =
    LocalShopsCompanion Function({
      Value<String> id,
      Value<String> shopName,
      Value<String> email,
      Value<String> shopMobile,
      Value<String?> shopWebsite,
      Value<String?> shopAddress,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalShopsTableReferences
    extends BaseReferences<_$AppDatabase, $LocalShopsTable, LocalShop> {
  $$LocalShopsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LocalUsersTable, List<LocalUser>>
  _localUsersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localUsers,
    aliasName: $_aliasNameGenerator(db.localShops.id, db.localUsers.shopId),
  );

  $$LocalUsersTableProcessedTableManager get localUsersRefs {
    final manager = $$LocalUsersTableTableManager(
      $_db,
      $_db.localUsers,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localUsersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalCategoriesTable, List<LocalCategory>>
  _localCategoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localCategories,
    aliasName: $_aliasNameGenerator(
      db.localShops.id,
      db.localCategories.shopId,
    ),
  );

  $$LocalCategoriesTableProcessedTableManager get localCategoriesRefs {
    final manager = $$LocalCategoriesTableTableManager(
      $_db,
      $_db.localCategories,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localCategoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalSuppliersTable, List<LocalSupplier>>
  _localSuppliersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localSuppliers,
    aliasName: $_aliasNameGenerator(db.localShops.id, db.localSuppliers.shopId),
  );

  $$LocalSuppliersTableProcessedTableManager get localSuppliersRefs {
    final manager = $$LocalSuppliersTableTableManager(
      $_db,
      $_db.localSuppliers,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localSuppliersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalPurchasesTable, List<LocalPurchase>>
  _localPurchasesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localPurchases,
    aliasName: $_aliasNameGenerator(db.localShops.id, db.localPurchases.shopId),
  );

  $$LocalPurchasesTableProcessedTableManager get localPurchasesRefs {
    final manager = $$LocalPurchasesTableTableManager(
      $_db,
      $_db.localPurchases,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localPurchasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalPurchaseItemsTable, List<LocalPurchaseItem>>
  _localPurchaseItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localPurchaseItems,
        aliasName: $_aliasNameGenerator(
          db.localShops.id,
          db.localPurchaseItems.shopId,
        ),
      );

  $$LocalPurchaseItemsTableProcessedTableManager get localPurchaseItemsRefs {
    final manager = $$LocalPurchaseItemsTableTableManager(
      $_db,
      $_db.localPurchaseItems,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localPurchaseItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalPurchasePaymentsTable,
    List<LocalPurchasePayment>
  >
  _localPurchasePaymentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localPurchasePayments,
        aliasName: $_aliasNameGenerator(
          db.localShops.id,
          db.localPurchasePayments.shopId,
        ),
      );

  $$LocalPurchasePaymentsTableProcessedTableManager
  get localPurchasePaymentsRefs {
    final manager = $$LocalPurchasePaymentsTableTableManager(
      $_db,
      $_db.localPurchasePayments,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localPurchasePaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalCustomersTable, List<LocalCustomer>>
  _localCustomersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localCustomers,
    aliasName: $_aliasNameGenerator(db.localShops.id, db.localCustomers.shopId),
  );

  $$LocalCustomersTableProcessedTableManager get localCustomersRefs {
    final manager = $$LocalCustomersTableTableManager(
      $_db,
      $_db.localCustomers,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localCustomersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalSalesTable, List<LocalSale>>
  _localSalesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localSales,
    aliasName: $_aliasNameGenerator(db.localShops.id, db.localSales.shopId),
  );

  $$LocalSalesTableProcessedTableManager get localSalesRefs {
    final manager = $$LocalSalesTableTableManager(
      $_db,
      $_db.localSales,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localSalesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalSaleItemsTable, List<LocalSaleItem>>
  _localSaleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localSaleItems,
    aliasName: $_aliasNameGenerator(db.localShops.id, db.localSaleItems.shopId),
  );

  $$LocalSaleItemsTableProcessedTableManager get localSaleItemsRefs {
    final manager = $$LocalSaleItemsTableTableManager(
      $_db,
      $_db.localSaleItems,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localSaleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalSaleReturnsTable, List<LocalSaleReturn>>
  _localSaleReturnsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localSaleReturns,
    aliasName: $_aliasNameGenerator(
      db.localShops.id,
      db.localSaleReturns.shopId,
    ),
  );

  $$LocalSaleReturnsTableProcessedTableManager get localSaleReturnsRefs {
    final manager = $$LocalSaleReturnsTableTableManager(
      $_db,
      $_db.localSaleReturns,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localSaleReturnsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalSaleReturnItemsTable,
    List<LocalSaleReturnItem>
  >
  _localSaleReturnItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localSaleReturnItems,
        aliasName: $_aliasNameGenerator(
          db.localShops.id,
          db.localSaleReturnItems.shopId,
        ),
      );

  $$LocalSaleReturnItemsTableProcessedTableManager
  get localSaleReturnItemsRefs {
    final manager = $$LocalSaleReturnItemsTableTableManager(
      $_db,
      $_db.localSaleReturnItems,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localSaleReturnItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalCustomerPaymentsTable,
    List<LocalCustomerPayment>
  >
  _localCustomerPaymentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localCustomerPayments,
        aliasName: $_aliasNameGenerator(
          db.localShops.id,
          db.localCustomerPayments.shopId,
        ),
      );

  $$LocalCustomerPaymentsTableProcessedTableManager
  get localCustomerPaymentsRefs {
    final manager = $$LocalCustomerPaymentsTableTableManager(
      $_db,
      $_db.localCustomerPayments,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localCustomerPaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalCashTransactionsTable,
    List<LocalCashTransaction>
  >
  _localCashTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localCashTransactions,
        aliasName: $_aliasNameGenerator(
          db.localShops.id,
          db.localCashTransactions.shopId,
        ),
      );

  $$LocalCashTransactionsTableProcessedTableManager
  get localCashTransactionsRefs {
    final manager = $$LocalCashTransactionsTableTableManager(
      $_db,
      $_db.localCashTransactions,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localCashTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalExpensesTable, List<LocalExpense>>
  _localExpensesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localExpenses,
    aliasName: $_aliasNameGenerator(db.localShops.id, db.localExpenses.shopId),
  );

  $$LocalExpensesTableProcessedTableManager get localExpensesRefs {
    final manager = $$LocalExpensesTableTableManager(
      $_db,
      $_db.localExpenses,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localExpensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalIncomesTable, List<LocalIncome>>
  _localIncomesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localIncomes,
    aliasName: $_aliasNameGenerator(db.localShops.id, db.localIncomes.shopId),
  );

  $$LocalIncomesTableProcessedTableManager get localIncomesRefs {
    final manager = $$LocalIncomesTableTableManager(
      $_db,
      $_db.localIncomes,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localIncomesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalRecycleBinEntriesTable,
    List<LocalRecycleBinEntry>
  >
  _localRecycleBinEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localRecycleBinEntries,
        aliasName: $_aliasNameGenerator(
          db.localShops.id,
          db.localRecycleBinEntries.shopId,
        ),
      );

  $$LocalRecycleBinEntriesTableProcessedTableManager
  get localRecycleBinEntriesRefs {
    final manager = $$LocalRecycleBinEntriesTableTableManager(
      $_db,
      $_db.localRecycleBinEntries,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localRecycleBinEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalNotesTable, List<LocalNote>>
  _localNotesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localNotes,
    aliasName: $_aliasNameGenerator(db.localShops.id, db.localNotes.shopId),
  );

  $$LocalNotesTableProcessedTableManager get localNotesRefs {
    final manager = $$LocalNotesTableTableManager(
      $_db,
      $_db.localNotes,
    ).filter((f) => f.shopId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localNotesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalShopsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalShopsTable> {
  $$LocalShopsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopName => $composableBuilder(
    column: $table.shopName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopMobile => $composableBuilder(
    column: $table.shopMobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopWebsite => $composableBuilder(
    column: $table.shopWebsite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopAddress => $composableBuilder(
    column: $table.shopAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> localUsersRefs(
    Expression<bool> Function($$LocalUsersTableFilterComposer f) f,
  ) {
    final $$LocalUsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localUsers,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUsersTableFilterComposer(
            $db: $db,
            $table: $db.localUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localCategoriesRefs(
    Expression<bool> Function($$LocalCategoriesTableFilterComposer f) f,
  ) {
    final $$LocalCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localCategories,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.localCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localSuppliersRefs(
    Expression<bool> Function($$LocalSuppliersTableFilterComposer f) f,
  ) {
    final $$LocalSuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSuppliers,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSuppliersTableFilterComposer(
            $db: $db,
            $table: $db.localSuppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localPurchasesRefs(
    Expression<bool> Function($$LocalPurchasesTableFilterComposer f) f,
  ) {
    final $$LocalPurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localPurchases,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchasesTableFilterComposer(
            $db: $db,
            $table: $db.localPurchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localPurchaseItemsRefs(
    Expression<bool> Function($$LocalPurchaseItemsTableFilterComposer f) f,
  ) {
    final $$LocalPurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localPurchaseItems,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.localPurchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localPurchasePaymentsRefs(
    Expression<bool> Function($$LocalPurchasePaymentsTableFilterComposer f) f,
  ) {
    final $$LocalPurchasePaymentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localPurchasePayments,
          getReferencedColumn: (t) => t.shopId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalPurchasePaymentsTableFilterComposer(
                $db: $db,
                $table: $db.localPurchasePayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> localCustomersRefs(
    Expression<bool> Function($$LocalCustomersTableFilterComposer f) f,
  ) {
    final $$LocalCustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localCustomers,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCustomersTableFilterComposer(
            $db: $db,
            $table: $db.localCustomers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localSalesRefs(
    Expression<bool> Function($$LocalSalesTableFilterComposer f) f,
  ) {
    final $$LocalSalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableFilterComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localSaleItemsRefs(
    Expression<bool> Function($$LocalSaleItemsTableFilterComposer f) f,
  ) {
    final $$LocalSaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleItems,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localSaleReturnsRefs(
    Expression<bool> Function($$LocalSaleReturnsTableFilterComposer f) f,
  ) {
    final $$LocalSaleReturnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleReturns,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleReturnsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localSaleReturnItemsRefs(
    Expression<bool> Function($$LocalSaleReturnItemsTableFilterComposer f) f,
  ) {
    final $$LocalSaleReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleReturnItems,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localCustomerPaymentsRefs(
    Expression<bool> Function($$LocalCustomerPaymentsTableFilterComposer f) f,
  ) {
    final $$LocalCustomerPaymentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCustomerPayments,
          getReferencedColumn: (t) => t.shopId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCustomerPaymentsTableFilterComposer(
                $db: $db,
                $table: $db.localCustomerPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> localCashTransactionsRefs(
    Expression<bool> Function($$LocalCashTransactionsTableFilterComposer f) f,
  ) {
    final $$LocalCashTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCashTransactions,
          getReferencedColumn: (t) => t.shopId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.localCashTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> localExpensesRefs(
    Expression<bool> Function($$LocalExpensesTableFilterComposer f) f,
  ) {
    final $$LocalExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localExpenses,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalExpensesTableFilterComposer(
            $db: $db,
            $table: $db.localExpenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localIncomesRefs(
    Expression<bool> Function($$LocalIncomesTableFilterComposer f) f,
  ) {
    final $$LocalIncomesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localIncomes,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalIncomesTableFilterComposer(
            $db: $db,
            $table: $db.localIncomes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localRecycleBinEntriesRefs(
    Expression<bool> Function($$LocalRecycleBinEntriesTableFilterComposer f) f,
  ) {
    final $$LocalRecycleBinEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localRecycleBinEntries,
          getReferencedColumn: (t) => t.shopId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalRecycleBinEntriesTableFilterComposer(
                $db: $db,
                $table: $db.localRecycleBinEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> localNotesRefs(
    Expression<bool> Function($$LocalNotesTableFilterComposer f) f,
  ) {
    final $$LocalNotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localNotes,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalNotesTableFilterComposer(
            $db: $db,
            $table: $db.localNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalShopsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalShopsTable> {
  $$LocalShopsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopName => $composableBuilder(
    column: $table.shopName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopMobile => $composableBuilder(
    column: $table.shopMobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopWebsite => $composableBuilder(
    column: $table.shopWebsite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopAddress => $composableBuilder(
    column: $table.shopAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalShopsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalShopsTable> {
  $$LocalShopsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopName =>
      $composableBuilder(column: $table.shopName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get shopMobile => $composableBuilder(
    column: $table.shopMobile,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shopWebsite => $composableBuilder(
    column: $table.shopWebsite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shopAddress => $composableBuilder(
    column: $table.shopAddress,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  Expression<T> localUsersRefs<T extends Object>(
    Expression<T> Function($$LocalUsersTableAnnotationComposer a) f,
  ) {
    final $$LocalUsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localUsers,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUsersTableAnnotationComposer(
            $db: $db,
            $table: $db.localUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localCategoriesRefs<T extends Object>(
    Expression<T> Function($$LocalCategoriesTableAnnotationComposer a) f,
  ) {
    final $$LocalCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localCategories,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.localCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localSuppliersRefs<T extends Object>(
    Expression<T> Function($$LocalSuppliersTableAnnotationComposer a) f,
  ) {
    final $$LocalSuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSuppliers,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.localSuppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localPurchasesRefs<T extends Object>(
    Expression<T> Function($$LocalPurchasesTableAnnotationComposer a) f,
  ) {
    final $$LocalPurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localPurchases,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.localPurchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localPurchaseItemsRefs<T extends Object>(
    Expression<T> Function($$LocalPurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalPurchaseItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localPurchaseItems,
          getReferencedColumn: (t) => t.shopId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalPurchaseItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.localPurchaseItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localPurchasePaymentsRefs<T extends Object>(
    Expression<T> Function($$LocalPurchasePaymentsTableAnnotationComposer a) f,
  ) {
    final $$LocalPurchasePaymentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localPurchasePayments,
          getReferencedColumn: (t) => t.shopId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalPurchasePaymentsTableAnnotationComposer(
                $db: $db,
                $table: $db.localPurchasePayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localCustomersRefs<T extends Object>(
    Expression<T> Function($$LocalCustomersTableAnnotationComposer a) f,
  ) {
    final $$LocalCustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localCustomers,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.localCustomers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localSalesRefs<T extends Object>(
    Expression<T> Function($$LocalSalesTableAnnotationComposer a) f,
  ) {
    final $$LocalSalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableAnnotationComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localSaleItemsRefs<T extends Object>(
    Expression<T> Function($$LocalSaleItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalSaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleItems,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.localSaleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localSaleReturnsRefs<T extends Object>(
    Expression<T> Function($$LocalSaleReturnsTableAnnotationComposer a) f,
  ) {
    final $$LocalSaleReturnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleReturns,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleReturnsTableAnnotationComposer(
            $db: $db,
            $table: $db.localSaleReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localSaleReturnItemsRefs<T extends Object>(
    Expression<T> Function($$LocalSaleReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalSaleReturnItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localSaleReturnItems,
          getReferencedColumn: (t) => t.shopId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalSaleReturnItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.localSaleReturnItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localCustomerPaymentsRefs<T extends Object>(
    Expression<T> Function($$LocalCustomerPaymentsTableAnnotationComposer a) f,
  ) {
    final $$LocalCustomerPaymentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCustomerPayments,
          getReferencedColumn: (t) => t.shopId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCustomerPaymentsTableAnnotationComposer(
                $db: $db,
                $table: $db.localCustomerPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localCashTransactionsRefs<T extends Object>(
    Expression<T> Function($$LocalCashTransactionsTableAnnotationComposer a) f,
  ) {
    final $$LocalCashTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCashTransactions,
          getReferencedColumn: (t) => t.shopId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.localCashTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localExpensesRefs<T extends Object>(
    Expression<T> Function($$LocalExpensesTableAnnotationComposer a) f,
  ) {
    final $$LocalExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localExpenses,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.localExpenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localIncomesRefs<T extends Object>(
    Expression<T> Function($$LocalIncomesTableAnnotationComposer a) f,
  ) {
    final $$LocalIncomesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localIncomes,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalIncomesTableAnnotationComposer(
            $db: $db,
            $table: $db.localIncomes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localRecycleBinEntriesRefs<T extends Object>(
    Expression<T> Function($$LocalRecycleBinEntriesTableAnnotationComposer a) f,
  ) {
    final $$LocalRecycleBinEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localRecycleBinEntries,
          getReferencedColumn: (t) => t.shopId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalRecycleBinEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.localRecycleBinEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localNotesRefs<T extends Object>(
    Expression<T> Function($$LocalNotesTableAnnotationComposer a) f,
  ) {
    final $$LocalNotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localNotes,
      getReferencedColumn: (t) => t.shopId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalNotesTableAnnotationComposer(
            $db: $db,
            $table: $db.localNotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalShopsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalShopsTable,
          LocalShop,
          $$LocalShopsTableFilterComposer,
          $$LocalShopsTableOrderingComposer,
          $$LocalShopsTableAnnotationComposer,
          $$LocalShopsTableCreateCompanionBuilder,
          $$LocalShopsTableUpdateCompanionBuilder,
          (LocalShop, $$LocalShopsTableReferences),
          LocalShop,
          PrefetchHooks Function({
            bool localUsersRefs,
            bool localCategoriesRefs,
            bool localSuppliersRefs,
            bool localPurchasesRefs,
            bool localPurchaseItemsRefs,
            bool localPurchasePaymentsRefs,
            bool localCustomersRefs,
            bool localSalesRefs,
            bool localSaleItemsRefs,
            bool localSaleReturnsRefs,
            bool localSaleReturnItemsRefs,
            bool localCustomerPaymentsRefs,
            bool localCashTransactionsRefs,
            bool localExpensesRefs,
            bool localIncomesRefs,
            bool localRecycleBinEntriesRefs,
            bool localNotesRefs,
          })
        > {
  $$LocalShopsTableTableManager(_$AppDatabase db, $LocalShopsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalShopsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalShopsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalShopsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> shopMobile = const Value.absent(),
                Value<String?> shopWebsite = const Value.absent(),
                Value<String?> shopAddress = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalShopsCompanion(
                id: id,
                shopName: shopName,
                email: email,
                shopMobile: shopMobile,
                shopWebsite: shopWebsite,
                shopAddress: shopAddress,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopName,
                required String email,
                required String shopMobile,
                Value<String?> shopWebsite = const Value.absent(),
                Value<String?> shopAddress = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalShopsCompanion.insert(
                id: id,
                shopName: shopName,
                email: email,
                shopMobile: shopMobile,
                shopWebsite: shopWebsite,
                shopAddress: shopAddress,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalShopsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                localUsersRefs = false,
                localCategoriesRefs = false,
                localSuppliersRefs = false,
                localPurchasesRefs = false,
                localPurchaseItemsRefs = false,
                localPurchasePaymentsRefs = false,
                localCustomersRefs = false,
                localSalesRefs = false,
                localSaleItemsRefs = false,
                localSaleReturnsRefs = false,
                localSaleReturnItemsRefs = false,
                localCustomerPaymentsRefs = false,
                localCashTransactionsRefs = false,
                localExpensesRefs = false,
                localIncomesRefs = false,
                localRecycleBinEntriesRefs = false,
                localNotesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localUsersRefs) db.localUsers,
                    if (localCategoriesRefs) db.localCategories,
                    if (localSuppliersRefs) db.localSuppliers,
                    if (localPurchasesRefs) db.localPurchases,
                    if (localPurchaseItemsRefs) db.localPurchaseItems,
                    if (localPurchasePaymentsRefs) db.localPurchasePayments,
                    if (localCustomersRefs) db.localCustomers,
                    if (localSalesRefs) db.localSales,
                    if (localSaleItemsRefs) db.localSaleItems,
                    if (localSaleReturnsRefs) db.localSaleReturns,
                    if (localSaleReturnItemsRefs) db.localSaleReturnItems,
                    if (localCustomerPaymentsRefs) db.localCustomerPayments,
                    if (localCashTransactionsRefs) db.localCashTransactions,
                    if (localExpensesRefs) db.localExpenses,
                    if (localIncomesRefs) db.localIncomes,
                    if (localRecycleBinEntriesRefs) db.localRecycleBinEntries,
                    if (localNotesRefs) db.localNotes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localUsersRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalUser
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localUsersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localUsersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localCategoriesRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalCategory
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localCategoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localCategoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localSuppliersRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalSupplier
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localSuppliersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localSuppliersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localPurchasesRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalPurchase
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localPurchasesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localPurchasesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localPurchaseItemsRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalPurchaseItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localPurchaseItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localPurchaseItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localPurchasePaymentsRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalPurchasePayment
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localPurchasePaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localPurchasePaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localCustomersRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalCustomer
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localCustomersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localCustomersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localSalesRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalSale
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localSalesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localSalesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localSaleItemsRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalSaleItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localSaleItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localSaleItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localSaleReturnsRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalSaleReturn
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localSaleReturnsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localSaleReturnsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localSaleReturnItemsRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalSaleReturnItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localSaleReturnItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localSaleReturnItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localCustomerPaymentsRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalCustomerPayment
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localCustomerPaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localCustomerPaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localCashTransactionsRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalCashTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localCashTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localCashTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localExpensesRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalExpense
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localExpensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localExpensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localIncomesRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalIncome
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localIncomesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localIncomesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localRecycleBinEntriesRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalRecycleBinEntry
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localRecycleBinEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localRecycleBinEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localNotesRefs)
                        await $_getPrefetchedData<
                          LocalShop,
                          $LocalShopsTable,
                          LocalNote
                        >(
                          currentTable: table,
                          referencedTable: $$LocalShopsTableReferences
                              ._localNotesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalShopsTableReferences(
                                db,
                                table,
                                p0,
                              ).localNotesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.shopId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalShopsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalShopsTable,
      LocalShop,
      $$LocalShopsTableFilterComposer,
      $$LocalShopsTableOrderingComposer,
      $$LocalShopsTableAnnotationComposer,
      $$LocalShopsTableCreateCompanionBuilder,
      $$LocalShopsTableUpdateCompanionBuilder,
      (LocalShop, $$LocalShopsTableReferences),
      LocalShop,
      PrefetchHooks Function({
        bool localUsersRefs,
        bool localCategoriesRefs,
        bool localSuppliersRefs,
        bool localPurchasesRefs,
        bool localPurchaseItemsRefs,
        bool localPurchasePaymentsRefs,
        bool localCustomersRefs,
        bool localSalesRefs,
        bool localSaleItemsRefs,
        bool localSaleReturnsRefs,
        bool localSaleReturnItemsRefs,
        bool localCustomerPaymentsRefs,
        bool localCashTransactionsRefs,
        bool localExpensesRefs,
        bool localIncomesRefs,
        bool localRecycleBinEntriesRefs,
        bool localNotesRefs,
      })
    >;
typedef $$LocalUsersTableCreateCompanionBuilder =
    LocalUsersCompanion Function({
      required String id,
      required String shopId,
      required String name,
      required String email,
      Value<String?> passwordHash,
      required String role,
      Value<DateTime?> emailVerifiedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<bool> isCurrent,
      Value<int> rowid,
    });
typedef $$LocalUsersTableUpdateCompanionBuilder =
    LocalUsersCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> name,
      Value<String> email,
      Value<String?> passwordHash,
      Value<String> role,
      Value<DateTime?> emailVerifiedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<bool> isCurrent,
      Value<int> rowid,
    });

final class $$LocalUsersTableReferences
    extends BaseReferences<_$AppDatabase, $LocalUsersTable, LocalUser> {
  $$LocalUsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localUsers.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $LocalRecycleBinEntriesTable,
    List<LocalRecycleBinEntry>
  >
  _localRecycleBinEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localRecycleBinEntries,
        aliasName: $_aliasNameGenerator(
          db.localUsers.id,
          db.localRecycleBinEntries.deletedByUserId,
        ),
      );

  $$LocalRecycleBinEntriesTableProcessedTableManager
  get localRecycleBinEntriesRefs {
    final manager =
        $$LocalRecycleBinEntriesTableTableManager(
          $_db,
          $_db.localRecycleBinEntries,
        ).filter(
          (f) => f.deletedByUserId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _localRecycleBinEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalUsersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get emailVerifiedAt => $composableBuilder(
    column: $table.emailVerifiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localRecycleBinEntriesRefs(
    Expression<bool> Function($$LocalRecycleBinEntriesTableFilterComposer f) f,
  ) {
    final $$LocalRecycleBinEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localRecycleBinEntries,
          getReferencedColumn: (t) => t.deletedByUserId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalRecycleBinEntriesTableFilterComposer(
                $db: $db,
                $table: $db.localRecycleBinEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalUsersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get emailVerifiedAt => $composableBuilder(
    column: $table.emailVerifiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalUsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalUsersTable> {
  $$LocalUsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get emailVerifiedAt => $composableBuilder(
    column: $table.emailVerifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCurrent =>
      $composableBuilder(column: $table.isCurrent, builder: (column) => column);

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localRecycleBinEntriesRefs<T extends Object>(
    Expression<T> Function($$LocalRecycleBinEntriesTableAnnotationComposer a) f,
  ) {
    final $$LocalRecycleBinEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localRecycleBinEntries,
          getReferencedColumn: (t) => t.deletedByUserId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalRecycleBinEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.localRecycleBinEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalUsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalUsersTable,
          LocalUser,
          $$LocalUsersTableFilterComposer,
          $$LocalUsersTableOrderingComposer,
          $$LocalUsersTableAnnotationComposer,
          $$LocalUsersTableCreateCompanionBuilder,
          $$LocalUsersTableUpdateCompanionBuilder,
          (LocalUser, $$LocalUsersTableReferences),
          LocalUser,
          PrefetchHooks Function({bool shopId, bool localRecycleBinEntriesRefs})
        > {
  $$LocalUsersTableTableManager(_$AppDatabase db, $LocalUsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalUsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalUsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalUsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime?> emailVerifiedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isCurrent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalUsersCompanion(
                id: id,
                shopId: shopId,
                name: name,
                email: email,
                passwordHash: passwordHash,
                role: role,
                emailVerifiedAt: emailVerifiedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                isCurrent: isCurrent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String name,
                required String email,
                Value<String?> passwordHash = const Value.absent(),
                required String role,
                Value<DateTime?> emailVerifiedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<bool> isCurrent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalUsersCompanion.insert(
                id: id,
                shopId: shopId,
                name: name,
                email: email,
                passwordHash: passwordHash,
                role: role,
                emailVerifiedAt: emailVerifiedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                isCurrent: isCurrent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalUsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({shopId = false, localRecycleBinEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localRecycleBinEntriesRefs) db.localRecycleBinEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (shopId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shopId,
                                    referencedTable: $$LocalUsersTableReferences
                                        ._shopIdTable(db),
                                    referencedColumn:
                                        $$LocalUsersTableReferences
                                            ._shopIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localRecycleBinEntriesRefs)
                        await $_getPrefetchedData<
                          LocalUser,
                          $LocalUsersTable,
                          LocalRecycleBinEntry
                        >(
                          currentTable: table,
                          referencedTable: $$LocalUsersTableReferences
                              ._localRecycleBinEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalUsersTableReferences(
                                db,
                                table,
                                p0,
                              ).localRecycleBinEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.deletedByUserId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalUsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalUsersTable,
      LocalUser,
      $$LocalUsersTableFilterComposer,
      $$LocalUsersTableOrderingComposer,
      $$LocalUsersTableAnnotationComposer,
      $$LocalUsersTableCreateCompanionBuilder,
      $$LocalUsersTableUpdateCompanionBuilder,
      (LocalUser, $$LocalUsersTableReferences),
      LocalUser,
      PrefetchHooks Function({bool shopId, bool localRecycleBinEntriesRefs})
    >;
typedef $$LocalCategoriesTableCreateCompanionBuilder =
    LocalCategoriesCompanion Function({
      required String id,
      required String shopId,
      required String name,
      required String type,
      Value<String?> details,
      Value<String?> imageUrl,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalCategoriesTableUpdateCompanionBuilder =
    LocalCategoriesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> name,
      Value<String> type,
      Value<String?> details,
      Value<String?> imageUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalCategoriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $LocalCategoriesTable, LocalCategory> {
  $$LocalCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localCategories.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LocalPurchaseItemsTable, List<LocalPurchaseItem>>
  _localPurchaseItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localPurchaseItems,
        aliasName: $_aliasNameGenerator(
          db.localCategories.id,
          db.localPurchaseItems.categoryId,
        ),
      );

  $$LocalPurchaseItemsTableProcessedTableManager get localPurchaseItemsRefs {
    final manager = $$LocalPurchaseItemsTableTableManager(
      $_db,
      $_db.localPurchaseItems,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localPurchaseItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalExpensesTable, List<LocalExpense>>
  _localExpensesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localExpenses,
    aliasName: $_aliasNameGenerator(
      db.localCategories.id,
      db.localExpenses.categoryId,
    ),
  );

  $$LocalExpensesTableProcessedTableManager get localExpensesRefs {
    final manager = $$LocalExpensesTableTableManager(
      $_db,
      $_db.localExpenses,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localExpensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalIncomesTable, List<LocalIncome>>
  _localIncomesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localIncomes,
    aliasName: $_aliasNameGenerator(
      db.localCategories.id,
      db.localIncomes.categoryId,
    ),
  );

  $$LocalIncomesTableProcessedTableManager get localIncomesRefs {
    final manager = $$LocalIncomesTableTableManager(
      $_db,
      $_db.localIncomes,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localIncomesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCategoriesTable> {
  $$LocalCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localPurchaseItemsRefs(
    Expression<bool> Function($$LocalPurchaseItemsTableFilterComposer f) f,
  ) {
    final $$LocalPurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localPurchaseItems,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.localPurchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localExpensesRefs(
    Expression<bool> Function($$LocalExpensesTableFilterComposer f) f,
  ) {
    final $$LocalExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localExpenses,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalExpensesTableFilterComposer(
            $db: $db,
            $table: $db.localExpenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localIncomesRefs(
    Expression<bool> Function($$LocalIncomesTableFilterComposer f) f,
  ) {
    final $$LocalIncomesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localIncomes,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalIncomesTableFilterComposer(
            $db: $db,
            $table: $db.localIncomes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCategoriesTable> {
  $$LocalCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCategoriesTable> {
  $$LocalCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localPurchaseItemsRefs<T extends Object>(
    Expression<T> Function($$LocalPurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalPurchaseItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localPurchaseItems,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalPurchaseItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.localPurchaseItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localExpensesRefs<T extends Object>(
    Expression<T> Function($$LocalExpensesTableAnnotationComposer a) f,
  ) {
    final $$LocalExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localExpenses,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.localExpenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localIncomesRefs<T extends Object>(
    Expression<T> Function($$LocalIncomesTableAnnotationComposer a) f,
  ) {
    final $$LocalIncomesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localIncomes,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalIncomesTableAnnotationComposer(
            $db: $db,
            $table: $db.localIncomes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCategoriesTable,
          LocalCategory,
          $$LocalCategoriesTableFilterComposer,
          $$LocalCategoriesTableOrderingComposer,
          $$LocalCategoriesTableAnnotationComposer,
          $$LocalCategoriesTableCreateCompanionBuilder,
          $$LocalCategoriesTableUpdateCompanionBuilder,
          (LocalCategory, $$LocalCategoriesTableReferences),
          LocalCategory,
          PrefetchHooks Function({
            bool shopId,
            bool localPurchaseItemsRefs,
            bool localExpensesRefs,
            bool localIncomesRefs,
          })
        > {
  $$LocalCategoriesTableTableManager(
    _$AppDatabase db,
    $LocalCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCategoriesCompanion(
                id: id,
                shopId: shopId,
                name: name,
                type: type,
                details: details,
                imageUrl: imageUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String name,
                required String type,
                Value<String?> details = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCategoriesCompanion.insert(
                id: id,
                shopId: shopId,
                name: name,
                type: type,
                details: details,
                imageUrl: imageUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shopId = false,
                localPurchaseItemsRefs = false,
                localExpensesRefs = false,
                localIncomesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localPurchaseItemsRefs) db.localPurchaseItems,
                    if (localExpensesRefs) db.localExpenses,
                    if (localIncomesRefs) db.localIncomes,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (shopId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shopId,
                                    referencedTable:
                                        $$LocalCategoriesTableReferences
                                            ._shopIdTable(db),
                                    referencedColumn:
                                        $$LocalCategoriesTableReferences
                                            ._shopIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localPurchaseItemsRefs)
                        await $_getPrefetchedData<
                          LocalCategory,
                          $LocalCategoriesTable,
                          LocalPurchaseItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalCategoriesTableReferences
                              ._localPurchaseItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).localPurchaseItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localExpensesRefs)
                        await $_getPrefetchedData<
                          LocalCategory,
                          $LocalCategoriesTable,
                          LocalExpense
                        >(
                          currentTable: table,
                          referencedTable: $$LocalCategoriesTableReferences
                              ._localExpensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).localExpensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localIncomesRefs)
                        await $_getPrefetchedData<
                          LocalCategory,
                          $LocalCategoriesTable,
                          LocalIncome
                        >(
                          currentTable: table,
                          referencedTable: $$LocalCategoriesTableReferences
                              ._localIncomesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).localIncomesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCategoriesTable,
      LocalCategory,
      $$LocalCategoriesTableFilterComposer,
      $$LocalCategoriesTableOrderingComposer,
      $$LocalCategoriesTableAnnotationComposer,
      $$LocalCategoriesTableCreateCompanionBuilder,
      $$LocalCategoriesTableUpdateCompanionBuilder,
      (LocalCategory, $$LocalCategoriesTableReferences),
      LocalCategory,
      PrefetchHooks Function({
        bool shopId,
        bool localPurchaseItemsRefs,
        bool localExpensesRefs,
        bool localIncomesRefs,
      })
    >;
typedef $$LocalSuppliersTableCreateCompanionBuilder =
    LocalSuppliersCompanion Function({
      required String id,
      required String shopId,
      required String name,
      Value<String?> image,
      Value<String?> mobile,
      Value<String?> address,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalSuppliersTableUpdateCompanionBuilder =
    LocalSuppliersCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> name,
      Value<String?> image,
      Value<String?> mobile,
      Value<String?> address,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalSuppliersTableReferences
    extends BaseReferences<_$AppDatabase, $LocalSuppliersTable, LocalSupplier> {
  $$LocalSuppliersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localSuppliers.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LocalPurchasesTable, List<LocalPurchase>>
  _localPurchasesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localPurchases,
    aliasName: $_aliasNameGenerator(
      db.localSuppliers.id,
      db.localPurchases.supplierId,
    ),
  );

  $$LocalPurchasesTableProcessedTableManager get localPurchasesRefs {
    final manager = $$LocalPurchasesTableTableManager(
      $_db,
      $_db.localPurchases,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localPurchasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalSuppliersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSuppliersTable> {
  $$LocalSuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localPurchasesRefs(
    Expression<bool> Function($$LocalPurchasesTableFilterComposer f) f,
  ) {
    final $$LocalPurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localPurchases,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchasesTableFilterComposer(
            $db: $db,
            $table: $db.localPurchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalSuppliersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSuppliersTable> {
  $$LocalSuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSuppliersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSuppliersTable> {
  $$LocalSuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localPurchasesRefs<T extends Object>(
    Expression<T> Function($$LocalPurchasesTableAnnotationComposer a) f,
  ) {
    final $$LocalPurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localPurchases,
      getReferencedColumn: (t) => t.supplierId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.localPurchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalSuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSuppliersTable,
          LocalSupplier,
          $$LocalSuppliersTableFilterComposer,
          $$LocalSuppliersTableOrderingComposer,
          $$LocalSuppliersTableAnnotationComposer,
          $$LocalSuppliersTableCreateCompanionBuilder,
          $$LocalSuppliersTableUpdateCompanionBuilder,
          (LocalSupplier, $$LocalSuppliersTableReferences),
          LocalSupplier,
          PrefetchHooks Function({bool shopId, bool localPurchasesRefs})
        > {
  $$LocalSuppliersTableTableManager(
    _$AppDatabase db,
    $LocalSuppliersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> mobile = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSuppliersCompanion(
                id: id,
                shopId: shopId,
                name: name,
                image: image,
                mobile: mobile,
                address: address,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String name,
                Value<String?> image = const Value.absent(),
                Value<String?> mobile = const Value.absent(),
                Value<String?> address = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSuppliersCompanion.insert(
                id: id,
                shopId: shopId,
                name: name,
                image: image,
                mobile: mobile,
                address: address,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalSuppliersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({shopId = false, localPurchasesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localPurchasesRefs) db.localPurchases,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (shopId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shopId,
                                    referencedTable:
                                        $$LocalSuppliersTableReferences
                                            ._shopIdTable(db),
                                    referencedColumn:
                                        $$LocalSuppliersTableReferences
                                            ._shopIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localPurchasesRefs)
                        await $_getPrefetchedData<
                          LocalSupplier,
                          $LocalSuppliersTable,
                          LocalPurchase
                        >(
                          currentTable: table,
                          referencedTable: $$LocalSuppliersTableReferences
                              ._localPurchasesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalSuppliersTableReferences(
                                db,
                                table,
                                p0,
                              ).localPurchasesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.supplierId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalSuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSuppliersTable,
      LocalSupplier,
      $$LocalSuppliersTableFilterComposer,
      $$LocalSuppliersTableOrderingComposer,
      $$LocalSuppliersTableAnnotationComposer,
      $$LocalSuppliersTableCreateCompanionBuilder,
      $$LocalSuppliersTableUpdateCompanionBuilder,
      (LocalSupplier, $$LocalSuppliersTableReferences),
      LocalSupplier,
      PrefetchHooks Function({bool shopId, bool localPurchasesRefs})
    >;
typedef $$LocalPurchasesTableCreateCompanionBuilder =
    LocalPurchasesCompanion Function({
      required String id,
      required String shopId,
      required String supplierId,
      required double total,
      Value<double> otherCharge,
      Value<String?> description,
      Value<String?> buyingMemoUrl,
      Value<String> status,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalPurchasesTableUpdateCompanionBuilder =
    LocalPurchasesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> supplierId,
      Value<double> total,
      Value<double> otherCharge,
      Value<String?> description,
      Value<String?> buyingMemoUrl,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalPurchasesTableReferences
    extends BaseReferences<_$AppDatabase, $LocalPurchasesTable, LocalPurchase> {
  $$LocalPurchasesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localPurchases.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalSuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.localSuppliers.createAlias(
        $_aliasNameGenerator(
          db.localPurchases.supplierId,
          db.localSuppliers.id,
        ),
      );

  $$LocalSuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<String>('supplier_id')!;

    final manager = $$LocalSuppliersTableTableManager(
      $_db,
      $_db.localSuppliers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LocalPurchaseItemsTable, List<LocalPurchaseItem>>
  _localPurchaseItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localPurchaseItems,
        aliasName: $_aliasNameGenerator(
          db.localPurchases.id,
          db.localPurchaseItems.purchaseId,
        ),
      );

  $$LocalPurchaseItemsTableProcessedTableManager get localPurchaseItemsRefs {
    final manager = $$LocalPurchaseItemsTableTableManager(
      $_db,
      $_db.localPurchaseItems,
    ).filter((f) => f.purchaseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localPurchaseItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalPurchasePaymentsTable,
    List<LocalPurchasePayment>
  >
  _localPurchasePaymentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localPurchasePayments,
        aliasName: $_aliasNameGenerator(
          db.localPurchases.id,
          db.localPurchasePayments.purchaseId,
        ),
      );

  $$LocalPurchasePaymentsTableProcessedTableManager
  get localPurchasePaymentsRefs {
    final manager = $$LocalPurchasePaymentsTableTableManager(
      $_db,
      $_db.localPurchasePayments,
    ).filter((f) => f.purchaseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localPurchasePaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalPurchasesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalPurchasesTable> {
  $$LocalPurchasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get otherCharge => $composableBuilder(
    column: $table.otherCharge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buyingMemoUrl => $composableBuilder(
    column: $table.buyingMemoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSuppliersTableFilterComposer get supplierId {
    final $$LocalSuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.localSuppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSuppliersTableFilterComposer(
            $db: $db,
            $table: $db.localSuppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localPurchaseItemsRefs(
    Expression<bool> Function($$LocalPurchaseItemsTableFilterComposer f) f,
  ) {
    final $$LocalPurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localPurchaseItems,
      getReferencedColumn: (t) => t.purchaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.localPurchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localPurchasePaymentsRefs(
    Expression<bool> Function($$LocalPurchasePaymentsTableFilterComposer f) f,
  ) {
    final $$LocalPurchasePaymentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localPurchasePayments,
          getReferencedColumn: (t) => t.purchaseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalPurchasePaymentsTableFilterComposer(
                $db: $db,
                $table: $db.localPurchasePayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalPurchasesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalPurchasesTable> {
  $$LocalPurchasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get otherCharge => $composableBuilder(
    column: $table.otherCharge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buyingMemoUrl => $composableBuilder(
    column: $table.buyingMemoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSuppliersTableOrderingComposer get supplierId {
    final $$LocalSuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.localSuppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.localSuppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalPurchasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalPurchasesTable> {
  $$LocalPurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<double> get otherCharge => $composableBuilder(
    column: $table.otherCharge,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get buyingMemoUrl => $composableBuilder(
    column: $table.buyingMemoUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSuppliersTableAnnotationComposer get supplierId {
    final $$LocalSuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.localSuppliers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.localSuppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localPurchaseItemsRefs<T extends Object>(
    Expression<T> Function($$LocalPurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalPurchaseItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localPurchaseItems,
          getReferencedColumn: (t) => t.purchaseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalPurchaseItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.localPurchaseItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localPurchasePaymentsRefs<T extends Object>(
    Expression<T> Function($$LocalPurchasePaymentsTableAnnotationComposer a) f,
  ) {
    final $$LocalPurchasePaymentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localPurchasePayments,
          getReferencedColumn: (t) => t.purchaseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalPurchasePaymentsTableAnnotationComposer(
                $db: $db,
                $table: $db.localPurchasePayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalPurchasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalPurchasesTable,
          LocalPurchase,
          $$LocalPurchasesTableFilterComposer,
          $$LocalPurchasesTableOrderingComposer,
          $$LocalPurchasesTableAnnotationComposer,
          $$LocalPurchasesTableCreateCompanionBuilder,
          $$LocalPurchasesTableUpdateCompanionBuilder,
          (LocalPurchase, $$LocalPurchasesTableReferences),
          LocalPurchase,
          PrefetchHooks Function({
            bool shopId,
            bool supplierId,
            bool localPurchaseItemsRefs,
            bool localPurchasePaymentsRefs,
          })
        > {
  $$LocalPurchasesTableTableManager(
    _$AppDatabase db,
    $LocalPurchasesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalPurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> supplierId = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<double> otherCharge = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> buyingMemoUrl = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPurchasesCompanion(
                id: id,
                shopId: shopId,
                supplierId: supplierId,
                total: total,
                otherCharge: otherCharge,
                description: description,
                buyingMemoUrl: buyingMemoUrl,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String supplierId,
                required double total,
                Value<double> otherCharge = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> buyingMemoUrl = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPurchasesCompanion.insert(
                id: id,
                shopId: shopId,
                supplierId: supplierId,
                total: total,
                otherCharge: otherCharge,
                description: description,
                buyingMemoUrl: buyingMemoUrl,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalPurchasesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shopId = false,
                supplierId = false,
                localPurchaseItemsRefs = false,
                localPurchasePaymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localPurchaseItemsRefs) db.localPurchaseItems,
                    if (localPurchasePaymentsRefs) db.localPurchasePayments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (shopId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shopId,
                                    referencedTable:
                                        $$LocalPurchasesTableReferences
                                            ._shopIdTable(db),
                                    referencedColumn:
                                        $$LocalPurchasesTableReferences
                                            ._shopIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (supplierId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.supplierId,
                                    referencedTable:
                                        $$LocalPurchasesTableReferences
                                            ._supplierIdTable(db),
                                    referencedColumn:
                                        $$LocalPurchasesTableReferences
                                            ._supplierIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localPurchaseItemsRefs)
                        await $_getPrefetchedData<
                          LocalPurchase,
                          $LocalPurchasesTable,
                          LocalPurchaseItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalPurchasesTableReferences
                              ._localPurchaseItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalPurchasesTableReferences(
                                db,
                                table,
                                p0,
                              ).localPurchaseItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localPurchasePaymentsRefs)
                        await $_getPrefetchedData<
                          LocalPurchase,
                          $LocalPurchasesTable,
                          LocalPurchasePayment
                        >(
                          currentTable: table,
                          referencedTable: $$LocalPurchasesTableReferences
                              ._localPurchasePaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalPurchasesTableReferences(
                                db,
                                table,
                                p0,
                              ).localPurchasePaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalPurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalPurchasesTable,
      LocalPurchase,
      $$LocalPurchasesTableFilterComposer,
      $$LocalPurchasesTableOrderingComposer,
      $$LocalPurchasesTableAnnotationComposer,
      $$LocalPurchasesTableCreateCompanionBuilder,
      $$LocalPurchasesTableUpdateCompanionBuilder,
      (LocalPurchase, $$LocalPurchasesTableReferences),
      LocalPurchase,
      PrefetchHooks Function({
        bool shopId,
        bool supplierId,
        bool localPurchaseItemsRefs,
        bool localPurchasePaymentsRefs,
      })
    >;
typedef $$LocalPurchaseItemsTableCreateCompanionBuilder =
    LocalPurchaseItemsCompanion Function({
      required String id,
      required String shopId,
      Value<String?> purchaseId,
      Value<String?> categoryId,
      required String productName,
      required double buyingPrice,
      Value<double?> estSellingPrice,
      Value<int> quantity,
      Value<String?> barcode,
      Value<double> otherCharge,
      Value<String?> description,
      Value<String?> productImage,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalPurchaseItemsTableUpdateCompanionBuilder =
    LocalPurchaseItemsCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String?> purchaseId,
      Value<String?> categoryId,
      Value<String> productName,
      Value<double> buyingPrice,
      Value<double?> estSellingPrice,
      Value<int> quantity,
      Value<String?> barcode,
      Value<double> otherCharge,
      Value<String?> description,
      Value<String?> productImage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalPurchaseItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalPurchaseItemsTable,
          LocalPurchaseItem
        > {
  $$LocalPurchaseItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localPurchaseItems.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalPurchasesTable _purchaseIdTable(_$AppDatabase db) =>
      db.localPurchases.createAlias(
        $_aliasNameGenerator(
          db.localPurchaseItems.purchaseId,
          db.localPurchases.id,
        ),
      );

  $$LocalPurchasesTableProcessedTableManager? get purchaseId {
    final $_column = $_itemColumn<String>('purchase_id');
    if ($_column == null) return null;
    final manager = $$LocalPurchasesTableTableManager(
      $_db,
      $_db.localPurchases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.localCategories.createAlias(
        $_aliasNameGenerator(
          db.localPurchaseItems.categoryId,
          db.localCategories.id,
        ),
      );

  $$LocalCategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$LocalCategoriesTableTableManager(
      $_db,
      $_db.localCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LocalSaleItemsTable, List<LocalSaleItem>>
  _localSaleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localSaleItems,
    aliasName: $_aliasNameGenerator(
      db.localPurchaseItems.id,
      db.localSaleItems.productId,
    ),
  );

  $$LocalSaleItemsTableProcessedTableManager get localSaleItemsRefs {
    final manager = $$LocalSaleItemsTableTableManager(
      $_db,
      $_db.localSaleItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localSaleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalSaleReturnItemsTable,
    List<LocalSaleReturnItem>
  >
  _localSaleReturnItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localSaleReturnItems,
        aliasName: $_aliasNameGenerator(
          db.localPurchaseItems.id,
          db.localSaleReturnItems.productId,
        ),
      );

  $$LocalSaleReturnItemsTableProcessedTableManager
  get localSaleReturnItemsRefs {
    final manager = $$LocalSaleReturnItemsTableTableManager(
      $_db,
      $_db.localSaleReturnItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localSaleReturnItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalPurchaseItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalPurchaseItemsTable> {
  $$LocalPurchaseItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get buyingPrice => $composableBuilder(
    column: $table.buyingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estSellingPrice => $composableBuilder(
    column: $table.estSellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get otherCharge => $composableBuilder(
    column: $table.otherCharge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productImage => $composableBuilder(
    column: $table.productImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchasesTableFilterComposer get purchaseId {
    final $$LocalPurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.localPurchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchasesTableFilterComposer(
            $db: $db,
            $table: $db.localPurchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCategoriesTableFilterComposer get categoryId {
    final $$LocalCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.localCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.localCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localSaleItemsRefs(
    Expression<bool> Function($$LocalSaleItemsTableFilterComposer f) f,
  ) {
    final $$LocalSaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localSaleReturnItemsRefs(
    Expression<bool> Function($$LocalSaleReturnItemsTableFilterComposer f) f,
  ) {
    final $$LocalSaleReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleReturnItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalPurchaseItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalPurchaseItemsTable> {
  $$LocalPurchaseItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get buyingPrice => $composableBuilder(
    column: $table.buyingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estSellingPrice => $composableBuilder(
    column: $table.estSellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get otherCharge => $composableBuilder(
    column: $table.otherCharge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productImage => $composableBuilder(
    column: $table.productImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchasesTableOrderingComposer get purchaseId {
    final $$LocalPurchasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.localPurchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchasesTableOrderingComposer(
            $db: $db,
            $table: $db.localPurchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCategoriesTableOrderingComposer get categoryId {
    final $$LocalCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.localCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.localCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalPurchaseItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalPurchaseItemsTable> {
  $$LocalPurchaseItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get buyingPrice => $composableBuilder(
    column: $table.buyingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estSellingPrice => $composableBuilder(
    column: $table.estSellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<double> get otherCharge => $composableBuilder(
    column: $table.otherCharge,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productImage => $composableBuilder(
    column: $table.productImage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchasesTableAnnotationComposer get purchaseId {
    final $$LocalPurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.localPurchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.localPurchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCategoriesTableAnnotationComposer get categoryId {
    final $$LocalCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.localCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.localCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localSaleItemsRefs<T extends Object>(
    Expression<T> Function($$LocalSaleItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalSaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.localSaleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localSaleReturnItemsRefs<T extends Object>(
    Expression<T> Function($$LocalSaleReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalSaleReturnItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localSaleReturnItems,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalSaleReturnItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.localSaleReturnItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalPurchaseItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalPurchaseItemsTable,
          LocalPurchaseItem,
          $$LocalPurchaseItemsTableFilterComposer,
          $$LocalPurchaseItemsTableOrderingComposer,
          $$LocalPurchaseItemsTableAnnotationComposer,
          $$LocalPurchaseItemsTableCreateCompanionBuilder,
          $$LocalPurchaseItemsTableUpdateCompanionBuilder,
          (LocalPurchaseItem, $$LocalPurchaseItemsTableReferences),
          LocalPurchaseItem,
          PrefetchHooks Function({
            bool shopId,
            bool purchaseId,
            bool categoryId,
            bool localSaleItemsRefs,
            bool localSaleReturnItemsRefs,
          })
        > {
  $$LocalPurchaseItemsTableTableManager(
    _$AppDatabase db,
    $LocalPurchaseItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPurchaseItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPurchaseItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalPurchaseItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String?> purchaseId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<double> buyingPrice = const Value.absent(),
                Value<double?> estSellingPrice = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<double> otherCharge = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> productImage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPurchaseItemsCompanion(
                id: id,
                shopId: shopId,
                purchaseId: purchaseId,
                categoryId: categoryId,
                productName: productName,
                buyingPrice: buyingPrice,
                estSellingPrice: estSellingPrice,
                quantity: quantity,
                barcode: barcode,
                otherCharge: otherCharge,
                description: description,
                productImage: productImage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                Value<String?> purchaseId = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                required String productName,
                required double buyingPrice,
                Value<double?> estSellingPrice = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<double> otherCharge = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> productImage = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPurchaseItemsCompanion.insert(
                id: id,
                shopId: shopId,
                purchaseId: purchaseId,
                categoryId: categoryId,
                productName: productName,
                buyingPrice: buyingPrice,
                estSellingPrice: estSellingPrice,
                quantity: quantity,
                barcode: barcode,
                otherCharge: otherCharge,
                description: description,
                productImage: productImage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalPurchaseItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shopId = false,
                purchaseId = false,
                categoryId = false,
                localSaleItemsRefs = false,
                localSaleReturnItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localSaleItemsRefs) db.localSaleItems,
                    if (localSaleReturnItemsRefs) db.localSaleReturnItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (shopId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shopId,
                                    referencedTable:
                                        $$LocalPurchaseItemsTableReferences
                                            ._shopIdTable(db),
                                    referencedColumn:
                                        $$LocalPurchaseItemsTableReferences
                                            ._shopIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (purchaseId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.purchaseId,
                                    referencedTable:
                                        $$LocalPurchaseItemsTableReferences
                                            ._purchaseIdTable(db),
                                    referencedColumn:
                                        $$LocalPurchaseItemsTableReferences
                                            ._purchaseIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$LocalPurchaseItemsTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$LocalPurchaseItemsTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localSaleItemsRefs)
                        await $_getPrefetchedData<
                          LocalPurchaseItem,
                          $LocalPurchaseItemsTable,
                          LocalSaleItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalPurchaseItemsTableReferences
                              ._localSaleItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalPurchaseItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).localSaleItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localSaleReturnItemsRefs)
                        await $_getPrefetchedData<
                          LocalPurchaseItem,
                          $LocalPurchaseItemsTable,
                          LocalSaleReturnItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalPurchaseItemsTableReferences
                              ._localSaleReturnItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalPurchaseItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).localSaleReturnItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalPurchaseItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalPurchaseItemsTable,
      LocalPurchaseItem,
      $$LocalPurchaseItemsTableFilterComposer,
      $$LocalPurchaseItemsTableOrderingComposer,
      $$LocalPurchaseItemsTableAnnotationComposer,
      $$LocalPurchaseItemsTableCreateCompanionBuilder,
      $$LocalPurchaseItemsTableUpdateCompanionBuilder,
      (LocalPurchaseItem, $$LocalPurchaseItemsTableReferences),
      LocalPurchaseItem,
      PrefetchHooks Function({
        bool shopId,
        bool purchaseId,
        bool categoryId,
        bool localSaleItemsRefs,
        bool localSaleReturnItemsRefs,
      })
    >;
typedef $$LocalPurchasePaymentsTableCreateCompanionBuilder =
    LocalPurchasePaymentsCompanion Function({
      required String id,
      required String shopId,
      required String purchaseId,
      required double payments,
      Value<String?> description,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalPurchasePaymentsTableUpdateCompanionBuilder =
    LocalPurchasePaymentsCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> purchaseId,
      Value<double> payments,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalPurchasePaymentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalPurchasePaymentsTable,
          LocalPurchasePayment
        > {
  $$LocalPurchasePaymentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localPurchasePayments.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalPurchasesTable _purchaseIdTable(_$AppDatabase db) =>
      db.localPurchases.createAlias(
        $_aliasNameGenerator(
          db.localPurchasePayments.purchaseId,
          db.localPurchases.id,
        ),
      );

  $$LocalPurchasesTableProcessedTableManager get purchaseId {
    final $_column = $_itemColumn<String>('purchase_id')!;

    final manager = $$LocalPurchasesTableTableManager(
      $_db,
      $_db.localPurchases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalPurchasePaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalPurchasePaymentsTable> {
  $$LocalPurchasePaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get payments => $composableBuilder(
    column: $table.payments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchasesTableFilterComposer get purchaseId {
    final $$LocalPurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.localPurchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchasesTableFilterComposer(
            $db: $db,
            $table: $db.localPurchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalPurchasePaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalPurchasePaymentsTable> {
  $$LocalPurchasePaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get payments => $composableBuilder(
    column: $table.payments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchasesTableOrderingComposer get purchaseId {
    final $$LocalPurchasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.localPurchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchasesTableOrderingComposer(
            $db: $db,
            $table: $db.localPurchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalPurchasePaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalPurchasePaymentsTable> {
  $$LocalPurchasePaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get payments =>
      $composableBuilder(column: $table.payments, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchasesTableAnnotationComposer get purchaseId {
    final $$LocalPurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.localPurchases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.localPurchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalPurchasePaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalPurchasePaymentsTable,
          LocalPurchasePayment,
          $$LocalPurchasePaymentsTableFilterComposer,
          $$LocalPurchasePaymentsTableOrderingComposer,
          $$LocalPurchasePaymentsTableAnnotationComposer,
          $$LocalPurchasePaymentsTableCreateCompanionBuilder,
          $$LocalPurchasePaymentsTableUpdateCompanionBuilder,
          (LocalPurchasePayment, $$LocalPurchasePaymentsTableReferences),
          LocalPurchasePayment,
          PrefetchHooks Function({bool shopId, bool purchaseId})
        > {
  $$LocalPurchasePaymentsTableTableManager(
    _$AppDatabase db,
    $LocalPurchasePaymentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPurchasePaymentsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalPurchasePaymentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalPurchasePaymentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> purchaseId = const Value.absent(),
                Value<double> payments = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPurchasePaymentsCompanion(
                id: id,
                shopId: shopId,
                purchaseId: purchaseId,
                payments: payments,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String purchaseId,
                required double payments,
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPurchasePaymentsCompanion.insert(
                id: id,
                shopId: shopId,
                purchaseId: purchaseId,
                payments: payments,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalPurchasePaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shopId = false, purchaseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (shopId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.shopId,
                                referencedTable:
                                    $$LocalPurchasePaymentsTableReferences
                                        ._shopIdTable(db),
                                referencedColumn:
                                    $$LocalPurchasePaymentsTableReferences
                                        ._shopIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (purchaseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.purchaseId,
                                referencedTable:
                                    $$LocalPurchasePaymentsTableReferences
                                        ._purchaseIdTable(db),
                                referencedColumn:
                                    $$LocalPurchasePaymentsTableReferences
                                        ._purchaseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalPurchasePaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalPurchasePaymentsTable,
      LocalPurchasePayment,
      $$LocalPurchasePaymentsTableFilterComposer,
      $$LocalPurchasePaymentsTableOrderingComposer,
      $$LocalPurchasePaymentsTableAnnotationComposer,
      $$LocalPurchasePaymentsTableCreateCompanionBuilder,
      $$LocalPurchasePaymentsTableUpdateCompanionBuilder,
      (LocalPurchasePayment, $$LocalPurchasePaymentsTableReferences),
      LocalPurchasePayment,
      PrefetchHooks Function({bool shopId, bool purchaseId})
    >;
typedef $$LocalCustomersTableCreateCompanionBuilder =
    LocalCustomersCompanion Function({
      required String id,
      required String shopId,
      required String name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalCustomersTableUpdateCompanionBuilder =
    LocalCustomersCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> name,
      Value<String?> email,
      Value<String?> phone,
      Value<String?> address,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalCustomersTableReferences
    extends BaseReferences<_$AppDatabase, $LocalCustomersTable, LocalCustomer> {
  $$LocalCustomersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localCustomers.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LocalSalesTable, List<LocalSale>>
  _localSalesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localSales,
    aliasName: $_aliasNameGenerator(
      db.localCustomers.id,
      db.localSales.customerId,
    ),
  );

  $$LocalSalesTableProcessedTableManager get localSalesRefs {
    final manager = $$LocalSalesTableTableManager(
      $_db,
      $_db.localSales,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localSalesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalCustomerPaymentsTable,
    List<LocalCustomerPayment>
  >
  _localCustomerPaymentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localCustomerPayments,
        aliasName: $_aliasNameGenerator(
          db.localCustomers.id,
          db.localCustomerPayments.customerId,
        ),
      );

  $$LocalCustomerPaymentsTableProcessedTableManager
  get localCustomerPaymentsRefs {
    final manager = $$LocalCustomerPaymentsTableTableManager(
      $_db,
      $_db.localCustomerPayments,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localCustomerPaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalCustomersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCustomersTable> {
  $$LocalCustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localSalesRefs(
    Expression<bool> Function($$LocalSalesTableFilterComposer f) f,
  ) {
    final $$LocalSalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableFilterComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localCustomerPaymentsRefs(
    Expression<bool> Function($$LocalCustomerPaymentsTableFilterComposer f) f,
  ) {
    final $$LocalCustomerPaymentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCustomerPayments,
          getReferencedColumn: (t) => t.customerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCustomerPaymentsTableFilterComposer(
                $db: $db,
                $table: $db.localCustomerPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalCustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCustomersTable> {
  $$LocalCustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCustomersTable> {
  $$LocalCustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localSalesRefs<T extends Object>(
    Expression<T> Function($$LocalSalesTableAnnotationComposer a) f,
  ) {
    final $$LocalSalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableAnnotationComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localCustomerPaymentsRefs<T extends Object>(
    Expression<T> Function($$LocalCustomerPaymentsTableAnnotationComposer a) f,
  ) {
    final $$LocalCustomerPaymentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCustomerPayments,
          getReferencedColumn: (t) => t.customerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCustomerPaymentsTableAnnotationComposer(
                $db: $db,
                $table: $db.localCustomerPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalCustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCustomersTable,
          LocalCustomer,
          $$LocalCustomersTableFilterComposer,
          $$LocalCustomersTableOrderingComposer,
          $$LocalCustomersTableAnnotationComposer,
          $$LocalCustomersTableCreateCompanionBuilder,
          $$LocalCustomersTableUpdateCompanionBuilder,
          (LocalCustomer, $$LocalCustomersTableReferences),
          LocalCustomer,
          PrefetchHooks Function({
            bool shopId,
            bool localSalesRefs,
            bool localCustomerPaymentsRefs,
          })
        > {
  $$LocalCustomersTableTableManager(
    _$AppDatabase db,
    $LocalCustomersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCustomersCompanion(
                id: id,
                shopId: shopId,
                name: name,
                email: email,
                phone: phone,
                address: address,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCustomersCompanion.insert(
                id: id,
                shopId: shopId,
                name: name,
                email: email,
                phone: phone,
                address: address,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalCustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shopId = false,
                localSalesRefs = false,
                localCustomerPaymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localSalesRefs) db.localSales,
                    if (localCustomerPaymentsRefs) db.localCustomerPayments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (shopId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shopId,
                                    referencedTable:
                                        $$LocalCustomersTableReferences
                                            ._shopIdTable(db),
                                    referencedColumn:
                                        $$LocalCustomersTableReferences
                                            ._shopIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localSalesRefs)
                        await $_getPrefetchedData<
                          LocalCustomer,
                          $LocalCustomersTable,
                          LocalSale
                        >(
                          currentTable: table,
                          referencedTable: $$LocalCustomersTableReferences
                              ._localSalesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalCustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).localSalesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localCustomerPaymentsRefs)
                        await $_getPrefetchedData<
                          LocalCustomer,
                          $LocalCustomersTable,
                          LocalCustomerPayment
                        >(
                          currentTable: table,
                          referencedTable: $$LocalCustomersTableReferences
                              ._localCustomerPaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalCustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).localCustomerPaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalCustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCustomersTable,
      LocalCustomer,
      $$LocalCustomersTableFilterComposer,
      $$LocalCustomersTableOrderingComposer,
      $$LocalCustomersTableAnnotationComposer,
      $$LocalCustomersTableCreateCompanionBuilder,
      $$LocalCustomersTableUpdateCompanionBuilder,
      (LocalCustomer, $$LocalCustomersTableReferences),
      LocalCustomer,
      PrefetchHooks Function({
        bool shopId,
        bool localSalesRefs,
        bool localCustomerPaymentsRefs,
      })
    >;
typedef $$LocalSalesTableCreateCompanionBuilder =
    LocalSalesCompanion Function({
      required String id,
      required String shopId,
      required String customerId,
      required double subtotal,
      Value<double> discount,
      Value<double> vat,
      required double total,
      Value<String> status,
      Value<String?> paymentMethod,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalSalesTableUpdateCompanionBuilder =
    LocalSalesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> customerId,
      Value<double> subtotal,
      Value<double> discount,
      Value<double> vat,
      Value<double> total,
      Value<String> status,
      Value<String?> paymentMethod,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalSalesTableReferences
    extends BaseReferences<_$AppDatabase, $LocalSalesTable, LocalSale> {
  $$LocalSalesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localSales.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalCustomersTable _customerIdTable(_$AppDatabase db) =>
      db.localCustomers.createAlias(
        $_aliasNameGenerator(db.localSales.customerId, db.localCustomers.id),
      );

  $$LocalCustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<String>('customer_id')!;

    final manager = $$LocalCustomersTableTableManager(
      $_db,
      $_db.localCustomers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LocalSaleItemsTable, List<LocalSaleItem>>
  _localSaleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localSaleItems,
    aliasName: $_aliasNameGenerator(
      db.localSales.id,
      db.localSaleItems.orderId,
    ),
  );

  $$LocalSaleItemsTableProcessedTableManager get localSaleItemsRefs {
    final manager = $$LocalSaleItemsTableTableManager(
      $_db,
      $_db.localSaleItems,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localSaleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalSaleReturnsTable, List<LocalSaleReturn>>
  _localSaleReturnsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localSaleReturns,
    aliasName: $_aliasNameGenerator(
      db.localSales.id,
      db.localSaleReturns.saleId,
    ),
  );

  $$LocalSaleReturnsTableProcessedTableManager get localSaleReturnsRefs {
    final manager = $$LocalSaleReturnsTableTableManager(
      $_db,
      $_db.localSaleReturns,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localSaleReturnsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalCustomerPaymentsTable,
    List<LocalCustomerPayment>
  >
  _localCustomerPaymentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localCustomerPayments,
        aliasName: $_aliasNameGenerator(
          db.localSales.id,
          db.localCustomerPayments.orderId,
        ),
      );

  $$LocalCustomerPaymentsTableProcessedTableManager
  get localCustomerPaymentsRefs {
    final manager = $$LocalCustomerPaymentsTableTableManager(
      $_db,
      $_db.localCustomerPayments,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localCustomerPaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalSalesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSalesTable> {
  $$LocalSalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vat => $composableBuilder(
    column: $table.vat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCustomersTableFilterComposer get customerId {
    final $$LocalCustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.localCustomers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCustomersTableFilterComposer(
            $db: $db,
            $table: $db.localCustomers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localSaleItemsRefs(
    Expression<bool> Function($$LocalSaleItemsTableFilterComposer f) f,
  ) {
    final $$LocalSaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleItems,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localSaleReturnsRefs(
    Expression<bool> Function($$LocalSaleReturnsTableFilterComposer f) f,
  ) {
    final $$LocalSaleReturnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleReturns,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleReturnsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localCustomerPaymentsRefs(
    Expression<bool> Function($$LocalCustomerPaymentsTableFilterComposer f) f,
  ) {
    final $$LocalCustomerPaymentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCustomerPayments,
          getReferencedColumn: (t) => t.orderId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCustomerPaymentsTableFilterComposer(
                $db: $db,
                $table: $db.localCustomerPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalSalesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSalesTable> {
  $$LocalSalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vat => $composableBuilder(
    column: $table.vat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCustomersTableOrderingComposer get customerId {
    final $$LocalCustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.localCustomers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCustomersTableOrderingComposer(
            $db: $db,
            $table: $db.localCustomers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSalesTable> {
  $$LocalSalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get vat =>
      $composableBuilder(column: $table.vat, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCustomersTableAnnotationComposer get customerId {
    final $$LocalCustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.localCustomers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.localCustomers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localSaleItemsRefs<T extends Object>(
    Expression<T> Function($$LocalSaleItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalSaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleItems,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.localSaleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localSaleReturnsRefs<T extends Object>(
    Expression<T> Function($$LocalSaleReturnsTableAnnotationComposer a) f,
  ) {
    final $$LocalSaleReturnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleReturns,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleReturnsTableAnnotationComposer(
            $db: $db,
            $table: $db.localSaleReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localCustomerPaymentsRefs<T extends Object>(
    Expression<T> Function($$LocalCustomerPaymentsTableAnnotationComposer a) f,
  ) {
    final $$LocalCustomerPaymentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCustomerPayments,
          getReferencedColumn: (t) => t.orderId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCustomerPaymentsTableAnnotationComposer(
                $db: $db,
                $table: $db.localCustomerPayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalSalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSalesTable,
          LocalSale,
          $$LocalSalesTableFilterComposer,
          $$LocalSalesTableOrderingComposer,
          $$LocalSalesTableAnnotationComposer,
          $$LocalSalesTableCreateCompanionBuilder,
          $$LocalSalesTableUpdateCompanionBuilder,
          (LocalSale, $$LocalSalesTableReferences),
          LocalSale,
          PrefetchHooks Function({
            bool shopId,
            bool customerId,
            bool localSaleItemsRefs,
            bool localSaleReturnsRefs,
            bool localCustomerPaymentsRefs,
          })
        > {
  $$LocalSalesTableTableManager(_$AppDatabase db, $LocalSalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> vat = const Value.absent(),
                Value<double> total = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSalesCompanion(
                id: id,
                shopId: shopId,
                customerId: customerId,
                subtotal: subtotal,
                discount: discount,
                vat: vat,
                total: total,
                status: status,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String customerId,
                required double subtotal,
                Value<double> discount = const Value.absent(),
                Value<double> vat = const Value.absent(),
                required double total,
                Value<String> status = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSalesCompanion.insert(
                id: id,
                shopId: shopId,
                customerId: customerId,
                subtotal: subtotal,
                discount: discount,
                vat: vat,
                total: total,
                status: status,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalSalesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shopId = false,
                customerId = false,
                localSaleItemsRefs = false,
                localSaleReturnsRefs = false,
                localCustomerPaymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localSaleItemsRefs) db.localSaleItems,
                    if (localSaleReturnsRefs) db.localSaleReturns,
                    if (localCustomerPaymentsRefs) db.localCustomerPayments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (shopId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shopId,
                                    referencedTable: $$LocalSalesTableReferences
                                        ._shopIdTable(db),
                                    referencedColumn:
                                        $$LocalSalesTableReferences
                                            ._shopIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable: $$LocalSalesTableReferences
                                        ._customerIdTable(db),
                                    referencedColumn:
                                        $$LocalSalesTableReferences
                                            ._customerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localSaleItemsRefs)
                        await $_getPrefetchedData<
                          LocalSale,
                          $LocalSalesTable,
                          LocalSaleItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalSalesTableReferences
                              ._localSaleItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalSalesTableReferences(
                                db,
                                table,
                                p0,
                              ).localSaleItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localSaleReturnsRefs)
                        await $_getPrefetchedData<
                          LocalSale,
                          $LocalSalesTable,
                          LocalSaleReturn
                        >(
                          currentTable: table,
                          referencedTable: $$LocalSalesTableReferences
                              ._localSaleReturnsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalSalesTableReferences(
                                db,
                                table,
                                p0,
                              ).localSaleReturnsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.saleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localCustomerPaymentsRefs)
                        await $_getPrefetchedData<
                          LocalSale,
                          $LocalSalesTable,
                          LocalCustomerPayment
                        >(
                          currentTable: table,
                          referencedTable: $$LocalSalesTableReferences
                              ._localCustomerPaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalSalesTableReferences(
                                db,
                                table,
                                p0,
                              ).localCustomerPaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalSalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSalesTable,
      LocalSale,
      $$LocalSalesTableFilterComposer,
      $$LocalSalesTableOrderingComposer,
      $$LocalSalesTableAnnotationComposer,
      $$LocalSalesTableCreateCompanionBuilder,
      $$LocalSalesTableUpdateCompanionBuilder,
      (LocalSale, $$LocalSalesTableReferences),
      LocalSale,
      PrefetchHooks Function({
        bool shopId,
        bool customerId,
        bool localSaleItemsRefs,
        bool localSaleReturnsRefs,
        bool localCustomerPaymentsRefs,
      })
    >;
typedef $$LocalSaleItemsTableCreateCompanionBuilder =
    LocalSaleItemsCompanion Function({
      required String id,
      required String shopId,
      required String orderId,
      required String productId,
      required double buyPrice,
      required double salePrice,
      Value<int> quantity,
      required double price,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalSaleItemsTableUpdateCompanionBuilder =
    LocalSaleItemsCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> orderId,
      Value<String> productId,
      Value<double> buyPrice,
      Value<double> salePrice,
      Value<int> quantity,
      Value<double> price,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalSaleItemsTableReferences
    extends BaseReferences<_$AppDatabase, $LocalSaleItemsTable, LocalSaleItem> {
  $$LocalSaleItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localSaleItems.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalSalesTable _orderIdTable(_$AppDatabase db) =>
      db.localSales.createAlias(
        $_aliasNameGenerator(db.localSaleItems.orderId, db.localSales.id),
      );

  $$LocalSalesTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$LocalSalesTableTableManager(
      $_db,
      $_db.localSales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalPurchaseItemsTable _productIdTable(_$AppDatabase db) =>
      db.localPurchaseItems.createAlias(
        $_aliasNameGenerator(
          db.localSaleItems.productId,
          db.localPurchaseItems.id,
        ),
      );

  $$LocalPurchaseItemsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$LocalPurchaseItemsTableTableManager(
      $_db,
      $_db.localPurchaseItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $LocalSaleReturnItemsTable,
    List<LocalSaleReturnItem>
  >
  _localSaleReturnItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localSaleReturnItems,
        aliasName: $_aliasNameGenerator(
          db.localSaleItems.id,
          db.localSaleReturnItems.saleItemId,
        ),
      );

  $$LocalSaleReturnItemsTableProcessedTableManager
  get localSaleReturnItemsRefs {
    final manager = $$LocalSaleReturnItemsTableTableManager(
      $_db,
      $_db.localSaleReturnItems,
    ).filter((f) => f.saleItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localSaleReturnItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalSaleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSaleItemsTable> {
  $$LocalSaleItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get buyPrice => $composableBuilder(
    column: $table.buyPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get salePrice => $composableBuilder(
    column: $table.salePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSalesTableFilterComposer get orderId {
    final $$LocalSalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableFilterComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchaseItemsTableFilterComposer get productId {
    final $$LocalPurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.localPurchaseItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.localPurchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localSaleReturnItemsRefs(
    Expression<bool> Function($$LocalSaleReturnItemsTableFilterComposer f) f,
  ) {
    final $$LocalSaleReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleReturnItems,
      getReferencedColumn: (t) => t.saleItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalSaleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSaleItemsTable> {
  $$LocalSaleItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get buyPrice => $composableBuilder(
    column: $table.buyPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get salePrice => $composableBuilder(
    column: $table.salePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSalesTableOrderingComposer get orderId {
    final $$LocalSalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableOrderingComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchaseItemsTableOrderingComposer get productId {
    final $$LocalPurchaseItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.localPurchaseItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchaseItemsTableOrderingComposer(
            $db: $db,
            $table: $db.localPurchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSaleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSaleItemsTable> {
  $$LocalSaleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get buyPrice =>
      $composableBuilder(column: $table.buyPrice, builder: (column) => column);

  GeneratedColumn<double> get salePrice =>
      $composableBuilder(column: $table.salePrice, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSalesTableAnnotationComposer get orderId {
    final $$LocalSalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableAnnotationComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchaseItemsTableAnnotationComposer get productId {
    final $$LocalPurchaseItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.productId,
          referencedTable: $db.localPurchaseItems,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalPurchaseItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.localPurchaseItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> localSaleReturnItemsRefs<T extends Object>(
    Expression<T> Function($$LocalSaleReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalSaleReturnItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localSaleReturnItems,
          getReferencedColumn: (t) => t.saleItemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalSaleReturnItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.localSaleReturnItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalSaleItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSaleItemsTable,
          LocalSaleItem,
          $$LocalSaleItemsTableFilterComposer,
          $$LocalSaleItemsTableOrderingComposer,
          $$LocalSaleItemsTableAnnotationComposer,
          $$LocalSaleItemsTableCreateCompanionBuilder,
          $$LocalSaleItemsTableUpdateCompanionBuilder,
          (LocalSaleItem, $$LocalSaleItemsTableReferences),
          LocalSaleItem,
          PrefetchHooks Function({
            bool shopId,
            bool orderId,
            bool productId,
            bool localSaleReturnItemsRefs,
          })
        > {
  $$LocalSaleItemsTableTableManager(
    _$AppDatabase db,
    $LocalSaleItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSaleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSaleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSaleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<double> buyPrice = const Value.absent(),
                Value<double> salePrice = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSaleItemsCompanion(
                id: id,
                shopId: shopId,
                orderId: orderId,
                productId: productId,
                buyPrice: buyPrice,
                salePrice: salePrice,
                quantity: quantity,
                price: price,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String orderId,
                required String productId,
                required double buyPrice,
                required double salePrice,
                Value<int> quantity = const Value.absent(),
                required double price,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSaleItemsCompanion.insert(
                id: id,
                shopId: shopId,
                orderId: orderId,
                productId: productId,
                buyPrice: buyPrice,
                salePrice: salePrice,
                quantity: quantity,
                price: price,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalSaleItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shopId = false,
                orderId = false,
                productId = false,
                localSaleReturnItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localSaleReturnItemsRefs) db.localSaleReturnItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (shopId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shopId,
                                    referencedTable:
                                        $$LocalSaleItemsTableReferences
                                            ._shopIdTable(db),
                                    referencedColumn:
                                        $$LocalSaleItemsTableReferences
                                            ._shopIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (orderId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.orderId,
                                    referencedTable:
                                        $$LocalSaleItemsTableReferences
                                            ._orderIdTable(db),
                                    referencedColumn:
                                        $$LocalSaleItemsTableReferences
                                            ._orderIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable:
                                        $$LocalSaleItemsTableReferences
                                            ._productIdTable(db),
                                    referencedColumn:
                                        $$LocalSaleItemsTableReferences
                                            ._productIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localSaleReturnItemsRefs)
                        await $_getPrefetchedData<
                          LocalSaleItem,
                          $LocalSaleItemsTable,
                          LocalSaleReturnItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalSaleItemsTableReferences
                              ._localSaleReturnItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalSaleItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).localSaleReturnItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.saleItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalSaleItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSaleItemsTable,
      LocalSaleItem,
      $$LocalSaleItemsTableFilterComposer,
      $$LocalSaleItemsTableOrderingComposer,
      $$LocalSaleItemsTableAnnotationComposer,
      $$LocalSaleItemsTableCreateCompanionBuilder,
      $$LocalSaleItemsTableUpdateCompanionBuilder,
      (LocalSaleItem, $$LocalSaleItemsTableReferences),
      LocalSaleItem,
      PrefetchHooks Function({
        bool shopId,
        bool orderId,
        bool productId,
        bool localSaleReturnItemsRefs,
      })
    >;
typedef $$LocalSaleReturnsTableCreateCompanionBuilder =
    LocalSaleReturnsCompanion Function({
      required String id,
      required String shopId,
      required String saleId,
      Value<double> subtotal,
      Value<double> restockingFee,
      Value<double> refundTotal,
      Value<String?> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalSaleReturnsTableUpdateCompanionBuilder =
    LocalSaleReturnsCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> saleId,
      Value<double> subtotal,
      Value<double> restockingFee,
      Value<double> refundTotal,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalSaleReturnsTableReferences
    extends
        BaseReferences<_$AppDatabase, $LocalSaleReturnsTable, LocalSaleReturn> {
  $$LocalSaleReturnsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localSaleReturns.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalSalesTable _saleIdTable(_$AppDatabase db) =>
      db.localSales.createAlias(
        $_aliasNameGenerator(db.localSaleReturns.saleId, db.localSales.id),
      );

  $$LocalSalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<String>('sale_id')!;

    final manager = $$LocalSalesTableTableManager(
      $_db,
      $_db.localSales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $LocalSaleReturnItemsTable,
    List<LocalSaleReturnItem>
  >
  _localSaleReturnItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localSaleReturnItems,
        aliasName: $_aliasNameGenerator(
          db.localSaleReturns.id,
          db.localSaleReturnItems.returnId,
        ),
      );

  $$LocalSaleReturnItemsTableProcessedTableManager
  get localSaleReturnItemsRefs {
    final manager = $$LocalSaleReturnItemsTableTableManager(
      $_db,
      $_db.localSaleReturnItems,
    ).filter((f) => f.returnId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localSaleReturnItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalSaleReturnsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSaleReturnsTable> {
  $$LocalSaleReturnsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get restockingFee => $composableBuilder(
    column: $table.restockingFee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refundTotal => $composableBuilder(
    column: $table.refundTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSalesTableFilterComposer get saleId {
    final $$LocalSalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableFilterComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localSaleReturnItemsRefs(
    Expression<bool> Function($$LocalSaleReturnItemsTableFilterComposer f) f,
  ) {
    final $$LocalSaleReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleReturnItems,
      getReferencedColumn: (t) => t.returnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalSaleReturnsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSaleReturnsTable> {
  $$LocalSaleReturnsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get restockingFee => $composableBuilder(
    column: $table.restockingFee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refundTotal => $composableBuilder(
    column: $table.refundTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSalesTableOrderingComposer get saleId {
    final $$LocalSalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableOrderingComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSaleReturnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSaleReturnsTable> {
  $$LocalSaleReturnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get restockingFee => $composableBuilder(
    column: $table.restockingFee,
    builder: (column) => column,
  );

  GeneratedColumn<double> get refundTotal => $composableBuilder(
    column: $table.refundTotal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSalesTableAnnotationComposer get saleId {
    final $$LocalSalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableAnnotationComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localSaleReturnItemsRefs<T extends Object>(
    Expression<T> Function($$LocalSaleReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalSaleReturnItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localSaleReturnItems,
          getReferencedColumn: (t) => t.returnId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalSaleReturnItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.localSaleReturnItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalSaleReturnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSaleReturnsTable,
          LocalSaleReturn,
          $$LocalSaleReturnsTableFilterComposer,
          $$LocalSaleReturnsTableOrderingComposer,
          $$LocalSaleReturnsTableAnnotationComposer,
          $$LocalSaleReturnsTableCreateCompanionBuilder,
          $$LocalSaleReturnsTableUpdateCompanionBuilder,
          (LocalSaleReturn, $$LocalSaleReturnsTableReferences),
          LocalSaleReturn,
          PrefetchHooks Function({
            bool shopId,
            bool saleId,
            bool localSaleReturnItemsRefs,
          })
        > {
  $$LocalSaleReturnsTableTableManager(
    _$AppDatabase db,
    $LocalSaleReturnsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSaleReturnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSaleReturnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSaleReturnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> saleId = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> restockingFee = const Value.absent(),
                Value<double> refundTotal = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSaleReturnsCompanion(
                id: id,
                shopId: shopId,
                saleId: saleId,
                subtotal: subtotal,
                restockingFee: restockingFee,
                refundTotal: refundTotal,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String saleId,
                Value<double> subtotal = const Value.absent(),
                Value<double> restockingFee = const Value.absent(),
                Value<double> refundTotal = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSaleReturnsCompanion.insert(
                id: id,
                shopId: shopId,
                saleId: saleId,
                subtotal: subtotal,
                restockingFee: restockingFee,
                refundTotal: refundTotal,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalSaleReturnsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shopId = false,
                saleId = false,
                localSaleReturnItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localSaleReturnItemsRefs) db.localSaleReturnItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (shopId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shopId,
                                    referencedTable:
                                        $$LocalSaleReturnsTableReferences
                                            ._shopIdTable(db),
                                    referencedColumn:
                                        $$LocalSaleReturnsTableReferences
                                            ._shopIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (saleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.saleId,
                                    referencedTable:
                                        $$LocalSaleReturnsTableReferences
                                            ._saleIdTable(db),
                                    referencedColumn:
                                        $$LocalSaleReturnsTableReferences
                                            ._saleIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localSaleReturnItemsRefs)
                        await $_getPrefetchedData<
                          LocalSaleReturn,
                          $LocalSaleReturnsTable,
                          LocalSaleReturnItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalSaleReturnsTableReferences
                              ._localSaleReturnItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalSaleReturnsTableReferences(
                                db,
                                table,
                                p0,
                              ).localSaleReturnItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.returnId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalSaleReturnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSaleReturnsTable,
      LocalSaleReturn,
      $$LocalSaleReturnsTableFilterComposer,
      $$LocalSaleReturnsTableOrderingComposer,
      $$LocalSaleReturnsTableAnnotationComposer,
      $$LocalSaleReturnsTableCreateCompanionBuilder,
      $$LocalSaleReturnsTableUpdateCompanionBuilder,
      (LocalSaleReturn, $$LocalSaleReturnsTableReferences),
      LocalSaleReturn,
      PrefetchHooks Function({
        bool shopId,
        bool saleId,
        bool localSaleReturnItemsRefs,
      })
    >;
typedef $$LocalSaleReturnItemsTableCreateCompanionBuilder =
    LocalSaleReturnItemsCompanion Function({
      required String id,
      required String shopId,
      required String returnId,
      required String saleItemId,
      required String productId,
      required String productName,
      Value<double> salePrice,
      Value<int> quantity,
      Value<String?> reason,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalSaleReturnItemsTableUpdateCompanionBuilder =
    LocalSaleReturnItemsCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> returnId,
      Value<String> saleItemId,
      Value<String> productId,
      Value<String> productName,
      Value<double> salePrice,
      Value<int> quantity,
      Value<String?> reason,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalSaleReturnItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalSaleReturnItemsTable,
          LocalSaleReturnItem
        > {
  $$LocalSaleReturnItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localSaleReturnItems.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalSaleReturnsTable _returnIdTable(_$AppDatabase db) =>
      db.localSaleReturns.createAlias(
        $_aliasNameGenerator(
          db.localSaleReturnItems.returnId,
          db.localSaleReturns.id,
        ),
      );

  $$LocalSaleReturnsTableProcessedTableManager get returnId {
    final $_column = $_itemColumn<String>('return_id')!;

    final manager = $$LocalSaleReturnsTableTableManager(
      $_db,
      $_db.localSaleReturns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_returnIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalSaleItemsTable _saleItemIdTable(_$AppDatabase db) =>
      db.localSaleItems.createAlias(
        $_aliasNameGenerator(
          db.localSaleReturnItems.saleItemId,
          db.localSaleItems.id,
        ),
      );

  $$LocalSaleItemsTableProcessedTableManager get saleItemId {
    final $_column = $_itemColumn<String>('sale_item_id')!;

    final manager = $$LocalSaleItemsTableTableManager(
      $_db,
      $_db.localSaleItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalPurchaseItemsTable _productIdTable(_$AppDatabase db) =>
      db.localPurchaseItems.createAlias(
        $_aliasNameGenerator(
          db.localSaleReturnItems.productId,
          db.localPurchaseItems.id,
        ),
      );

  $$LocalPurchaseItemsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$LocalPurchaseItemsTableTableManager(
      $_db,
      $_db.localPurchaseItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalSaleReturnItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSaleReturnItemsTable> {
  $$LocalSaleReturnItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get salePrice => $composableBuilder(
    column: $table.salePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSaleReturnsTableFilterComposer get returnId {
    final $$LocalSaleReturnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.localSaleReturns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleReturnsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSaleItemsTableFilterComposer get saleItemId {
    final $$LocalSaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleItemId,
      referencedTable: $db.localSaleItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchaseItemsTableFilterComposer get productId {
    final $$LocalPurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.localPurchaseItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.localPurchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSaleReturnItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSaleReturnItemsTable> {
  $$LocalSaleReturnItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get salePrice => $composableBuilder(
    column: $table.salePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSaleReturnsTableOrderingComposer get returnId {
    final $$LocalSaleReturnsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.localSaleReturns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleReturnsTableOrderingComposer(
            $db: $db,
            $table: $db.localSaleReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSaleItemsTableOrderingComposer get saleItemId {
    final $$LocalSaleItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleItemId,
      referencedTable: $db.localSaleItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleItemsTableOrderingComposer(
            $db: $db,
            $table: $db.localSaleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchaseItemsTableOrderingComposer get productId {
    final $$LocalPurchaseItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.localPurchaseItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPurchaseItemsTableOrderingComposer(
            $db: $db,
            $table: $db.localPurchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSaleReturnItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSaleReturnItemsTable> {
  $$LocalSaleReturnItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get salePrice =>
      $composableBuilder(column: $table.salePrice, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSaleReturnsTableAnnotationComposer get returnId {
    final $$LocalSaleReturnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.localSaleReturns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleReturnsTableAnnotationComposer(
            $db: $db,
            $table: $db.localSaleReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSaleItemsTableAnnotationComposer get saleItemId {
    final $$LocalSaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleItemId,
      referencedTable: $db.localSaleItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.localSaleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalPurchaseItemsTableAnnotationComposer get productId {
    final $$LocalPurchaseItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.productId,
          referencedTable: $db.localPurchaseItems,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalPurchaseItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.localPurchaseItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LocalSaleReturnItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSaleReturnItemsTable,
          LocalSaleReturnItem,
          $$LocalSaleReturnItemsTableFilterComposer,
          $$LocalSaleReturnItemsTableOrderingComposer,
          $$LocalSaleReturnItemsTableAnnotationComposer,
          $$LocalSaleReturnItemsTableCreateCompanionBuilder,
          $$LocalSaleReturnItemsTableUpdateCompanionBuilder,
          (LocalSaleReturnItem, $$LocalSaleReturnItemsTableReferences),
          LocalSaleReturnItem,
          PrefetchHooks Function({
            bool shopId,
            bool returnId,
            bool saleItemId,
            bool productId,
          })
        > {
  $$LocalSaleReturnItemsTableTableManager(
    _$AppDatabase db,
    $LocalSaleReturnItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSaleReturnItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSaleReturnItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalSaleReturnItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> returnId = const Value.absent(),
                Value<String> saleItemId = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<double> salePrice = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSaleReturnItemsCompanion(
                id: id,
                shopId: shopId,
                returnId: returnId,
                saleItemId: saleItemId,
                productId: productId,
                productName: productName,
                salePrice: salePrice,
                quantity: quantity,
                reason: reason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String returnId,
                required String saleItemId,
                required String productId,
                required String productName,
                Value<double> salePrice = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSaleReturnItemsCompanion.insert(
                id: id,
                shopId: shopId,
                returnId: returnId,
                saleItemId: saleItemId,
                productId: productId,
                productName: productName,
                salePrice: salePrice,
                quantity: quantity,
                reason: reason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalSaleReturnItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                shopId = false,
                returnId = false,
                saleItemId = false,
                productId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (shopId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shopId,
                                    referencedTable:
                                        $$LocalSaleReturnItemsTableReferences
                                            ._shopIdTable(db),
                                    referencedColumn:
                                        $$LocalSaleReturnItemsTableReferences
                                            ._shopIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (returnId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.returnId,
                                    referencedTable:
                                        $$LocalSaleReturnItemsTableReferences
                                            ._returnIdTable(db),
                                    referencedColumn:
                                        $$LocalSaleReturnItemsTableReferences
                                            ._returnIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (saleItemId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.saleItemId,
                                    referencedTable:
                                        $$LocalSaleReturnItemsTableReferences
                                            ._saleItemIdTable(db),
                                    referencedColumn:
                                        $$LocalSaleReturnItemsTableReferences
                                            ._saleItemIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable:
                                        $$LocalSaleReturnItemsTableReferences
                                            ._productIdTable(db),
                                    referencedColumn:
                                        $$LocalSaleReturnItemsTableReferences
                                            ._productIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$LocalSaleReturnItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSaleReturnItemsTable,
      LocalSaleReturnItem,
      $$LocalSaleReturnItemsTableFilterComposer,
      $$LocalSaleReturnItemsTableOrderingComposer,
      $$LocalSaleReturnItemsTableAnnotationComposer,
      $$LocalSaleReturnItemsTableCreateCompanionBuilder,
      $$LocalSaleReturnItemsTableUpdateCompanionBuilder,
      (LocalSaleReturnItem, $$LocalSaleReturnItemsTableReferences),
      LocalSaleReturnItem,
      PrefetchHooks Function({
        bool shopId,
        bool returnId,
        bool saleItemId,
        bool productId,
      })
    >;
typedef $$LocalCustomerPaymentsTableCreateCompanionBuilder =
    LocalCustomerPaymentsCompanion Function({
      required String id,
      required String shopId,
      required String customerId,
      required String orderId,
      required double payments,
      Value<String?> description,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalCustomerPaymentsTableUpdateCompanionBuilder =
    LocalCustomerPaymentsCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> customerId,
      Value<String> orderId,
      Value<double> payments,
      Value<String?> description,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalCustomerPaymentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalCustomerPaymentsTable,
          LocalCustomerPayment
        > {
  $$LocalCustomerPaymentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localCustomerPayments.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalCustomersTable _customerIdTable(_$AppDatabase db) =>
      db.localCustomers.createAlias(
        $_aliasNameGenerator(
          db.localCustomerPayments.customerId,
          db.localCustomers.id,
        ),
      );

  $$LocalCustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<String>('customer_id')!;

    final manager = $$LocalCustomersTableTableManager(
      $_db,
      $_db.localCustomers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalSalesTable _orderIdTable(_$AppDatabase db) =>
      db.localSales.createAlias(
        $_aliasNameGenerator(
          db.localCustomerPayments.orderId,
          db.localSales.id,
        ),
      );

  $$LocalSalesTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$LocalSalesTableTableManager(
      $_db,
      $_db.localSales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalCustomerPaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCustomerPaymentsTable> {
  $$LocalCustomerPaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get payments => $composableBuilder(
    column: $table.payments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCustomersTableFilterComposer get customerId {
    final $$LocalCustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.localCustomers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCustomersTableFilterComposer(
            $db: $db,
            $table: $db.localCustomers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSalesTableFilterComposer get orderId {
    final $$LocalSalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableFilterComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCustomerPaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCustomerPaymentsTable> {
  $$LocalCustomerPaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get payments => $composableBuilder(
    column: $table.payments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCustomersTableOrderingComposer get customerId {
    final $$LocalCustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.localCustomers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCustomersTableOrderingComposer(
            $db: $db,
            $table: $db.localCustomers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSalesTableOrderingComposer get orderId {
    final $$LocalSalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableOrderingComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCustomerPaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCustomerPaymentsTable> {
  $$LocalCustomerPaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get payments =>
      $composableBuilder(column: $table.payments, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCustomersTableAnnotationComposer get customerId {
    final $$LocalCustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.localCustomers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.localCustomers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalSalesTableAnnotationComposer get orderId {
    final $$LocalSalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableAnnotationComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCustomerPaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCustomerPaymentsTable,
          LocalCustomerPayment,
          $$LocalCustomerPaymentsTableFilterComposer,
          $$LocalCustomerPaymentsTableOrderingComposer,
          $$LocalCustomerPaymentsTableAnnotationComposer,
          $$LocalCustomerPaymentsTableCreateCompanionBuilder,
          $$LocalCustomerPaymentsTableUpdateCompanionBuilder,
          (LocalCustomerPayment, $$LocalCustomerPaymentsTableReferences),
          LocalCustomerPayment,
          PrefetchHooks Function({bool shopId, bool customerId, bool orderId})
        > {
  $$LocalCustomerPaymentsTableTableManager(
    _$AppDatabase db,
    $LocalCustomerPaymentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCustomerPaymentsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalCustomerPaymentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalCustomerPaymentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<double> payments = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCustomerPaymentsCompanion(
                id: id,
                shopId: shopId,
                customerId: customerId,
                orderId: orderId,
                payments: payments,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String customerId,
                required String orderId,
                required double payments,
                Value<String?> description = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCustomerPaymentsCompanion.insert(
                id: id,
                shopId: shopId,
                customerId: customerId,
                orderId: orderId,
                payments: payments,
                description: description,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalCustomerPaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({shopId = false, customerId = false, orderId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (shopId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.shopId,
                                    referencedTable:
                                        $$LocalCustomerPaymentsTableReferences
                                            ._shopIdTable(db),
                                    referencedColumn:
                                        $$LocalCustomerPaymentsTableReferences
                                            ._shopIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable:
                                        $$LocalCustomerPaymentsTableReferences
                                            ._customerIdTable(db),
                                    referencedColumn:
                                        $$LocalCustomerPaymentsTableReferences
                                            ._customerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (orderId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.orderId,
                                    referencedTable:
                                        $$LocalCustomerPaymentsTableReferences
                                            ._orderIdTable(db),
                                    referencedColumn:
                                        $$LocalCustomerPaymentsTableReferences
                                            ._orderIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$LocalCustomerPaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCustomerPaymentsTable,
      LocalCustomerPayment,
      $$LocalCustomerPaymentsTableFilterComposer,
      $$LocalCustomerPaymentsTableOrderingComposer,
      $$LocalCustomerPaymentsTableAnnotationComposer,
      $$LocalCustomerPaymentsTableCreateCompanionBuilder,
      $$LocalCustomerPaymentsTableUpdateCompanionBuilder,
      (LocalCustomerPayment, $$LocalCustomerPaymentsTableReferences),
      LocalCustomerPayment,
      PrefetchHooks Function({bool shopId, bool customerId, bool orderId})
    >;
typedef $$LocalCashTransactionsTableCreateCompanionBuilder =
    LocalCashTransactionsCompanion Function({
      required String id,
      required String shopId,
      required String type,
      required String direction,
      Value<double> amount,
      Value<String?> referenceId,
      Value<String?> referenceType,
      Value<String?> method,
      Value<String?> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalCashTransactionsTableUpdateCompanionBuilder =
    LocalCashTransactionsCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> type,
      Value<String> direction,
      Value<double> amount,
      Value<String?> referenceId,
      Value<String?> referenceType,
      Value<String?> method,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalCashTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalCashTransactionsTable,
          LocalCashTransaction
        > {
  $$LocalCashTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localCashTransactions.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalCashTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCashTransactionsTable> {
  $$LocalCashTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCashTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCashTransactionsTable> {
  $$LocalCashTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCashTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCashTransactionsTable> {
  $$LocalCashTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCashTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCashTransactionsTable,
          LocalCashTransaction,
          $$LocalCashTransactionsTableFilterComposer,
          $$LocalCashTransactionsTableOrderingComposer,
          $$LocalCashTransactionsTableAnnotationComposer,
          $$LocalCashTransactionsTableCreateCompanionBuilder,
          $$LocalCashTransactionsTableUpdateCompanionBuilder,
          (LocalCashTransaction, $$LocalCashTransactionsTableReferences),
          LocalCashTransaction,
          PrefetchHooks Function({bool shopId})
        > {
  $$LocalCashTransactionsTableTableManager(
    _$AppDatabase db,
    $LocalCashTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCashTransactionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalCashTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalCashTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<String?> method = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCashTransactionsCompanion(
                id: id,
                shopId: shopId,
                type: type,
                direction: direction,
                amount: amount,
                referenceId: referenceId,
                referenceType: referenceType,
                method: method,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String type,
                required String direction,
                Value<double> amount = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<String?> method = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCashTransactionsCompanion.insert(
                id: id,
                shopId: shopId,
                type: type,
                direction: direction,
                amount: amount,
                referenceId: referenceId,
                referenceType: referenceType,
                method: method,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalCashTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shopId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (shopId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.shopId,
                                referencedTable:
                                    $$LocalCashTransactionsTableReferences
                                        ._shopIdTable(db),
                                referencedColumn:
                                    $$LocalCashTransactionsTableReferences
                                        ._shopIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalCashTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCashTransactionsTable,
      LocalCashTransaction,
      $$LocalCashTransactionsTableFilterComposer,
      $$LocalCashTransactionsTableOrderingComposer,
      $$LocalCashTransactionsTableAnnotationComposer,
      $$LocalCashTransactionsTableCreateCompanionBuilder,
      $$LocalCashTransactionsTableUpdateCompanionBuilder,
      (LocalCashTransaction, $$LocalCashTransactionsTableReferences),
      LocalCashTransaction,
      PrefetchHooks Function({bool shopId})
    >;
typedef $$LocalExpensesTableCreateCompanionBuilder =
    LocalExpensesCompanion Function({
      required String id,
      required String shopId,
      required String categoryId,
      Value<double> amount,
      Value<String?> reason,
      Value<String?> note,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalExpensesTableUpdateCompanionBuilder =
    LocalExpensesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> categoryId,
      Value<double> amount,
      Value<String?> reason,
      Value<String?> note,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $LocalExpensesTable, LocalExpense> {
  $$LocalExpensesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localExpenses.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.localCategories.createAlias(
        $_aliasNameGenerator(
          db.localExpenses.categoryId,
          db.localCategories.id,
        ),
      );

  $$LocalCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$LocalCategoriesTableTableManager(
      $_db,
      $_db.localCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalExpensesTable> {
  $$LocalExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCategoriesTableFilterComposer get categoryId {
    final $$LocalCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.localCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.localCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalExpensesTable> {
  $$LocalExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCategoriesTableOrderingComposer get categoryId {
    final $$LocalCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.localCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.localCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalExpensesTable> {
  $$LocalExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCategoriesTableAnnotationComposer get categoryId {
    final $$LocalCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.localCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.localCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalExpensesTable,
          LocalExpense,
          $$LocalExpensesTableFilterComposer,
          $$LocalExpensesTableOrderingComposer,
          $$LocalExpensesTableAnnotationComposer,
          $$LocalExpensesTableCreateCompanionBuilder,
          $$LocalExpensesTableUpdateCompanionBuilder,
          (LocalExpense, $$LocalExpensesTableReferences),
          LocalExpense,
          PrefetchHooks Function({bool shopId, bool categoryId})
        > {
  $$LocalExpensesTableTableManager(_$AppDatabase db, $LocalExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalExpensesCompanion(
                id: id,
                shopId: shopId,
                categoryId: categoryId,
                amount: amount,
                reason: reason,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String categoryId,
                Value<double> amount = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalExpensesCompanion.insert(
                id: id,
                shopId: shopId,
                categoryId: categoryId,
                amount: amount,
                reason: reason,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shopId = false, categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (shopId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.shopId,
                                referencedTable: $$LocalExpensesTableReferences
                                    ._shopIdTable(db),
                                referencedColumn: $$LocalExpensesTableReferences
                                    ._shopIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable: $$LocalExpensesTableReferences
                                    ._categoryIdTable(db),
                                referencedColumn: $$LocalExpensesTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalExpensesTable,
      LocalExpense,
      $$LocalExpensesTableFilterComposer,
      $$LocalExpensesTableOrderingComposer,
      $$LocalExpensesTableAnnotationComposer,
      $$LocalExpensesTableCreateCompanionBuilder,
      $$LocalExpensesTableUpdateCompanionBuilder,
      (LocalExpense, $$LocalExpensesTableReferences),
      LocalExpense,
      PrefetchHooks Function({bool shopId, bool categoryId})
    >;
typedef $$LocalIncomesTableCreateCompanionBuilder =
    LocalIncomesCompanion Function({
      required String id,
      required String shopId,
      required String categoryId,
      Value<double> amount,
      Value<String?> reason,
      Value<String?> note,
      Value<String?> receiptUrl,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalIncomesTableUpdateCompanionBuilder =
    LocalIncomesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> categoryId,
      Value<double> amount,
      Value<String?> reason,
      Value<String?> note,
      Value<String?> receiptUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalIncomesTableReferences
    extends BaseReferences<_$AppDatabase, $LocalIncomesTable, LocalIncome> {
  $$LocalIncomesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localIncomes.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.localCategories.createAlias(
        $_aliasNameGenerator(db.localIncomes.categoryId, db.localCategories.id),
      );

  $$LocalCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$LocalCategoriesTableTableManager(
      $_db,
      $_db.localCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalIncomesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalIncomesTable> {
  $$LocalIncomesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptUrl => $composableBuilder(
    column: $table.receiptUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCategoriesTableFilterComposer get categoryId {
    final $$LocalCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.localCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.localCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalIncomesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalIncomesTable> {
  $$LocalIncomesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptUrl => $composableBuilder(
    column: $table.receiptUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCategoriesTableOrderingComposer get categoryId {
    final $$LocalCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.localCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.localCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalIncomesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalIncomesTable> {
  $$LocalIncomesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get receiptUrl => $composableBuilder(
    column: $table.receiptUrl,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalCategoriesTableAnnotationComposer get categoryId {
    final $$LocalCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.localCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.localCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalIncomesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalIncomesTable,
          LocalIncome,
          $$LocalIncomesTableFilterComposer,
          $$LocalIncomesTableOrderingComposer,
          $$LocalIncomesTableAnnotationComposer,
          $$LocalIncomesTableCreateCompanionBuilder,
          $$LocalIncomesTableUpdateCompanionBuilder,
          (LocalIncome, $$LocalIncomesTableReferences),
          LocalIncome,
          PrefetchHooks Function({bool shopId, bool categoryId})
        > {
  $$LocalIncomesTableTableManager(_$AppDatabase db, $LocalIncomesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalIncomesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalIncomesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalIncomesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> receiptUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalIncomesCompanion(
                id: id,
                shopId: shopId,
                categoryId: categoryId,
                amount: amount,
                reason: reason,
                note: note,
                receiptUrl: receiptUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String categoryId,
                Value<double> amount = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> receiptUrl = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalIncomesCompanion.insert(
                id: id,
                shopId: shopId,
                categoryId: categoryId,
                amount: amount,
                reason: reason,
                note: note,
                receiptUrl: receiptUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalIncomesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shopId = false, categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (shopId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.shopId,
                                referencedTable: $$LocalIncomesTableReferences
                                    ._shopIdTable(db),
                                referencedColumn: $$LocalIncomesTableReferences
                                    ._shopIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable: $$LocalIncomesTableReferences
                                    ._categoryIdTable(db),
                                referencedColumn: $$LocalIncomesTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalIncomesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalIncomesTable,
      LocalIncome,
      $$LocalIncomesTableFilterComposer,
      $$LocalIncomesTableOrderingComposer,
      $$LocalIncomesTableAnnotationComposer,
      $$LocalIncomesTableCreateCompanionBuilder,
      $$LocalIncomesTableUpdateCompanionBuilder,
      (LocalIncome, $$LocalIncomesTableReferences),
      LocalIncome,
      PrefetchHooks Function({bool shopId, bool categoryId})
    >;
typedef $$LocalRecycleBinEntriesTableCreateCompanionBuilder =
    LocalRecycleBinEntriesCompanion Function({
      required String id,
      required String shopId,
      required String sourceTableName,
      required String recordId,
      required String displayTitle,
      Value<String?> displaySubtitle,
      required String deletedData,
      Value<String?> relatedData,
      Value<String?> deletedByUserId,
      required DateTime deletedAt,
      Value<DateTime?> restoredAt,
      Value<String> restoreStatus,
      Value<String?> restoreBlockReason,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalRecycleBinEntriesTableUpdateCompanionBuilder =
    LocalRecycleBinEntriesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> sourceTableName,
      Value<String> recordId,
      Value<String> displayTitle,
      Value<String?> displaySubtitle,
      Value<String> deletedData,
      Value<String?> relatedData,
      Value<String?> deletedByUserId,
      Value<DateTime> deletedAt,
      Value<DateTime?> restoredAt,
      Value<String> restoreStatus,
      Value<String?> restoreBlockReason,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalRecycleBinEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalRecycleBinEntriesTable,
          LocalRecycleBinEntry
        > {
  $$LocalRecycleBinEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(
          db.localRecycleBinEntries.shopId,
          db.localShops.id,
        ),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalUsersTable _deletedByUserIdTable(_$AppDatabase db) =>
      db.localUsers.createAlias(
        $_aliasNameGenerator(
          db.localRecycleBinEntries.deletedByUserId,
          db.localUsers.id,
        ),
      );

  $$LocalUsersTableProcessedTableManager? get deletedByUserId {
    final $_column = $_itemColumn<String>('deleted_by_user_id');
    if ($_column == null) return null;
    final manager = $$LocalUsersTableTableManager(
      $_db,
      $_db.localUsers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_deletedByUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalRecycleBinEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalRecycleBinEntriesTable> {
  $$LocalRecycleBinEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceTableName => $composableBuilder(
    column: $table.sourceTableName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displaySubtitle => $composableBuilder(
    column: $table.displaySubtitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedData => $composableBuilder(
    column: $table.deletedData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relatedData => $composableBuilder(
    column: $table.relatedData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get restoredAt => $composableBuilder(
    column: $table.restoredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get restoreStatus => $composableBuilder(
    column: $table.restoreStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get restoreBlockReason => $composableBuilder(
    column: $table.restoreBlockReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalUsersTableFilterComposer get deletedByUserId {
    final $$LocalUsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deletedByUserId,
      referencedTable: $db.localUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUsersTableFilterComposer(
            $db: $db,
            $table: $db.localUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalRecycleBinEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalRecycleBinEntriesTable> {
  $$LocalRecycleBinEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceTableName => $composableBuilder(
    column: $table.sourceTableName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displaySubtitle => $composableBuilder(
    column: $table.displaySubtitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedData => $composableBuilder(
    column: $table.deletedData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedData => $composableBuilder(
    column: $table.relatedData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get restoredAt => $composableBuilder(
    column: $table.restoredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get restoreStatus => $composableBuilder(
    column: $table.restoreStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get restoreBlockReason => $composableBuilder(
    column: $table.restoreBlockReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalUsersTableOrderingComposer get deletedByUserId {
    final $$LocalUsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deletedByUserId,
      referencedTable: $db.localUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUsersTableOrderingComposer(
            $db: $db,
            $table: $db.localUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalRecycleBinEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalRecycleBinEntriesTable> {
  $$LocalRecycleBinEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceTableName => $composableBuilder(
    column: $table.sourceTableName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get displayTitle => $composableBuilder(
    column: $table.displayTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displaySubtitle => $composableBuilder(
    column: $table.displaySubtitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deletedData => $composableBuilder(
    column: $table.deletedData,
    builder: (column) => column,
  );

  GeneratedColumn<String> get relatedData => $composableBuilder(
    column: $table.relatedData,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get restoredAt => $composableBuilder(
    column: $table.restoredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get restoreStatus => $composableBuilder(
    column: $table.restoreStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get restoreBlockReason => $composableBuilder(
    column: $table.restoreBlockReason,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalUsersTableAnnotationComposer get deletedByUserId {
    final $$LocalUsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.deletedByUserId,
      referencedTable: $db.localUsers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalUsersTableAnnotationComposer(
            $db: $db,
            $table: $db.localUsers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalRecycleBinEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalRecycleBinEntriesTable,
          LocalRecycleBinEntry,
          $$LocalRecycleBinEntriesTableFilterComposer,
          $$LocalRecycleBinEntriesTableOrderingComposer,
          $$LocalRecycleBinEntriesTableAnnotationComposer,
          $$LocalRecycleBinEntriesTableCreateCompanionBuilder,
          $$LocalRecycleBinEntriesTableUpdateCompanionBuilder,
          (LocalRecycleBinEntry, $$LocalRecycleBinEntriesTableReferences),
          LocalRecycleBinEntry,
          PrefetchHooks Function({bool shopId, bool deletedByUserId})
        > {
  $$LocalRecycleBinEntriesTableTableManager(
    _$AppDatabase db,
    $LocalRecycleBinEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalRecycleBinEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalRecycleBinEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalRecycleBinEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> sourceTableName = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<String> displayTitle = const Value.absent(),
                Value<String?> displaySubtitle = const Value.absent(),
                Value<String> deletedData = const Value.absent(),
                Value<String?> relatedData = const Value.absent(),
                Value<String?> deletedByUserId = const Value.absent(),
                Value<DateTime> deletedAt = const Value.absent(),
                Value<DateTime?> restoredAt = const Value.absent(),
                Value<String> restoreStatus = const Value.absent(),
                Value<String?> restoreBlockReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalRecycleBinEntriesCompanion(
                id: id,
                shopId: shopId,
                sourceTableName: sourceTableName,
                recordId: recordId,
                displayTitle: displayTitle,
                displaySubtitle: displaySubtitle,
                deletedData: deletedData,
                relatedData: relatedData,
                deletedByUserId: deletedByUserId,
                deletedAt: deletedAt,
                restoredAt: restoredAt,
                restoreStatus: restoreStatus,
                restoreBlockReason: restoreBlockReason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String sourceTableName,
                required String recordId,
                required String displayTitle,
                Value<String?> displaySubtitle = const Value.absent(),
                required String deletedData,
                Value<String?> relatedData = const Value.absent(),
                Value<String?> deletedByUserId = const Value.absent(),
                required DateTime deletedAt,
                Value<DateTime?> restoredAt = const Value.absent(),
                Value<String> restoreStatus = const Value.absent(),
                Value<String?> restoreBlockReason = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalRecycleBinEntriesCompanion.insert(
                id: id,
                shopId: shopId,
                sourceTableName: sourceTableName,
                recordId: recordId,
                displayTitle: displayTitle,
                displaySubtitle: displaySubtitle,
                deletedData: deletedData,
                relatedData: relatedData,
                deletedByUserId: deletedByUserId,
                deletedAt: deletedAt,
                restoredAt: restoredAt,
                restoreStatus: restoreStatus,
                restoreBlockReason: restoreBlockReason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalRecycleBinEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shopId = false, deletedByUserId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (shopId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.shopId,
                                referencedTable:
                                    $$LocalRecycleBinEntriesTableReferences
                                        ._shopIdTable(db),
                                referencedColumn:
                                    $$LocalRecycleBinEntriesTableReferences
                                        ._shopIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (deletedByUserId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.deletedByUserId,
                                referencedTable:
                                    $$LocalRecycleBinEntriesTableReferences
                                        ._deletedByUserIdTable(db),
                                referencedColumn:
                                    $$LocalRecycleBinEntriesTableReferences
                                        ._deletedByUserIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalRecycleBinEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalRecycleBinEntriesTable,
      LocalRecycleBinEntry,
      $$LocalRecycleBinEntriesTableFilterComposer,
      $$LocalRecycleBinEntriesTableOrderingComposer,
      $$LocalRecycleBinEntriesTableAnnotationComposer,
      $$LocalRecycleBinEntriesTableCreateCompanionBuilder,
      $$LocalRecycleBinEntriesTableUpdateCompanionBuilder,
      (LocalRecycleBinEntry, $$LocalRecycleBinEntriesTableReferences),
      LocalRecycleBinEntry,
      PrefetchHooks Function({bool shopId, bool deletedByUserId})
    >;
typedef $$LocalNotesTableCreateCompanionBuilder =
    LocalNotesCompanion Function({
      required String id,
      required String shopId,
      Value<String> title,
      Value<String> body,
      Value<bool> isArchived,
      Value<DateTime?> archivedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$LocalNotesTableUpdateCompanionBuilder =
    LocalNotesCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> title,
      Value<String> body,
      Value<bool> isArchived,
      Value<DateTime?> archivedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

final class $$LocalNotesTableReferences
    extends BaseReferences<_$AppDatabase, $LocalNotesTable, LocalNote> {
  $$LocalNotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalShopsTable _shopIdTable(_$AppDatabase db) =>
      db.localShops.createAlias(
        $_aliasNameGenerator(db.localNotes.shopId, db.localShops.id),
      );

  $$LocalShopsTableProcessedTableManager get shopId {
    final $_column = $_itemColumn<String>('shop_id')!;

    final manager = $$LocalShopsTableTableManager(
      $_db,
      $_db.localShops,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shopIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalNotesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalNotesTable> {
  $$LocalNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalShopsTableFilterComposer get shopId {
    final $$LocalShopsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableFilterComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalNotesTable> {
  $$LocalNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalShopsTableOrderingComposer get shopId {
    final $$LocalShopsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableOrderingComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalNotesTable> {
  $$LocalNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  $$LocalShopsTableAnnotationComposer get shopId {
    final $$LocalShopsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shopId,
      referencedTable: $db.localShops,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalShopsTableAnnotationComposer(
            $db: $db,
            $table: $db.localShops,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalNotesTable,
          LocalNote,
          $$LocalNotesTableFilterComposer,
          $$LocalNotesTableOrderingComposer,
          $$LocalNotesTableAnnotationComposer,
          $$LocalNotesTableCreateCompanionBuilder,
          $$LocalNotesTableUpdateCompanionBuilder,
          (LocalNote, $$LocalNotesTableReferences),
          LocalNote,
          PrefetchHooks Function({bool shopId})
        > {
  $$LocalNotesTableTableManager(_$AppDatabase db, $LocalNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalNotesCompanion(
                id: id,
                shopId: shopId,
                title: title,
                body: body,
                isArchived: isArchived,
                archivedAt: archivedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalNotesCompanion.insert(
                id: id,
                shopId: shopId,
                title: title,
                body: body,
                isArchived: isArchived,
                archivedAt: archivedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalNotesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shopId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (shopId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.shopId,
                                referencedTable: $$LocalNotesTableReferences
                                    ._shopIdTable(db),
                                referencedColumn: $$LocalNotesTableReferences
                                    ._shopIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalNotesTable,
      LocalNote,
      $$LocalNotesTableFilterComposer,
      $$LocalNotesTableOrderingComposer,
      $$LocalNotesTableAnnotationComposer,
      $$LocalNotesTableCreateCompanionBuilder,
      $$LocalNotesTableUpdateCompanionBuilder,
      (LocalNote, $$LocalNotesTableReferences),
      LocalNote,
      PrefetchHooks Function({bool shopId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalShopsTableTableManager get localShops =>
      $$LocalShopsTableTableManager(_db, _db.localShops);
  $$LocalUsersTableTableManager get localUsers =>
      $$LocalUsersTableTableManager(_db, _db.localUsers);
  $$LocalCategoriesTableTableManager get localCategories =>
      $$LocalCategoriesTableTableManager(_db, _db.localCategories);
  $$LocalSuppliersTableTableManager get localSuppliers =>
      $$LocalSuppliersTableTableManager(_db, _db.localSuppliers);
  $$LocalPurchasesTableTableManager get localPurchases =>
      $$LocalPurchasesTableTableManager(_db, _db.localPurchases);
  $$LocalPurchaseItemsTableTableManager get localPurchaseItems =>
      $$LocalPurchaseItemsTableTableManager(_db, _db.localPurchaseItems);
  $$LocalPurchasePaymentsTableTableManager get localPurchasePayments =>
      $$LocalPurchasePaymentsTableTableManager(_db, _db.localPurchasePayments);
  $$LocalCustomersTableTableManager get localCustomers =>
      $$LocalCustomersTableTableManager(_db, _db.localCustomers);
  $$LocalSalesTableTableManager get localSales =>
      $$LocalSalesTableTableManager(_db, _db.localSales);
  $$LocalSaleItemsTableTableManager get localSaleItems =>
      $$LocalSaleItemsTableTableManager(_db, _db.localSaleItems);
  $$LocalSaleReturnsTableTableManager get localSaleReturns =>
      $$LocalSaleReturnsTableTableManager(_db, _db.localSaleReturns);
  $$LocalSaleReturnItemsTableTableManager get localSaleReturnItems =>
      $$LocalSaleReturnItemsTableTableManager(_db, _db.localSaleReturnItems);
  $$LocalCustomerPaymentsTableTableManager get localCustomerPayments =>
      $$LocalCustomerPaymentsTableTableManager(_db, _db.localCustomerPayments);
  $$LocalCashTransactionsTableTableManager get localCashTransactions =>
      $$LocalCashTransactionsTableTableManager(_db, _db.localCashTransactions);
  $$LocalExpensesTableTableManager get localExpenses =>
      $$LocalExpensesTableTableManager(_db, _db.localExpenses);
  $$LocalIncomesTableTableManager get localIncomes =>
      $$LocalIncomesTableTableManager(_db, _db.localIncomes);
  $$LocalRecycleBinEntriesTableTableManager get localRecycleBinEntries =>
      $$LocalRecycleBinEntriesTableTableManager(
        _db,
        _db.localRecycleBinEntries,
      );
  $$LocalNotesTableTableManager get localNotes =>
      $$LocalNotesTableTableManager(_db, _db.localNotes);
}
