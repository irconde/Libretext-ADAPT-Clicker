import '../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/utils/utils.dart';

/// Represents a timezone.
class Timezone {
  /// The value of the timezone.
  String value;

  /// The text representation of the timezone.
  String text;

  /// Creates a new instance of [Timezone] with the given [value] and [text].
  Timezone(this.value, this.text);

  /// Sets the text value of the timezone.
  void setText(String val) => text = val;

  /// Sets the value of the timezone.
  void setValue(String val) => value = val;

  @override
  String toString() {
    return text; // Returns just the text representation of the timezone.
  }
}

/// Represents a container for timezones.
class TimezonesContainer {
  /// The list of timezones.
  List<Timezone> timeZones = [];

  /// The list of text representations of timezones.
  List<String> textZones = [''];

  /// Adds a [Timezone] to the container.
  void add(Timezone value) {
    timeZones.add(value);
  }

  /// Removes a [Timezone] from the container.
  void remove(Timezone value) {
    timeZones.remove(value);
  }

  /// Gets the value of a timezone based on its text representation.
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

  /// Gets the text representation of a timezone based on its value.
  String getText(String? val) {
    for (var s in timeZones) {
      if (s.value == val) return s.text;
    }
    return 'Invalid Value';
  }

  /// Generates the list of text representations of timezones.
  void generateTextZones() {
    textZones.clear();
    for (Timezone i in timeZones) {
      textZones.add(i.text);
    }
  }

  /// Sets the list of timezones.
  void setTimezones(List<Timezone> value) {
    timeZones = value;
  }

  /// Initializes the timezones by contacting the server.
  Future<void> initTimezones() async {
    if (timeZones.isEmpty) {
      final response = await GetTimezonesCall.call(); // Contact server
      if (response.succeeded) {
        // If the call to the server was successful, initialize timezones
        fetchTimezones(response.jsonBody);
      }
    }
  }

  /// Fetches the timezones from the API response.
  void fetchTimezones(dynamic timezoneAPI) {
    // Gets official values
    List<String> timezoneValues = (getJsonField(
      timezoneAPI,
      r'''$.time_zones..value''',
    ) as List)
        .map<String>((s) => s.toString())
        .toList()
        .toList();

    // Gets texts
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
