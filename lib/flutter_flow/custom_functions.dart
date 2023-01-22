import 'package:adapt_clicker/flutter_flow/flutter_flow_util.dart';
import 'package:adapt_clicker/timezone.dart';

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
        new Timezone(timezoneValues.elementAt(i), timezoneTexts.elementAt(i));
    timezones.add(timezone);
  }

  FFAppState.timezoneContainer = new TimezonesContainer(timezones);
}
