part of 'donations_controller.dart';

class DonationsState extends Equatable {
  final bool isLoading;
  final DonationAlertsModel? donationAlertsModel;

  const DonationsState({
    this.isLoading = false,
    this.donationAlertsModel,
  });

  @override
  List<Object?> get props => [
        isLoading,
        donationAlertsModel,
      ];

  DonationsState copyWith({
    bool? isLoading,
    DonationAlertsModel? donationAlertsModel,
  }) =>
      DonationsState(
        isLoading: isLoading ?? this.isLoading,
        donationAlertsModel: donationAlertsModel ?? this.donationAlertsModel,
      );
}

final class DonationsInitialState extends DonationsState {
  const DonationsInitialState();
}
