import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:streamer_dashboard/src/app/models/models.dart';

part 'twitch_users_response_dto.g.dart';

@immutable
@JsonSerializable()
class TwitchUsersResponseDto {
  final List<TwitchUserModel> data;

  const TwitchUsersResponseDto({
    this.data = const [],
  });

  factory TwitchUsersResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TwitchUsersResponseDtoFromJson(json);

  Map<String, dynamic> toMap() => _$TwitchUsersResponseDtoToJson(this);

  String toJson() => jsonEncode(toMap());
}
