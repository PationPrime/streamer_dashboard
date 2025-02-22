part of 'storage.dart';

class AppSecureStorage implements LocalStorageInterface {
  const AppSecureStorage._();

  static const instance = AppSecureStorage._();

  static const _appLogger = AppLogger(
    where: 'AppSecureStorage',
  );

  @override
  FutureOr<void> setAppEnvironment(String environmentName) async {}

  @override
  Future<String?> getAppEnvironmentName() async {}

  @override
  Future<void> clearAllData() async {}

  @override
  Future<void> deleteToken() {
    throw UnimplementedError();
  }

  @override
  Future<void> setToken(TokenModel token) {
    throw UnimplementedError();
  }

  @override
  Future<TokenModel> getToken() {
    throw UnimplementedError();
  }
}
