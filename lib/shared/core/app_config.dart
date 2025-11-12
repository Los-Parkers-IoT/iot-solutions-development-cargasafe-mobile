class AppConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080/api/v1', // valor por defecto (Android Emulator)
  );

  // otros “tunables”
  static const int connectTimeoutMs = 8000;
  static const int receiveTimeoutMs = 10000;
}
