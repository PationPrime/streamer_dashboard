part of 'twitch_api_repository_interface.dart';

final class TwitchApiRepository implements TwitchApiRepositoryInterface {
  final ConcreteApiClient _apiClient;

  const TwitchApiRepository(
    this._apiClient,
  );

  @override
  ConcreteApiClient get apiClient => _apiClient;

  @override
  ErrorHandler get errorHandler => const TwitchErrorHandler();

  @override
  Future<Either<Failure, TwitchUserModel>> getStreamerProfile() async {
    try {
      final response = await _apiClient.twitchApiClient.get(
        'helix/users',
      );

      final twitchUsersResponseDto =
          TwitchUsersResponseDto.fromJson(response.data);

      if (twitchUsersResponseDto.data.isEmpty) {
        return Left(
          OtherFailure(
            errorCode: 'not_found',
            message: 'Streamer not found. Users list is empty.',
          ),
        );
      }

      return right(
        twitchUsersResponseDto.data.first,
      );
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
