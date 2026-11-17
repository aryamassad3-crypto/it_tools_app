enum Environment { dev, prod }

class AppConfig {
  final String appName;
  final String apiBaseUrl;
  final Environment environment;

  AppConfig({
    required this.appName,
    required this.apiBaseUrl,
    required this.environment,
  });

  static late AppConfig instance;

  static void initialize(AppConfig config) {
    instance = config;
  }

  // قراءة الرابط مباشرة من ملف JSON الممرر وقت التشغيل
  static String get baseUrlFromEnv => const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://example.com',
  );
}
