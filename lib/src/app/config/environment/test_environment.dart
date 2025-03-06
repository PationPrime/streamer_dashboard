part of 'environment.dart';

class TestingEnvironment extends AppEnvironment {
  const TestingEnvironment()
      : super._(
          baseUrl: TestingConfig.baseUrl,
          connectTimeout: TestingConfig.connectTimeout,
          receiveTimeout: TestingConfig.receiveTimeout,
          defaultLocale: TestingConfig.defaultLocale,
          twitchAuthBaseUrl: TestingConfig.twitchAuthBaseUrl,
        );
}
