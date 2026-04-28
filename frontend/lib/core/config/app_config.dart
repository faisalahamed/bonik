class AppConfig {
  static const String appName = 'TallyShop';

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000/api',
  );

  const AppConfig._();
}
