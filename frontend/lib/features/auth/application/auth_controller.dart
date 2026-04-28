import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';
import '../data/datasources/auth_remote_data_source.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    AuthRemoteDataSource(const ApiClient()),
    ref.watch(appDatabaseProvider),
  );
});

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> signIn({
    required String identity,
    required String password,
  }) async {
    state = state.copyWith(isSubmitting: true);

    try {
      await ref
          .read(authRepositoryProvider)
          .login(identity: identity, password: password);

      state = const AuthState(
        status: AuthStatus.authenticated,
        isSubmitting: false,
      );
    } catch (_) {
      state = const AuthState(
        status: AuthStatus.unauthenticated,
        isSubmitting: false,
      );
      rethrow;
    }
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).logout();

    state = const AuthState(
      status: AuthStatus.unauthenticated,
      isSubmitting: false,
    );
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);
