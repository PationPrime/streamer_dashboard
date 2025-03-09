/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AdditionalDataGen {
  const $AdditionalDataGen();

  /// File path: additional_data/donations.json
  String get donations => 'additional_data/donations.json';

  /// File path: additional_data/twitch_app_data.json
  String get twitchAppData => 'additional_data/twitch_app_data.json';

  /// List of all assets
  List<String> get values => [donations, twitchAppData];
}

class $AssetsAppLogoGen {
  const $AssetsAppLogoGen();

  /// File path: assets/app_logo/app_logo.ico
  String get appLogoIco => 'assets/app_logo/app_logo.ico';

  /// File path: assets/app_logo/app_logo.png
  AssetGenImage get appLogoPng =>
      const AssetGenImage('assets/app_logo/app_logo.png');

  /// List of all assets
  List<dynamic> get values => [appLogoIco, appLogoPng];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/close_cross.svg
  SvgGenImage get closeCross =>
      const SvgGenImage('assets/icons/close_cross.svg');

  /// File path: assets/icons/close_cross_white.svg
  SvgGenImage get closeCrossWhite =>
      const SvgGenImage('assets/icons/close_cross_white.svg');

  /// File path: assets/icons/icon_arrow_back.svg
  SvgGenImage get iconArrowBack =>
      const SvgGenImage('assets/icons/icon_arrow_back.svg');

  /// File path: assets/icons/icon_arrow_forward.svg
  SvgGenImage get iconArrowForward =>
      const SvgGenImage('assets/icons/icon_arrow_forward.svg');

  /// File path: assets/icons/icon_arrow_forward_white.svg
  SvgGenImage get iconArrowForwardWhite =>
      const SvgGenImage('assets/icons/icon_arrow_forward_white.svg');

  /// File path: assets/icons/icon_close.svg
  SvgGenImage get iconClose => const SvgGenImage('assets/icons/icon_close.svg');

  /// File path: assets/icons/icon_refresh copy.svg
  SvgGenImage get iconRefreshCopy =>
      const SvgGenImage('assets/icons/icon_refresh copy.svg');

  /// File path: assets/icons/icon_refresh.svg
  SvgGenImage get iconRefresh =>
      const SvgGenImage('assets/icons/icon_refresh.svg');

  /// File path: assets/icons/icon_restart.svg
  SvgGenImage get iconRestart =>
      const SvgGenImage('assets/icons/icon_restart.svg');

  /// File path: assets/icons/icon_search.svg
  SvgGenImage get iconSearch =>
      const SvgGenImage('assets/icons/icon_search.svg');

  /// File path: assets/icons/icon_send.svg
  SvgGenImage get iconSend => const SvgGenImage('assets/icons/icon_send.svg');

  /// File path: assets/icons/icon_square.svg
  SvgGenImage get iconSquare =>
      const SvgGenImage('assets/icons/icon_square.svg');

  /// File path: assets/icons/icon_tool.svg
  SvgGenImage get iconTool => const SvgGenImage('assets/icons/icon_tool.svg');

  /// File path: assets/icons/icon_twitch.svg
  SvgGenImage get iconTwitch =>
      const SvgGenImage('assets/icons/icon_twitch.svg');

  /// File path: assets/icons/icon_user.svg
  SvgGenImage get iconUser => const SvgGenImage('assets/icons/icon_user.svg');

  /// File path: assets/icons/icon_youtube.svg
  SvgGenImage get iconYoutube =>
      const SvgGenImage('assets/icons/icon_youtube.svg');

  /// File path: assets/icons/minus.svg
  SvgGenImage get minus => const SvgGenImage('assets/icons/minus.svg');

  /// File path: assets/icons/minus_white.svg
  SvgGenImage get minusWhite =>
      const SvgGenImage('assets/icons/minus_white.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        closeCross,
        closeCrossWhite,
        iconArrowBack,
        iconArrowForward,
        iconArrowForwardWhite,
        iconClose,
        iconRefreshCopy,
        iconRefresh,
        iconRestart,
        iconSearch,
        iconSend,
        iconSquare,
        iconTool,
        iconTwitch,
        iconUser,
        iconYoutube,
        minus,
        minusWhite
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/plastic_transparent_cup.png
  AssetGenImage get plasticTransparentCup =>
      const AssetGenImage('assets/images/plastic_transparent_cup.png');

  /// List of all assets
  List<AssetGenImage> get values => [plasticTransparentCup];
}

class Assets {
  const Assets._();

  static const $AdditionalDataGen additionalData = $AdditionalDataGen();
  static const $AssetsAppLogoGen appLogo = $AssetsAppLogoGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
