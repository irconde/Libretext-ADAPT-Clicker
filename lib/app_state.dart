import 'package:adapt_clicker/timezone.dart';
import 'flutter_flow/lat_lng.dart';
import 'dart:convert';

class AppState {
  static final AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {}

  List<String> errorsList = [];

  dynamic view;

  bool assignmentUp = false;

  dynamic question;

  bool isBasic = false;

  bool hasSubmission = false;

  static TimezonesContainer? timezoneContainer;
  static Timezone? userTimezone = Timezone('UnsetV', 'UnsetT');

  LatLng? _latLngFromString(String? val) {
    if (val == null) {
      return null;
    }
    final split = val.split(',');
    final lat = double.parse(split.first);
    final lng = double.parse(split.last);
    return LatLng(lat, lng);
  }
}
