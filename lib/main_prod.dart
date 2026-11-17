import 'package:it_tools_app/core/environments/app_config.dart';
import 'package:it_tools_app/main_common.dart';

void main() {
  AppConfig.initialize(
    AppConfig(
      appName: 'IT Tools',
      apiBaseUrl: AppConfig.baseUrlFromEnv,
      environment: Environment.prod,
    ),
  );
  mainCommon();
}
