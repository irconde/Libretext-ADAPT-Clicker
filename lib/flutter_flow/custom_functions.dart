import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:adapt_clicker/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';

String createToken(String token) {
  return "Bearer $token";
}

String getTopError(List<String> errorList) {
  // get the first value out of the list
  return errorList.isEmpty ? 'empty' : errorList.first;
}

String questionSolution(bool? solution) {
  if (solution == null || !solution) {
    return "N/A";
  }
  return "Solution";
}

int addOne(int value) {
  return ++value;
}

bool isBasic(String techIframe) {
  return techIframe != '';
}

bool isTextSubmission(String textSubmission) {
  return (textSubmission == "text");
}

void rearrangeTimezones(dynamic timezoneAPI) {

  //TODO fix this function
  //jsonDecode(timezoneAPI);
  log("Changed Timezones" );
  for (String s in timezoneAPI)
  {
   // FFAppState().timezones.add(s);
  }

}
