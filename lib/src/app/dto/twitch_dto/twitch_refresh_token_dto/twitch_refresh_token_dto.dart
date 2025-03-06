import 'package:json_annotation/json_annotation.dart';

import '../../../constants/constants.dart';

part 'twitch_refresh_token_dto.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
)
class TwitchRefreshTokenDto {
  final String grantType;
  final String refreshToken;
  final String clientId;
  final String clientSecret;

  const TwitchRefreshTokenDto({
    this.grantType = TwitchConstants.refreshTokenGrantType,
    required this.refreshToken,
    required this.clientId,
    required this.clientSecret,
  });

  Map<String, dynamic> toMap() => _$TwitchRefreshTokenDtoToJson(this);
}
