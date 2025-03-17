import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'donation_alerts_model.g.dart';

@JsonSerializable(
  createToJson: false,
)
class DonationAlertsModel extends Equatable {
  @JsonKey(name: 'donation_alerts_widget_webview_url')
  final String widgetWebViewUrl;

  const DonationAlertsModel({
    required this.widgetWebViewUrl,
  });

  factory DonationAlertsModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$DonationAlertsModelFromJson(json);

  @override
  List<Object?> get props => [widgetWebViewUrl];
}
