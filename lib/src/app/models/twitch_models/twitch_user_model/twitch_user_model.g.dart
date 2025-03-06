// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'twitch_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TwitchUserModel _$TwitchUserModelFromJson(Map<String, dynamic> json) =>
    TwitchUserModel(
      id: json['id'] as String,
      login: json['login'] as String,
      displayName: json['display_name'] as String?,
      type: json['type'] as String?,
      broadcasterType: json['broadcaster_type'] as String?,
      description: json['description'] as String?,
      profileImageUrl: json['profile_image_url'] as String?,
      offlineImageUrl: json['offline_image_url'] as String?,
      viewCount: json['view_count'] as num?,
      email: json['email'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$TwitchUserModelToJson(TwitchUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'display_name': instance.displayName,
      'type': instance.type,
      'broadcaster_type': instance.broadcasterType,
      'description': instance.description,
      'profile_image_url': instance.profileImageUrl,
      'offline_image_url': instance.offlineImageUrl,
      'view_count': instance.viewCount,
      'email': instance.email,
      'created_at': instance.createdAt,
    };
