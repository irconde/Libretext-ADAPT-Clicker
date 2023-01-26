/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAudiosGen {
  const $AssetsAudiosGen();

  /// File path: assets/audios/favicon.png
  AssetGenImage get favicon => const AssetGenImage('assets/audios/favicon.png');
}

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/favicon.png
  AssetGenImage get favicon => const AssetGenImage('assets/fonts/favicon.png');
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Course_placeholder_img.png
  AssetGenImage get coursePlaceholderImg =>
      const AssetGenImage('assets/images/Course_placeholder_img.png');

  /// File path: assets/images/favicon.png
  AssetGenImage get favicon => const AssetGenImage('assets/images/favicon.png');

  /// File path: assets/images/libreAddPerson.png
  AssetGenImage get libreAddPerson =>
      const AssetGenImage('assets/images/libreAddPerson.png');

  /// File path: assets/images/libreHand.png
  AssetGenImage get libreHand =>
      const AssetGenImage('assets/images/libreHand.png');

  /// File path: assets/images/libreQuestion.png
  AssetGenImage get libreQuestion =>
      const AssetGenImage('assets/images/libreQuestion.png');

  /// File path: assets/images/libretexts_logo_main_white.png
  AssetGenImage get libretextsLogoMainWhite =>
      const AssetGenImage('assets/images/libretexts_logo_main_white.png');

  /// File path: assets/images/libretexts_logo_stacked_blue.png
  AssetGenImage get libretextsLogoStackedBlue =>
      const AssetGenImage('assets/images/libretexts_logo_stacked_blue.png');

  /// File path: assets/images/lock.png
  AssetGenImage get lock => const AssetGenImage('assets/images/lock.png');

  /// File path: assets/images/no_notifications.png
  AssetGenImage get noNotifications =>
      const AssetGenImage('assets/images/no_notifications.png');
}

class $AssetsLottieAnimationsGen {
  const $AssetsLottieAnimationsGen();

  /// File path: assets/lottie_animations/favicon.png
  AssetGenImage get favicon =>
      const AssetGenImage('assets/lottie_animations/favicon.png');
}

class $AssetsPdfsGen {
  const $AssetsPdfsGen();

  /// File path: assets/pdfs/favicon.png
  AssetGenImage get favicon => const AssetGenImage('assets/pdfs/favicon.png');
}

class $AssetsRiveAnimationsGen {
  const $AssetsRiveAnimationsGen();

  /// File path: assets/rive_animations/favicon.png
  AssetGenImage get favicon =>
      const AssetGenImage('assets/rive_animations/favicon.png');
}

class $AssetsVideosGen {
  const $AssetsVideosGen();

  /// File path: assets/videos/favicon.png
  AssetGenImage get favicon => const AssetGenImage('assets/videos/favicon.png');
}

class Assets {
  Assets._();

  static const $AssetsAudiosGen audios = $AssetsAudiosGen();
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieAnimationsGen lottieAnimations =
      $AssetsLottieAnimationsGen();
  static const $AssetsPdfsGen pdfs = $AssetsPdfsGen();
  static const $AssetsRiveAnimationsGen riveAnimations =
      $AssetsRiveAnimationsGen();
  static const $AssetsVideosGen videos = $AssetsVideosGen();
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

  String get path => _assetName;

  String get keyName => _assetName;
}

class Constants {
  //FontSizes
  static const double drawerIconSize = 28;
  static const double defaultTextSize = 14;
  static const double requiredTextSize = 12;

  //Widgets
  static const double buttonHeight = 36;
  static const int snackBarDurationMil = 4000; //milliseconds
  static const int snackBarDurationSec = 4; //seconds
  static const double TFIconSize = 21; //seconds

  //Intro pages AppBar
  static const double appBarHeight = 240.0;
  static const double appBarTransitionMin = 80;
  static const double appBarTitleOffset = 32; //higher means closer to top
  static const double appBarTitleSpeed = 2; //higher means slower

  static const double xlMargin = 68;
  static const double llMargin = 48; //Double spaced
  static const double lmMargin = 44; //
  static const double lsMargin = 40; //
  static const double mlMargin = 36; //margin with a little extra
  static const double mmMargin =
      32; //margin around edge of the pages mainly in intro
  static const double msMargin = 24; // 2/3 page margin, used in a few widgets
  static const double sMargin =
      16; //half page margin and used in several widgets
  static const double smMargin = 12; // 1/3 page margin, used in a few widgets
  static const double xsMargin =
      8; //quarter page margin used in between widgets
  static const double xxsMargin = 4; //smallest margin used to offset text
  static const double dividerThickness =
      1; //smallest margin used to offset text
}
