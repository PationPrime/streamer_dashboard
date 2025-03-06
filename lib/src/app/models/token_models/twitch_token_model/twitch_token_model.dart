import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../base_token_model.dart';

part 'twitch_token_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class TwitchTokenModel extends BaseTokenModel {
  const TwitchTokenModel({
    required super.accessToken,
    required super.expiresIn,
    required super.refreshToken,
    required super.lastUpdateTime,
  });

  @override
  List<Object?> get props => [
        accessToken,
        expiresIn,
        refreshToken,
        lastUpdateTime,
      ];

  TwitchTokenModel copyWith({
    DateTime? lastUpdateTime,
  }) =>
      TwitchTokenModel(
        accessToken: accessToken,
        expiresIn: expiresIn,
        refreshToken: refreshToken,
        lastUpdateTime: lastUpdateTime ?? super.lastUpdateTime,
      );

  factory TwitchTokenModel.fromJsonWithLastUpdateTime(
    Map<String, dynamic> json,
  ) {
    final model = _$TwitchTokenModelFromJson(json);

    return model.copyWith(
      lastUpdateTime: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => _$TwitchTokenModelToJson(this);

  String toJson() => jsonEncode(toMap());
}
