part of 'donations_controller.dart';

class DonationsState extends Equatable {
  final bool loading;
  final DonationAlertsModel? donationAlertsModel;
  final bool showDonationAlersLink;
  final Failure? failure;

  bool get donationAlertsConnected =>
      donationAlertsModel?.widgetWebViewUrl is String;

  const DonationsState({
    this.loading = false,
    this.donationAlertsModel,
    this.showDonationAlersLink = false,
    this.failure,
  });

  @override
  List<Object?> get props => [
        loading,
        donationAlertsModel,
        showDonationAlersLink,
        failure,
      ];

  DonationsState copyWith({
    bool? loading,
    DonationAlertsModel? donationAlertsModel,
    bool? showDonationAlersLink,
    Failure? failure,
  }) =>
      DonationsState(
        loading: loading ?? this.loading,
        donationAlertsModel: donationAlertsModel ?? this.donationAlertsModel,
        showDonationAlersLink:
            showDonationAlersLink ?? this.showDonationAlersLink,
        failure: failure ?? this.failure,
      );

  DonationsState clearFailure() => DonationsState(
        loading: loading,
        donationAlertsModel: donationAlertsModel,
        showDonationAlersLink: showDonationAlersLink,
      );

  DonationsState clearDonationAlerts() => DonationsState(
        loading: loading,
        showDonationAlersLink: showDonationAlersLink,
        failure: failure,
      );
}

final class DonationsInitialState extends DonationsState {
  const DonationsInitialState();
}
