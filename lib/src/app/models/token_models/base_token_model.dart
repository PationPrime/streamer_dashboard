import 'package:equatable/equatable.dart';

abstract class BaseTokenModel extends Equatable {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;

  const BaseTokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });
}
