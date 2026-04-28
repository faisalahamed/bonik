import '../config/app_config.dart';

class ApiClient {
  const ApiClient();

  String get baseUrl => AppConfig.apiBaseUrl;
}
