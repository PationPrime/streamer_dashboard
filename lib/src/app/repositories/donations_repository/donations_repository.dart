part of 'donations_repository_interface.dart';

final class DonationsRepository implements DonationsRepositoryInterface {
  @override
  ConcreteApiClient get apiClient => throw UnimplementedError();

  @override
  ErrorHandler get errorHandler => const DonationsErrorHandler();

  @override
  Future<Either<Failure, String>> loadDonationAlertsWidgetWebViewUrl() async {
    try {
      final data = await JsonTool.readJsonFileFromAsset(
        Assets.additionalData.donations,
        jsonRootKey: DonationConstants.donationAlertsWidgetWebViewUrl,
      );

      return Right(data);
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
