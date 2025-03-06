import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AuthenticationButtonModel extends Equatable {
  final String authProvider;
  final String connectTitle;
  final String disconnectTitle;
  final Widget icon;
  final VoidCallback? onTap;

  const AuthenticationButtonModel({
    required this.authProvider,
    required this.connectTitle,
    required this.disconnectTitle,
    required this.icon,
    this.onTap,
  });

  @override
  List<Object?> get props => [
        authProvider,
        connectTitle,
        disconnectTitle,
        icon,
        onTap,
      ];
}
