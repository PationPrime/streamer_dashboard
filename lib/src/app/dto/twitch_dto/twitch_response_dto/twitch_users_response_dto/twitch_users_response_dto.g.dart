// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_users_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TwitchUsersResponseDto _$TwitchUsersResponseDtoFromJson(
        Map<String, dynamic> json) =>
    TwitchUsersResponseDto(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => TwitchUserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TwitchUsersResponseDtoToJson(
        TwitchUsersResponseDto instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
