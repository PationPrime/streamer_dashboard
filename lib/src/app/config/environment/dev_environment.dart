part of 'environment.dart';

class DevEnvironment extends AppEnvironment {
  const DevEnvironment()
      : super._(
          baseUrl: DevelopConfig.baseUrl,
          connectTimeout: DevelopConfig.connectTimeout,
          receiveTimeout: DevelopConfig.receiveTimeout,
          defaultLocale: DevelopConfig.defaultLocale,
          twitchAuthBaseUrl: DevelopConfig.twitchAuthBaseUrl,
        );
}
