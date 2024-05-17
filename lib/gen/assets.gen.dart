/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsWelcomeGen {
  const $AssetsWelcomeGen();

  /// File path: assets/welcome/welcome1.png
  AssetGenImage get welcome1 =>
      const AssetGenImage('assets/welcome/welcome1.png');

  /// File path: assets/welcome/welcome2.png
  AssetGenImage get welcome2 =>
      const AssetGenImage('assets/welcome/welcome2.png');

  /// File path: assets/welcome/welcome3_en.png
  AssetGenImage get welcome3En =>
      const AssetGenImage('assets/welcome/welcome3_en.png');

  /// File path: assets/welcome/welcome3_ru.png
  AssetGenImage get welcome3Ru =>
      const AssetGenImage('assets/welcome/welcome3_ru.png');

  /// File path: assets/welcome/welcome4_en.png
  AssetGenImage get welcome4En =>
      const AssetGenImage('assets/welcome/welcome4_en.png');

  /// File path: assets/welcome/welcome4_ru.png
  AssetGenImage get welcome4Ru =>
      const AssetGenImage('assets/welcome/welcome4_ru.png');

  /// File path: assets/welcome/welcome6_en.png
  AssetGenImage get welcome6En =>
      const AssetGenImage('assets/welcome/welcome6_en.png');

  /// File path: assets/welcome/welcome6_ru.png
  AssetGenImage get welcome6Ru =>
      const AssetGenImage('assets/welcome/welcome6_ru.png');

  /// File path: assets/welcome/welcomeDark1.png
  AssetGenImage get welcomeDark1 =>
      const AssetGenImage('assets/welcome/welcomeDark1.png');

  /// File path: assets/welcome/welcomeDark2.png
  AssetGenImage get welcomeDark2 =>
      const AssetGenImage('assets/welcome/welcomeDark2.png');

  /// File path: assets/welcome/welcomeDark3_en.png
  AssetGenImage get welcomeDark3En =>
      const AssetGenImage('assets/welcome/welcomeDark3_en.png');

  /// File path: assets/welcome/welcomeDark3_ru.png
  AssetGenImage get welcomeDark3Ru =>
      const AssetGenImage('assets/welcome/welcomeDark3_ru.png');

  /// File path: assets/welcome/welcomeDark4_en.png
  AssetGenImage get welcomeDark4En =>
      const AssetGenImage('assets/welcome/welcomeDark4_en.png');

  /// File path: assets/welcome/welcomeDark4_ru.png
  AssetGenImage get welcomeDark4Ru =>
      const AssetGenImage('assets/welcome/welcomeDark4_ru.png');

  /// File path: assets/welcome/welcomeDark6_en.png
  AssetGenImage get welcomeDark6En =>
      const AssetGenImage('assets/welcome/welcomeDark6_en.png');

  /// File path: assets/welcome/welcomeDark6_ru.png
  AssetGenImage get welcomeDark6Ru =>
      const AssetGenImage('assets/welcome/welcomeDark6_ru.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        welcome1,
        welcome2,
        welcome3En,
        welcome3Ru,
        welcome4En,
        welcome4Ru,
        welcome6En,
        welcome6Ru,
        welcomeDark1,
        welcomeDark2,
        welcomeDark3En,
        welcomeDark3Ru,
        welcomeDark4En,
        welcomeDark4Ru,
        welcomeDark6En,
        welcomeDark6Ru
      ];
}

class Assets {
  Assets._();

  static const AssetGenImage appLogo = AssetGenImage('assets/app_logo.png');
  static const AssetGenImage barChartIcon =
      AssetGenImage('assets/barChartIcon.png');
  static const AssetGenImage barChartPlug =
      AssetGenImage('assets/barChartPlug.png');
  static const AssetGenImage barModeIcon =
      AssetGenImage('assets/barModeIcon.png');
  static const AssetGenImage calendarIcon =
      AssetGenImage('assets/calendarIcon.png');
  static const AssetGenImage donutChartPlug =
      AssetGenImage('assets/donutChartPlug.png');
  static const AssetGenImage donutModeIcon =
      AssetGenImage('assets/donutModeIcon.png');
  static const AssetGenImage refreshIcon =
      AssetGenImage('assets/refreshIcon.png');
  static const AssetGenImage settingsIcon =
      AssetGenImage('assets/settingsIcon.png');
  static const $AssetsWelcomeGen welcome = $AssetsWelcomeGen();

  /// List of all assets
  static List<AssetGenImage> get values => [
        appLogo,
        barChartIcon,
        barChartPlug,
        barModeIcon,
        calendarIcon,
        donutChartPlug,
        donutModeIcon,
        refreshIcon,
        settingsIcon
      ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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
