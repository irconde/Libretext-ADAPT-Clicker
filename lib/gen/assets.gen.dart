/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/already_checked_in.svg
  String get alreadyCheckedIn => 'assets/images/already_checked_in.svg';

  /// File path: assets/images/book_icon.svg
  String get bookIcon => 'assets/images/book_icon.svg';

  /// File path: assets/images/calendar_icon.svg
  String get calendarIcon => 'assets/images/calendar_icon.svg';

  /// File path: assets/images/checked_in.svg
  String get checkedIn => 'assets/images/checked_in.svg';

  /// File path: assets/images/code_to_join.svg
  String get codeToJoin => 'assets/images/code_to_join.svg';

  /// File path: assets/images/contact_support.svg
  String get contactSupport => 'assets/images/contact_support.svg';

  /// File path: assets/images/event_expired.svg
  String get eventExpired => 'assets/images/event_expired.svg';

  /// File path: assets/images/event_not_active.svg
  String get eventNotActive => 'assets/images/event_not_active.svg';

  /// File path: assets/images/hand_wave.svg
  String get handWave => 'assets/images/hand_wave.svg';

  /// File path: assets/images/home_artboard.svg
  String get homeArtboard => 'assets/images/home_artboard.svg';

  /// File path: assets/images/launch_image.png
  AssetGenImage get launchImage =>
      const AssetGenImage('assets/images/launch_image.png');

  /// File path: assets/images/libretexts_adapt_logo.svg
  String get libretextsAdaptLogo => 'assets/images/libretexts_adapt_logo.svg';

  /// File path: assets/images/libretexts_logo.svg
  String get libretextsLogo => 'assets/images/libretexts_logo.svg';

  /// File path: assets/images/lock.svg
  String get lock => 'assets/images/lock.svg';

  /// File path: assets/images/no_courses.svg
  String get noCourses => 'assets/images/no_courses.svg';

  /// File path: assets/images/no_notifications.svg
  String get noNotifications => 'assets/images/no_notifications.svg';

  /// File path: assets/images/person_add1.svg
  String get personAdd1 => 'assets/images/person_add1.svg';

  /// List of all assets
  List<dynamic> get values => [
        alreadyCheckedIn,
        bookIcon,
        calendarIcon,
        checkedIn,
        codeToJoin,
        contactSupport,
        eventExpired,
        eventNotActive,
        handWave,
        homeArtboard,
        launchImage,
        libretextsAdaptLogo,
        libretextsLogo,
        lock,
        noCourses,
        noNotifications,
        personAdd1
      ];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
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
