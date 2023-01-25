import 'package:adapt_clicker/timezone.dart';

class AppState {
  static final AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
  }

  List<String> errorsList = [];

  dynamic view;

  bool assignmentUp = false;

  dynamic question;

  bool isBasic = false;

  bool hasSubmission = false;

  static TimezonesContainer? timezoneContainer;
}
