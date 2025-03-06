part of 'storage.dart';

class AppSecureStorage implements LocalStorageInterface {
  const AppSecureStorage._();

  static const instance = AppSecureStorage._();

  static const _secureStorage = FlutterSecureStorage();

  static const _appLogger = AppLogger(
    where: 'AppSecureStorage',
  );

  @override
  FutureOr<void> setAppEnvironment(String environmentName) async {}

  @override
  Future<String?> getAppEnvironmentName() async {
    throw UnimplementedError();
  }

  @override
  Future<void> clearAllData() async {}

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
  Future<void> setTwitchToken(TwitchTokenModel token) async {
    try {
      final tokenDataMap = token.toMap();
      final tokenDataJson = jsonEncode(tokenDataMap);

      await _secureStorage.write(
        key: 'twitch_token',
        value: tokenDataJson,
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error setting twitch token: $error',
        stackTrace: stackTrace,
        lexicalScope: 'setTwitchToken method',
      );

      rethrow;
    }
  }

  @override
  Future<TwitchTokenModel?> getTwitchToken() async {
    try {
      final tokenDataJson = await _secureStorage.read(
        key: 'twitch_token',
      );

      if (tokenDataJson is! String) {
        _appLogger.logMessage(
          'Twitch token data is not a string',
        );

        return null;
      }

      final tokenDataMap = jsonDecode(tokenDataJson) as Map<String, dynamic>;

      return TwitchTokenModel.fromJsonWithLastUpdateTime(
        tokenDataMap,
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error getting twitch token: $error',
        stackTrace: stackTrace,
        lexicalScope: 'getTwitchToken method',
      );

      rethrow;
    }
  }

  @override
  Future<void> deleteTwitchToken() async {
    try {
      await _secureStorage.delete(key: 'twitch_token');
    } catch (error, stacTrace) {
      _appLogger.logError(
        'Error deleting twitch token: $error',
        stackTrace: stacTrace,
        lexicalScope: 'deleteTwitchToken method',
      );

      rethrow;
    }
  }

  @override
  Future<String?> getDonationAlertsWidgetWevbViewUrl() async {
    try {
      final url = await _secureStorage.read(
        key: 'donation_alerts_widget_webview_url',
      );

      return url;
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error getting donation alerts widget webview url: $error ',
        stackTrace: stackTrace,
        lexicalScope: 'getDonationAlertsWidgetWevbViewUrl method',
      );

      rethrow;
    }
  }

  @override
  Future<void> saveDonationAlertsWidgetWevbViewUrl(
    String widgetWebViewUrl,
  ) async {
    try {
      await _secureStorage.write(
        key: 'donation_alerts_widget_webview_url',
        value: widgetWebViewUrl,
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error saving donation alerts widget webview url: $error',
        stackTrace: stackTrace,
        lexicalScope: 'saveDonationAlertsWidgetWevbViewUrl method',
      );

      rethrow;
    }
  }
}
