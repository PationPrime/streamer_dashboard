import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main_v1_token_model.g.dart';

@JsonSerializable()
class MainV1TokenModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final int accessTokenTtl;
  final int refreshTokenTtl;
  final DateTime? dateTime;

  bool get isAccessTokenAlive =>
      dateTime!.difference(DateTime.now()).inSeconds.abs() <
      (accessTokenTtl - accessTokenTtl / 20);

  bool get isRefreshTokenAlive => true;

  const MainV1TokenModel({
    required this.accessToken,
    required this.refreshToken,
    this.accessTokenTtl = 300,
    this.refreshTokenTtl = 604800,
    this.dateTime,
  });

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        accessTokenTtl,
        refreshTokenTtl,
        dateTime,
      ];

  MainV1TokenModel copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? dateTime,
    int? accessTokenTtl,
    int? refreshTokenTtl,
  }) =>
      MainV1TokenModel(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        accessTokenTtl: accessTokenTtl ?? this.accessTokenTtl,
        refreshTokenTtl: refreshTokenTtl ?? this.refreshTokenTtl,
        dateTime: dateTime ?? this.dateTime,
      );

  factory MainV1TokenModel.fromJson(Map<String, dynamic> json) =>
      _$MainV1TokenModelFromJson(json);

  Map<String, dynamic> toMap() => _$MainV1TokenModelToJson(this);

  String toJson() => jsonEncode(toMap());
}
