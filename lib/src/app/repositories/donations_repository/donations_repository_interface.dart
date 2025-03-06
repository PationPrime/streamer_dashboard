import 'package:dartz/dartz.dart';
import 'package:streamer_dashboard/src/app/errors/api/api_errors.dart';
import 'package:streamer_dashboard/src/app/errors/donations_errors/donations_errors.dart';

import '../../../assets_gen/assets.gen.dart';
import '../../api_client/client/concrete_client.dart';
import '../../constants/constants.dart';
import '../../failure/failure.dart';
import '../../tools/tools.dart';
import '../base_repository_interface.dart';

part 'donations_repository.dart';

abstract interface class DonationsRepositoryInterface
    implements BaseRepositoryInterface {
  Future<Either<Failure, String>> loadDonationAlertsWidgetWebViewUrl();
}
