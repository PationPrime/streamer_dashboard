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
  Future<void> deleteToken() {
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
  Future<String?> getDonationAlertsWidgetWevbViewUrl() {
    // TODO: implement getDonationAlertsWidgetWevbViewUrl
    throw UnimplementedError();
  }

  @override
  Future<void> saveDonationAlertsWidgetWevbViewUrl(String widgetWebViewUrl) {
    // TODO: implement saveDonationAlertsWidgetWevbViewUrl
    throw UnimplementedError();
  }
}
