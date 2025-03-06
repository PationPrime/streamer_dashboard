part of 'authentication_repository_interface.dart';

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  final ConcreteApiClient _apiClient;
  final LocalStorageInterface _localStorage;

  AuthenticationRepository(
    this._apiClient,
    this._localStorage,
  );

  @override
  ConcreteApiClient get apiClient => _apiClient;

  @override
  ErrorHandler get errorHandler => const AuthenticationErrorHandler();

  @override
  Future<Either<Failure, TwitchTokenModel>> loginTwitch({
    required TwitchLoginDto twitchLoginDto,
  }) async {
    try {
      final response = await _apiClient.twitchApiV1.post(
        'token',
        data: twitchLoginDto.toMap(),
      );

      final data = response.data;
      final twitchTokenModel = TwitchTokenModel.fromJson(data);

      return Right(twitchTokenModel);
    } catch (error, stackTrace) {
      return Left(
        errorHandler.handleError(
          error,
        ),
      );
    }
  }
}
