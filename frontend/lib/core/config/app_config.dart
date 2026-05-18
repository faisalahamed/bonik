class AppConfig {
  static const String appName = 'বণিক';

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://192.168.31.217:8000/api',
  );

  const AppConfig._();
}
