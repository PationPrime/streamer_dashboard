import 'package:flutter/material.dart';

enum DeviceType {
  mobile,
  tablet,
  desktop,
}

extension DeviceTypeExtension on DeviceType {
  bool get isMobile => this == DeviceType.mobile;
  bool get isTablet => this == DeviceType.tablet;
  bool get isDesktop => this == DeviceType.desktop;
}

abstract class DeviceSizeData {
  static final deviceSizeData = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.single,
  );

  static Size mediaQuerySize(BuildContext context) =>
      MediaQuery.of(context).size;

  static int gridItemsCountByScreenWidth(
    BuildContext context, {
    int extraSmallMobile = 1,
    int smallMobile = 2,
    int smallTablet = 2,
    int largeTablet = 3,
    int smallDesktop = 4,
    int largeDesktop = 5,
    int veryLargeDesktop = 6,
    int extraLargeDesktop = 7,
    int superLargeDesktop = 12,
  }) {
    final width = mediaQuerySize(context).width;

    if (width <= 360) return extraSmallMobile;
    if (width <= 481) return smallMobile;
    if (width <= 601) return smallMobile;
    if (width <= 769) return largeTablet;
    if (width <= 1025) return smallDesktop;
    if (width <= 1281) return largeDesktop;
    if (width <= 1441) return veryLargeDesktop;
    if (width <= 2000) return extraLargeDesktop;
    if (width <= 3000) return superLargeDesktop;

    return superLargeDesktop;
  }

  static Size get size => deviceSizeData.size;

  static DeviceType get deviceType => size.width < 600
      ? DeviceType.mobile
      : size.width < 1500
          ? DeviceType.tablet
          : DeviceType.desktop;
}
