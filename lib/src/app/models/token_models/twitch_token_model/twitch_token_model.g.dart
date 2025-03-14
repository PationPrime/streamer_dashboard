// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TwitchTokenModel _$TwitchTokenModelFromJson(Map<String, dynamic> json) =>
    TwitchTokenModel(
      authTokenCookieValue: json['auth_token_cookie_value'] as String?,
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresIn: (json['expires_in'] as num).toInt(),
      lastUpdateTime: json['last_update_time'] == null
          ? null
          : DateTime.parse(json['last_update_time'] as String),
    );

Map<String, dynamic> _$TwitchTokenModelToJson(TwitchTokenModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'expires_in': instance.expiresIn,
      'last_update_time': instance.lastUpdateTime?.toIso8601String(),
      'auth_token_cookie_value': instance.authTokenCookieValue,
    };
