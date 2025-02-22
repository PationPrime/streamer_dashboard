import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppNavigationBarItem extends Equatable {
  final Widget? activeIcon;
  final Widget inActiveIcon;
  final String? label;
  final VoidCallback? onTap;

  const AppNavigationBarItem({
    this.activeIcon,
    required this.inActiveIcon,
    this.label,
    this.onTap,
  });

  @override
  List<Object?> get props => [
        activeIcon,
        inActiveIcon,
        label,
        onTap,
      ];

  AppNavigationBarItem copyWith({
    Widget? activeIcon,
    Widget? inActiveIcon,
    String? label,
    VoidCallback? onTap,
  }) =>
      AppNavigationBarItem(
        activeIcon: activeIcon ?? this.activeIcon,
        inActiveIcon: inActiveIcon ?? this.inActiveIcon,
        label: label ?? this.label,
        onTap: onTap ?? this.onTap,
      );
}
