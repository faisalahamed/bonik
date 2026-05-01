enum AuthLoginResult { online, offline }

abstract class AuthRepository {
  Future<bool> isSignedIn();

  Future<AuthLoginResult> login({
    required String identity,
    required String password,
  });

  Future<void> logout();

  Future<void> sendSignupOtp({
    required String email,
    required String shopName,
    required String fullName,
  });

  Future<void> verifySignupOtp({
    required String email,
    required String otp,
    required String shopName,
    required String fullName,
    required String phone,
    required String password,
    required String confirmPassword,
  });
}
