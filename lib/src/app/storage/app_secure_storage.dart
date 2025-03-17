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
      final tokenDataJson = token.toJson();

      await _secureStorage.write(
        key: AppSecureStorageKeys.twitchToken,
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
  Future<void> setTwitchAuthTokenCookie(
    String authTokenCookieValue,
  ) async {
    try {
      final token = await getTwitchToken();

      if (token is! TwitchTokenModel) {
        throw Exception(
          '[updateTwitchAuthTokenCookie] token is! TwitchTokenModel',
        );
      }

      await setTwitchToken(
        token.copyWith(
          authTokenCookieValue: authTokenCookieValue,
        ),
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error setting twitch auth token cookie: $error',
        stackTrace: stackTrace,
        lexicalScope: 'setTwitchAuthTokenCookie method',
      );

      rethrow;
    }
  }

  @override
  Future<TwitchTokenModel?> getTwitchToken() async {
    try {
      final tokenDataJson = await _secureStorage.read(
        key: AppSecureStorageKeys.twitchToken,
      );

      if (tokenDataJson is! String) {
        _appLogger.logMessage(
          'Twitch token data is not a string',
        );

        return null;
      }

      final tokenDataMap = jsonDecode(tokenDataJson) as Map<String, dynamic>;

      return TwitchTokenModel.fromJson(
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
      await _secureStorage.delete(
        key: AppSecureStorageKeys.twitchToken,
      );
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
      return await _secureStorage.read(
        key: AppSecureStorageKeys.donationAlertsLastMessagesWidget,
      );
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
        key: AppSecureStorageKeys.donationAlertsLastMessagesWidget,
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

  @override
  Future<void> removeDonationAlertsWidgetWevbViewUrl() async {
    try {
      await _secureStorage.delete(
        key: AppSecureStorageKeys.donationAlertsLastMessagesWidget,
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error removing donation alerts widget webview url: $error',
        stackTrace: stackTrace,
        lexicalScope: 'removeDonationAlertsWidgetWevbViewUrl method',
      );

      rethrow;
    }
  }

  @override
  Future<void> setThemeType(String themeType) async {
    try {
      await _secureStorage.write(
        key: AppSecureStorageKeys.appTheme,
        value: themeType,
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error setting app theme type: $error',
        stackTrace: stackTrace,
        lexicalScope: 'setThemeType method',
      );

      rethrow;
    }
  }

  @override
  Future<String?> getThemeType() async {
    try {
      return await _secureStorage.read(
        key: AppSecureStorageKeys.appTheme,
      );
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Error setting app theme type: $error',
        stackTrace: stackTrace,
        lexicalScope: 'setThemeType method',
      );

      rethrow;
    }
  }

  @override
  Future<void> deleteAllStorageValues() async {
    try {
      return await _secureStorage.deleteAll();
    } catch (error, stackTrace) {
      _appLogger.logError(
        'Failed to delete all storage values: $error',
        stackTrace: stackTrace,
        lexicalScope: 'deleteAllStorageValues method',
      );

      rethrow;
    }
  }
}
