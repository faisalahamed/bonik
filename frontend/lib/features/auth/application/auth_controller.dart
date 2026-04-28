import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_state.dart';

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

    await Future<void>.delayed(const Duration(milliseconds: 600));

    state = const AuthState(
      status: AuthStatus.authenticated,
      isSubmitting: false,
    );
  }

  void signOut() {
    state = const AuthState(
      status: AuthStatus.unauthenticated,
      isSubmitting: false,
    );
  }
}

final authControllerProvider =
    NotifierProvider<AuthController, AuthState>(AuthController.new);
