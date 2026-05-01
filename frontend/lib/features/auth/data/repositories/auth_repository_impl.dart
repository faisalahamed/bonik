import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, [this._database]);

  final AuthRemoteDataSource _remoteDataSource;
  final AppDatabase? _database;

  @override
  Future<bool> isSignedIn() async {
    return _remoteDataSource.baseUrl.isNotEmpty;
  }

  @override
  Future<AuthLoginResult> login({
    required String identity,
    required String password,
  }) async {
    final database = _database;
    if (database == null) {
      await _remoteDataSource.login(identity: identity, password: password);
      return AuthLoginResult.online;
    }

    final didLoginOffline = await _tryOfflineLogin(
      database: database,
      identity: identity,
      password: password,
    );
    if (didLoginOffline) {
      unawaited(
        _refreshRemoteLogin(
          database: database,
          identity: identity,
          password: password,
        ),
      );
      return AuthLoginResult.offline;
    }

    try {
      final response = await _remoteDataSource.login(
        identity: identity,
        password: password,
      );

      await _saveRemoteLogin(
        response: response,
        database: database,
        password: password,
      );
      return AuthLoginResult.online;
    } on ApiException {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _database?.clearCurrentSession();
  }

  Future<void> _saveRemoteLogin({
    required Map<String, dynamic> response,
    required AppDatabase database,
    required String password,
  }) async {
    final shop = response['shop'] as Map<String, dynamic>;
    final user = response['user'] as Map<String, dynamic>;

    await database.saveLoggedInSession(
      shop: LocalShopsCompanion(
        id: Value(shop['id'].toString()),
        shopName: Value(shop['shop_name'].toString()),
        email: Value(shop['email'].toString()),
        shopMobile: Value(shop['shop_mobile'].toString()),
        shopWebsite: Value(_nullableString(shop['shop_website'])),
        shopAddress: Value(_nullableString(shop['shop_address'])),
        createdAt: Value(_dateTime(shop['created_at'])),
        updatedAt: Value(_dateTime(shop['updated_at'])),
        deletedAt: Value(_nullableDateTime(shop['deleted_at'])),
        syncStatus: const Value('synced'),
      ),
      user: LocalUsersCompanion(
        id: Value(user['id'].toString()),
        shopId: Value(user['shop_id'].toString()),
        name: Value(user['name'].toString()),
        email: Value(user['email'].toString()),
        passwordHash: Value(_passwordHash(password)),
        role: Value(user['role'].toString()),
        emailVerifiedAt: Value(_nullableDateTime(user['email_verified_at'])),
        createdAt: Value(_dateTime(user['created_at'])),
        updatedAt: Value(_dateTime(user['updated_at'])),
        deletedAt: Value(_nullableDateTime(user['deleted_at'])),
        syncStatus: const Value('synced'),
      ),
    );
  }

  Future<bool> _tryOfflineLogin({
    required AppDatabase database,
    required String identity,
    required String password,
  }) async {
    final localUser = await database.findUserForOfflineLogin(identity);
    if (localUser == null || localUser.passwordHash == null) {
      return false;
    }

    if (localUser.passwordHash != _passwordHash(password)) {
      return false;
    }

    await database.clearCurrentSession();
    await database.localUsers.update().replace(
      localUser.copyWith(isCurrent: true),
    );

    return true;
  }

  Future<void> _refreshRemoteLogin({
    required AppDatabase database,
    required String identity,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(
        identity: identity,
        password: password,
      );

      await _saveRemoteLogin(
        response: response,
        database: database,
        password: password,
      );
    } on ApiException {
      // Local login already succeeded. Network refresh can wait until later.
    }
  }

  @override
  Future<void> sendSignupOtp({
    required String email,
    required String shopName,
    required String fullName,
  }) {
    return _remoteDataSource.sendSignupOtp(
      email: email,
      shopName: shopName,
      fullName: fullName,
    );
  }

  @override
  Future<void> verifySignupOtp({
    required String email,
    required String otp,
    required String shopName,
    required String fullName,
    required String phone,
    required String password,
    required String confirmPassword,
  }) {
    return _remoteDataSource.verifySignupOtp(
      email: email,
      otp: otp,
      shopName: shopName,
      fullName: fullName,
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
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

  String _passwordHash(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }
}
