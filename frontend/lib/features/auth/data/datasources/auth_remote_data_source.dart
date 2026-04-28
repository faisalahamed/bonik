import '../../../../core/network/api_client.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  String get baseUrl => _apiClient.baseUrl;

  Future<void> sendSignupOtp({
    required String email,
    required String shopName,
    required String fullName,
  }) async {
    await _apiClient.postJson(
      '/auth/signup/send-otp',
      body: {'email': email, 'shop_name': shopName, 'full_name': fullName},
    );
  }

  Future<void> verifySignupOtp({
    required String email,
    required String otp,
    required String shopName,
    required String fullName,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    await _apiClient.postJson(
      '/auth/signup/verify-otp',
      body: {
        'email': email,
        'otp': otp,
        'shop_name': shopName,
        'full_name': fullName,
        'phone': phone,
        'password': password,
        'password_confirmation': confirmPassword,
      },
    );
  }

  Future<Map<String, dynamic>> login({
    required String identity,
    required String password,
  }) {
    return _apiClient.postJson(
      '/auth/login',
      body: {'identity': identity, 'password': password},
    );
  }
}
