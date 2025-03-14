import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../base_token_model.dart';

part 'twitch_token_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class TwitchTokenModel extends BaseTokenModel {
  final String? authTokenCookieValue;

  const TwitchTokenModel({
    this.authTokenCookieValue,
    required super.accessToken,
    required super.refreshToken,
    required super.expiresIn,
    required super.lastUpdateTime,
  });

  @override
  List<Object?> get props => [
        authTokenCookieValue,
        accessToken,
        refreshToken,
        expiresIn,
        lastUpdateTime,
      ];

  TwitchTokenModel copyWith({
    String? authTokenCookieValue,
    DateTime? lastUpdateTime,
  }) =>
      TwitchTokenModel(
        authTokenCookieValue: authTokenCookieValue ?? this.authTokenCookieValue,
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresIn: expiresIn,
        lastUpdateTime: lastUpdateTime ?? super.lastUpdateTime,
      );

  factory TwitchTokenModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TwitchTokenModelFromJson(json);

  factory TwitchTokenModel.fromJsonWithLastUpdateTimeAndAuthTokenCookie(
    Map<String, dynamic> json, {
    String? authTokenCookieValue,
  }) {
    final model = TwitchTokenModel.fromJson(json);

    return model.copyWith(
      lastUpdateTime: DateTime.now(),
      authTokenCookieValue: authTokenCookieValue,
    );
  }

  Map<String, dynamic> toMap() => _$TwitchTokenModelToJson(this);

  String toJson() => jsonEncode(toMap());
}
