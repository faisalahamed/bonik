enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  const AuthState({
    required this.status,
    this.isSubmitting = false,
    this.submitMessage,
    this.warningMessage,
  });

  final AuthStatus status;
  final bool isSubmitting;
  final String? submitMessage;
  final String? warningMessage;

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;

  AuthState copyWith({
    AuthStatus? status,
    bool? isSubmitting,
    String? submitMessage,
    String? warningMessage,
    bool clearSubmitMessage = false,
    bool clearWarningMessage = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitMessage: clearSubmitMessage
          ? null
          : submitMessage ?? this.submitMessage,
      warningMessage: clearWarningMessage
          ? null
          : warningMessage ?? this.warningMessage,
    );
  }
}
