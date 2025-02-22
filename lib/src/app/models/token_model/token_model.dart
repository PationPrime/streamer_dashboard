import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable()
class TokenModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final int accessTokenTtl;
  final int refreshTokenTtl;
  final DateTime? dateTime;

  bool get isAccessTokenAlive =>
      dateTime!.difference(DateTime.now()).inSeconds.abs() <
      (accessTokenTtl - accessTokenTtl / 20);

  bool get isRefreshTokenAlive => true;

  const TokenModel({
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

  TokenModel copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? dateTime,
    int? accessTokenTtl,
    int? refreshTokenTtl,
  }) =>
      TokenModel(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        accessTokenTtl: accessTokenTtl ?? this.accessTokenTtl,
        refreshTokenTtl: refreshTokenTtl ?? this.refreshTokenTtl,
        dateTime: dateTime ?? this.dateTime,
      );

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}
