import 'package:adapt_clicker/flutter_flow/flutter_flow_util.dart';
import 'package:adapt_clicker/utils/check_internet_connectivity.dart';
import 'package:adapt_clicker/utils/timezone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

//Timezones come in form of value: example/example, text: example
void initTimezones(dynamic timezoneAPI) {
  //gets official values
  List<String> timezoneValues = (getJsonField(
    timezoneAPI,
    r'''$.time_zones..value''',
  ) as List)
      .map<String>((s) => s.toString())
      .toList()
      .toList();

  //Gets texts
  List<String> timezoneTexts = (getJsonField(
    timezoneAPI,
    r'''$.time_zones..text''',
  ) as List)
      .map<String>((s) => s.toString())
      .toList()
      .toList();

  List<Timezone> timezones = <Timezone>[];

  for (int i = 0; i < timezoneTexts.length; i++) {
    Timezone timezone =
        Timezone(timezoneValues.elementAt(i), timezoneTexts.elementAt(i));
    timezones.add(timezone);
  }

  timezones.toSet().toList();

  AppState.timezoneContainer = new TimezonesContainer(timezones);
}

bool equalsIgnoreCase(String? string1, String? string2) {
  return string1?.toLowerCase() == string2?.toLowerCase();
}

void showSnackbar(BuildContext context, ConnectivityStatus? status) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        status == ConnectivityStatus.isConnected
            ? 'Connected to Internet'
            : 'No Internet connection',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: status == ConnectivityStatus.isConnected
          ? const Color(0xFF008C3D)
          : const Color(0xFFD82828),
    ),
  );
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
  ]);
}
