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
