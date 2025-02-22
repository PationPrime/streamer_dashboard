// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenModel _$TokenModelFromJson(Map<String, dynamic> json) => TokenModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      accessTokenTtl: (json['accessTokenTtl'] as num?)?.toInt() ?? 300,
      refreshTokenTtl: (json['refreshTokenTtl'] as num?)?.toInt() ?? 604800,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$TokenModelToJson(TokenModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'accessTokenTtl': instance.accessTokenTtl,
      'refreshTokenTtl': instance.refreshTokenTtl,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
