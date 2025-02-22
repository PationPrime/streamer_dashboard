part of 'environment.dart';

class ProdEnvironment extends AppEnvironment {
  const ProdEnvironment()
      : super._(
          baseUrl: ProductionConfig.baseUrl,
          connectTimeout: ProductionConfig.connectTimeout,
          receiveTimeout: ProductionConfig.receiveTimeout,
          defaultLocale: ProductionConfig.defaultLocale,
        );
}
