part of 'storage.dart';

abstract class LocalStorageInterface {
  const LocalStorageInterface._();

  FutureOr<void> setAppEnvironment(String environmentName);

  Future<String?> getAppEnvironmentName();

  Future<void> clearAllData();

  Future<void> deleteToken();

  Future<void> setToken(TokenModel token);

  Future<TokenModel> getToken();
}
