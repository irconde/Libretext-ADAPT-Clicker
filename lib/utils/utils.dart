import 'package:flutter_svg/flutter_svg.dart';
import 'package:json_path/json_path.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
export '../utils/app_state.dart';
export 'dart:math' show min, max;
export 'dart:convert' show jsonEncode, jsonDecode;
export 'package:intl/intl.dart';
export 'package:page_transition/page_transition.dart';

/// Creates a token string with the provided token.
String createToken(String token) {
  return 'Bearer $token';
}

/// Gets the top error from a list of errors.
String getTopError(List<String> errorList) {
  // Get the first value out of the list
  return errorList.isEmpty ? 'empty' : errorList.first;
}

/// Returns a string representing the solution based on a boolean value.
/// Returns 'N/A' if the solution is null or false, otherwise returns 'Solution'.
String questionSolution(bool? solution) {
  if (solution == null || !solution) {
    return 'N/A';
  }
  return 'Solution';
}

/// Adds one to the provided value and returns the result.
int addOne(int value) {
  return ++value;
}

/// Checks if the provided tech iframe is considered basic.
/// Returns true if the iframe is not empty, false otherwise.
bool isBasic(String techIframe) {
  return techIframe != '';
}

/// Checks if the provided text submission is of type 'text'.
/// Returns true if the submission is 'text', false otherwise.
bool isTextSubmission(String textSubmission) {
  return (textSubmission == 'text');
}

/// Compares two strings case-insensitively.
/// Returns true if the strings are equal (ignoring case), false otherwise.
bool equalsIgnoreCase(String? string1, String? string2) {
  return string1?.toLowerCase() == string2?.toLowerCase();
}

/// Preloads SVG images to avoid rendering delays on the next screen.
/// This function asynchronously precaches a list of SVG images.
void preloadSVGs() async {
  await Future.wait([
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

/// Launches a URL using the device's default browser.
/// Takes a [url] as input and tries to launch it.
/// If the launch is successful, the URL is opened in the browser.
/// If the launch fails, an error message is logged.
Future<void> mLaunchUrl(String url) async {
  var uri = Uri.parse(url);
  try {
    await canLaunchUrl(uri);
    await launchUrl(uri);
  } catch (e) {
    logger.e('Could not launch $uri: $e');
  }
}

/// Extension on [DateTime] class to provide comparison operators.
extension DateTimeComparisonOperators on DateTime {
  bool operator <(DateTime other) => isBefore(other);
  bool operator >(DateTime other) => isAfter(other);
  bool operator <=(DateTime other) => this < other || isAtSameMomentAs(other);
  bool operator >=(DateTime other) => this > other || isAtSameMomentAs(other);
}

/// Retrieves a field from a JSON response using a JSON path.
/// Takes a [response] and a [jsonPath] as input.
/// Optionally, [isForList] can be set to true if the field is expected to be a list.
/// Returns the value of the field if found, or null if not found.
/// If [isForList] is true and the value is not a list, it is wrapped in a list.
dynamic getJsonField(dynamic response, String jsonPath,
    [bool isForList = false]) {
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

/// Extension on [String] class to handle overflow in a string.
/// Takes an optional [maxChars] parameter to limit the maximum number of characters.
/// If the length of the string is greater than [maxChars],
/// the excess characters are replaced with the specified [replacement] string.
/// Returns the modified string.
extension FFStringExt on String {
  String maybeHandleOverflow({int? maxChars, String replacement = ''}) =>
      maxChars != null && length > maxChars
          ? replaceRange(maxChars, null, replacement)
          : this;
}
