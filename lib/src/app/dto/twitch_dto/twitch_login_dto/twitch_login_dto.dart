import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'twitch_login_dto.g.dart';

@immutable
@JsonSerializable(
  createFactory: false,
  fieldRename: FieldRename.snake,
)
class TwitchLoginDto {
  final String clientId;
  final String clientSecret;
  final String code;
  final String grantType;
  final String redirectUri;

  const TwitchLoginDto({
    required this.clientId,
    required this.clientSecret,
    required this.code,
    required this.grantType,
    required this.redirectUri,
  });

  Map<String, dynamic> toMap() => _$TwitchLoginDtoToJson(this);

  factory TwitchLoginDto.fromAdditionalData(
    Map<String, dynamic> data,
  ) =>
      TwitchLoginDto(
        code: '',
        grantType: '',
        clientId: data['client_id'],
        clientSecret: data['client_secret'],
        redirectUri: data['redirect_uri'],
      );

  TwitchLoginDto copyWith({
    String? code,
    String? grantType,
  }) =>
      TwitchLoginDto(
        clientId: clientId,
        clientSecret: clientSecret,
        code: code ?? this.code,
        grantType: grantType ?? this.grantType,
        redirectUri: redirectUri,
      );
}
