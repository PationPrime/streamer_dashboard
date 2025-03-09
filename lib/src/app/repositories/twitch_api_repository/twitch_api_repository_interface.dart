import 'package:dartz/dartz.dart';
import 'package:streamer_dashboard/src/app/dto/twitch_dto/twitch_response_dto/twitch_users_response_dto/twitch_users_response_dto.dart';
import 'package:streamer_dashboard/src/app/errors/constants/constants.dart';
import 'package:streamer_dashboard/src/app/models/models.dart';
import 'package:streamer_dashboard/src/app/repositories/repositories.dart';

import '../../api_client/client/concrete_client.dart';
import '../../errors/errors.dart';
import '../../failure/failure.dart';

part 'twitch_api_repository.dart';

abstract interface class TwitchApiRepositoryInterface
    implements BaseRepositoryInterface {
  Future<Either<Failure, TwitchUserModel>> getStreamerProfile();
}
