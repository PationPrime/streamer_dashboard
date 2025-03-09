import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'twitch_user_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class TwitchUserModel extends Equatable {
  final String id;
  final String login;
  final String? displayName;
  final String? type;
  final String? broadcasterType;
  final String? description;
  final String? profileImageUrl;
  final String? offlineImageUrl;
  final num? viewCount;
  final String? email;
  final String? createdAt;

  const TwitchUserModel({
    required this.id,
    required this.login,
    this.displayName,
    this.type,
    this.broadcasterType,
    this.description,
    this.profileImageUrl,
    this.offlineImageUrl,
    this.viewCount,
    this.email,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        login,
        displayName,
        type,
        broadcasterType,
        description,
        profileImageUrl,
        offlineImageUrl,
        viewCount,
        email,
        createdAt,
      ];

  factory TwitchUserModel.fromJson(Map<String, dynamic> json) =>
      _$TwitchUserModelFromJson(
        json,
      );

  Map<String, dynamic> toMap() => _$TwitchUserModelToJson(this);

  String toJson() => jsonEncode(toMap());
}
