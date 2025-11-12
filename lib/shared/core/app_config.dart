class AppConfig {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080/api/v1', // valor por defecto (Android Emulator)
  );

  // otros “tunables”
  static const int connectTimeoutMs = 8000;
  static const int receiveTimeoutMs = 10000;
}
