import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:json_path/json_path.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
export '../utils/app_state.dart';
export 'dart:math' show min, max;
export 'dart:convert' show jsonEncode, jsonDecode;
export 'package:intl/intl.dart';
export 'package:page_transition/page_transition.dart';

String createToken(String token) {
  return 'Bearer $token';
}

String getTopError(List<String> errorList) {
  // get the first value out of the list
  return errorList.isEmpty ? 'empty' : errorList.first;
}

String questionSolution(bool? solution) {
  if (solution == null || !solution) {
    return 'N/A';
  }
  return 'Solution';
}

int addOne(int value) {
  return ++value;
}

bool isBasic(String techIframe) {
  return techIframe != '';
}

bool isTextSubmission(String textSubmission) {
  return (textSubmission == 'text');
}

bool equalsIgnoreCase(String? string1, String? string2) {
  return string1?.toLowerCase() == string2?.toLowerCase();
}

void preloadSVGs() async {
  // Preload SVG used in the next screen to avoid rendering delays
  Future.wait([
    // LibreTexts ADAPT logo
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
          'assets/images/libretexts_adapt_logo.svg'),
      null,
    ),
    // Hand icon
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
          'assets/images/hand_wave.svg'),
      null,
    ),
    // Book icon
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
          'assets/images/book_icon.svg'),
      null,
    ),
    // Lock icon
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
          'assets/images/lock.svg'),
      null,
    ),
    // Person add
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
          'assets/images/person_add1.svg'),
      null,
    ),
    // Contact support
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
          'assets/images/contact_support.svg'),
      null,
    ),
    // LibreTexts logo
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
          'assets/images/libretexts_logo.svg'),
      null,
    ),
    // No notifications placeholder image
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
          'assets/images/no_notifications.svg'),
      null,
    ),
    // No courses placeholder image
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderOutsideViewBoxBuilder,
          'assets/images/no_courses.svg'),
      null,
    ),
  ]);

}

Future mLaunchUrl(String url) async {
  var uri = Uri.parse(url);
  try {
    await canLaunchUrl(uri);
    await launchUrl(uri);
  } catch (e) {
    logger.e('Could not launch $uri: $e');
  }
}

extension DateTimeComparisonOperators on DateTime {
  bool operator <(DateTime other) => isBefore(other);
  bool operator >(DateTime other) => isAfter(other);
  bool operator <=(DateTime other) => this < other || isAtSameMomentAs(other);
  bool operator >=(DateTime other) => this > other || isAtSameMomentAs(other);
}

dynamic getJsonField(
    dynamic response,
    String jsonPath, [
      bool isForList = false,
    ]) {
  final field = JsonPath(jsonPath).read(response);
  if (field.isEmpty) {
    return null;
  }
  if (field.length > 1) {
    return field.map((f) => f.value).toList();
  }
  final value = field.first.value;
  return isForList && value is! Iterable ? [value] : value;
}

extension FFStringExt on String {
  String maybeHandleOverflow({int? maxChars, String replacement = ''}) =>
      maxChars != null && length > maxChars
          ? replaceRange(maxChars, null, replacement)
          : this;
}
