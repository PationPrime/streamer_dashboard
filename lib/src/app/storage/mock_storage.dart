part of 'storage.dart';

class MockLocalStorage implements LocalStorageInterface {
  const MockLocalStorage._();

  static Map<String, dynamic> _storage = {};

  static const instance = MockLocalStorage._();

  static const _logger = AppLogger(where: 'MockLocalStorage');

  @override
  FutureOr<void> setAppEnvironment(String environmentName) async {
    _storage['app_environment'] = environmentName;
    _logger.logMessage('set app_environment to $environmentName');
  }

  @override
  Future<String?> getAppEnvironmentName() async {
    return _storage['app_environment'];
  }

  @override
  Future<void> clearAllData() async => _storage.clear();

  @override
  Future<void> deleteMainApiV1Token() {
    throw UnimplementedError();
  }

  @override
  Future<void> setToken(MainV1TokenModel token) {
    throw UnimplementedError();
  }

  @override
  Future<MainV1TokenModel> getToken() {
    throw UnimplementedError();
  }

  @override
  Future<void> setTwitchToken(TwitchTokenModel token) {
    throw UnimplementedError();
  }

  @override
  Future<TwitchTokenModel> getTwitchToken() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTwitchToken() {
    throw UnimplementedError();
  }

  @override
  Future<String?> getDonationAlertsWidgetWevbViewUrl() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveDonationAlertsWidgetWevbViewUrl(String widgetWebViewUrl) {
    throw UnimplementedError();
  }

  @override
  Future<void> setTwitchAuthTokenCookie(String authTokenCookieValue) {
    throw UnimplementedError();
  }

  @override
  Future<void> removeDonationAlertsWidgetWevbViewUrl() {
    throw UnimplementedError();
  }

  @override
  Future<String?> getThemeType() {
    // TODO: implement getThemeType
    throw UnimplementedError();
  }

  @override
  Future<void> setThemeType(String themeType) {
    // TODO: implement setThemeType
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllStorageValues() {
    // TODO: implement deleteAllStorageValues
    throw UnimplementedError();
  }
}
