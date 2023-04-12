import '../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/flutter_flow/flutter_flow_util.dart';

class Timezone {
  String value, text;

  Timezone(this.value, this.text);

  void setText(String val) => (text = val);
  void setValue(String val) => (value = val);

  @override
  String toString() {
    return text; //returns just the text
  }
}

class TimezonesContainer {
  List<Timezone> timeZones = [];
  List<String> textZones = [''];


  void add(Timezone value) {
    timeZones.add(value);
  }

  void remove(Timezone value) {
    timeZones.remove(value);
  }

  String getValue(String? val) {
    if (val == null) return '';
    int index = 0;
    for (var s in textZones) {
      if (s == val) break;
      ++index;
    }

    if (index < timeZones.length && index > -1) {
      return timeZones.elementAt(index).value;
    } else {
      return 'Invalid Index';
    }
  }

  String getText(String? val) {
    for (var s in timeZones) {
      if (s.value == val) return s.text;
    }
    return 'Invalid Value';
  }

  void generateTextZones() {
    textZones.clear();
    for (Timezone i in timeZones) {
      textZones.add(i.text);
    }
  }

  void setTimezones(List<Timezone> value) {
    timeZones = value;
  }

  Future<void> fetchTimezones() async {
    final response = await GetTimezonesCall.call(); //contact server
    if (response.succeeded) {
      // If the call to the server was successful, init timezones
      initTimezones(response.jsonBody);
    }
  }

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

    timeZones.clear();
    for (int i = 0; i < timezoneTexts.length; i++) {
      Timezone timezone =
      Timezone(timezoneValues.elementAt(i), timezoneTexts.elementAt(i));
      timeZones.add(timezone);
    }
    timeZones.toSet().toList();
    generateTextZones();
  }

}
