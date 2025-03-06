import 'package:dartz/dartz.dart';
import 'package:streamer_dashboard/src/app/api_client/client/client.dart';
import 'package:streamer_dashboard/src/app/errors/api/api_errors.dart';
import 'package:streamer_dashboard/src/app/errors/authentication_errors/authentication_errors.dart';

import '../../dto/dto.dart';
import '../../failure/failure.dart';
import '../../models/models.dart';
import '../../storage/storage.dart';
import '../base_repository_interface.dart';

part 'authentication_repository.dart';

abstract interface class AuthenticationRepositoryInterface
    implements BaseRepositoryInterface {
  Future<Either<Failure, TwitchTokenModel>> loginTwitch({
    required TwitchLoginDto twitchLoginDto,
  });
}
