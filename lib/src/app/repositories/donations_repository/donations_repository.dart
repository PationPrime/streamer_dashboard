part of 'donations_repository_interface.dart';

class DonationsRepository implements DonationsRepositoryInterface {
  late final _appLogger = AppLogger(where: '$this');

  @override
  ConcreteApiClient get apiClient => throw UnimplementedError();

  @override
  ErrorHandler get errorHandler => const DonationsErrorHandler();

  @override
  Future<Either<Failure, String>> loadDonationAlertsWidgetWebViewUrl() async {
    try {
      final data = await JsonTool.readJsonFileFromAsset(
        Assets.additionalData.donations,
        jsonRootKey: DonationKeysConstants.donationAlertsWidgetWebViewUrl,
      );

      return Right(data);
    } catch (error, stackTrace) {
      _appLogger.logError(
        "error: $error",
        stackTrace: stackTrace,
      );

      return Left(
        errorHandler.handleError(error),
      );
    }
  }
}
