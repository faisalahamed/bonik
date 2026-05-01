import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_client.dart';
import '../../../core/sync/app_sync_service.dart';
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
    state = state.copyWith(
      isSubmitting: true,
      submitMessage: 'লগইন হচ্ছে',
      clearWarningMessage: true,
    );

    try {
      final loginResult = await ref
          .read(authRepositoryProvider)
          .login(identity: identity, password: password);

      String? warningMessage;
      if (loginResult == AuthLoginResult.online) {
        state = state.copyWith(
          isSubmitting: true,
          submitMessage: 'ডাটা লোড হচ্ছে',
          clearWarningMessage: true,
        );

        try {
          await ref.read(appSyncServiceProvider).syncAll();
        } catch (_) {
          warningMessage =
              'ডাটা পুরোপুরি লোড হয়নি, ড্যাশবোর্ডের সিঙ্ক বাটন চাপুন';
        }
      }

      state = AuthState(
        status: AuthStatus.authenticated,
        isSubmitting: false,
        warningMessage: warningMessage,
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
