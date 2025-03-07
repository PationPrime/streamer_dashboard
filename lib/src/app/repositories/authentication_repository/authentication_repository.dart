part of 'authentication_repository_interface.dart';

final class AuthenticationRepository
    implements AuthenticationRepositoryInterface {
  final ConcreteApiClient _apiClient;

  AuthenticationRepository(
    this._apiClient,
  );

  @override
  ConcreteApiClient get apiClient => _apiClient;

  @override
  ErrorHandler get errorHandler => const AuthenticationErrorHandler();

  @override
  ExternalWebviewWindow get externalWebviewWindowPlugin =>
      ExternalWebviewWindow();

  @override
  void subscribeToWebViewEvents({
    GenericEventCallback<Uri>? onLoadStart,
    GenericEventCallback<Uri>? onLoadEnd,
    GenericEventCallback<Uri>? onURLChanged,
    GenericEventCallback<Uri>? onLoadError,
  }) =>
      externalWebviewWindowPlugin.subscribeToWebViewEvents(
        onLoadStart: onLoadStart,
        onLoadEnd: onLoadEnd,
        onURLChanged: onURLChanged,
        onLoadError: onLoadError,
      );

  @override
  void cancelWebViewEventsSubscription() =>
      externalWebviewWindowPlugin.cancelWebViewEventsSubscription();

  @override
  Future<Either<Failure, bool>> loginOAuth2Twitch({
    required TwitchLoginDto twitchLoginDto,
    required GenericEventCallback<Uri> onLoadEnd,
  }) async {
    try {
      cancelWebViewEventsSubscription();

      subscribeToWebViewEvents(
        onLoadEnd: onLoadEnd,
      );

      final oauthUrl = '${apiClient.twitchAuthClient.options.baseUrl}authorize';

      final twitchOAuth2Uri = Uri.parse(
        '$oauthUrl?client_id=${twitchLoginDto.clientId}&redirect_uri=${twitchLoginDto.redirectUri}&response_type=code&scope=user:read:email',
      );

      await externalWebviewWindowPlugin.openCEFWebViewWindow(
        url: '$twitchOAuth2Uri',
        windowTitle: TwitchConstants.webviewWindowTitle,
      );

      return const Right(true);
    } catch (error, stackTrace) {
      return Left(
        errorHandler.handleError(
          error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, TwitchTokenModel>> loginTwitch({
    required TwitchLoginDto twitchLoginDto,
  }) async {
    try {
      final response = await _apiClient.twitchAuthClient.post(
        'token',
        data: twitchLoginDto.toMap(),
      );

      final data = response.data;

      final twitchTokenModel = TwitchTokenModel.fromJsonWithLastUpdateTime(
        data,
      );

      return Right(twitchTokenModel);
    } catch (error, stackTrace) {
      return Left(
        errorHandler.handleError(
          error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
