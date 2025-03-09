part of 'storage.dart';

abstract class LocalStorageInterface {
  const LocalStorageInterface._();

  FutureOr<void> setAppEnvironment(String environmentName);

  Future<String?> getAppEnvironmentName();

  Future<void> clearAllData();

  Future<void> deleteMainApiV1Token();

  Future<void> setToken(MainV1TokenModel token);

  Future<void> setTwitchToken(TwitchTokenModel token);

  Future<MainV1TokenModel> getToken();

  Future<TwitchTokenModel?> getTwitchToken();

  Future<void> deleteTwitchToken();

  Future<void> saveDonationAlertsWidgetWevbViewUrl(
    String widgetWebViewUrl,
  );

  Future<String?> getDonationAlertsWidgetWevbViewUrl();
}
