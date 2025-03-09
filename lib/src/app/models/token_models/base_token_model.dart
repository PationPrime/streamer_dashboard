import 'package:equatable/equatable.dart';

abstract class BaseTokenModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final DateTime? lastUpdateTime;

  bool get isAccessTokenAlive =>
      lastUpdateTime is DateTime &&
      lastUpdateTime!.difference(DateTime.now()).abs().inSeconds < expiresIn;

  const BaseTokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.lastUpdateTime,
  });
}
