import '../../storage/storage.dart';
import '../dev_environment_config.dart';
import '../main_environment_config.dart';
import '../prod_environment_config.dart';
import '../test_environment_config.dart';

part 'dev_environment.dart';
part 'test_environment.dart';
part 'prod_environment.dart';

abstract class AppEnvironment {
  static const _develop = "develop";
  static const _test = "test";
  static const _production = "production";

  static const _localStorage = AppSecureStorage.instance;
  static const _fallbackAppEnvironment = DevEnvironment();

  final String baseUrl;
  final int connectTimeout;
  final int receiveTimeout;
  final String defaultLocale;

  const AppEnvironment._({
    required this.baseUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.defaultLocale,
  });

  @override
  String toString() => '''
        connectTimeout: $connectTimeout
        receiveTimeout:$receiveTimeout
        defaultLocale: $defaultLocale
      ''';

  static AppEnvironment _instance =
      switch (MainEnvironmentConfig.currentConfigName) {
    _develop => const DevEnvironment(),
    _test => const TestingEnvironment(),
    _production => const ProdEnvironment(),
    _ => _fallbackAppEnvironment,
  };

  static AppEnvironment get instance => _instance;

  static set instance(AppEnvironment env) {
    if (instance == env) return;
    _instance = env;
  }

  static Future<void> init() async {
    final envFromStorage = await _localStorage.getAppEnvironmentName();

    switch (envFromStorage) {
      case _develop:
        instance = const DevEnvironment();
        return;
      case _test:
        instance = const TestingEnvironment();
        return;
      case _production:
        instance = const ProdEnvironment();
        return;
      default:
        instance = _fallbackAppEnvironment;
        return;
    }
  }

  static Future<void> setAppEnvironmentConfig({
    required AppEnvironment env,
  }) async {
    await _localStorage.clearAllData();
    await _localStorage.setAppEnvironment(env.envName);
    await init();
  }
}

extension AppEnvironmentState on AppEnvironment {
  bool get isDev => this is DevEnvironment;

  bool get isTest => this is TestingEnvironment;

  bool get isProd => this is ProdEnvironment;

  bool get mainIsProd =>
      MainEnvironmentConfig.currentConfigName == ProductionConfig.configName;

  String get envName => this is ProdEnvironment
      ? AppEnvironment._production
      : this is TestingEnvironment
          ? AppEnvironment._test
          : AppEnvironment._develop;
}
