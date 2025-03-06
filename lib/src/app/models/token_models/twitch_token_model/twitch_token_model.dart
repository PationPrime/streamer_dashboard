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
  });

  @override
  List<Object?> get props => [
        accessToken,
        expiresIn,
        refreshToken,
      ];

  factory TwitchTokenModel.fromJson(Map<String, dynamic> json) =>
      _$TwitchTokenModelFromJson(json);

  Map<String, dynamic> toMap() => _$TwitchTokenModelToJson(this);
}
