import 'package:adapt_clicker/utils/timezone.dart';

/// Singleton class for managing the application state.
class AppState {
  static final AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  AppState._internal() {
    initializePersistedState();
  }

  /// Initializes the persisted state.
  Future initializePersistedState() async {}

  /// Holds the view.
  dynamic view;

  /// Indicates if an assignment is up.
  bool assignmentUp = false;

  /// Holds the question.
  dynamic question;

  /// Indicates if the app is in basic mode.
  bool isBasic = false;

  /// Indicates if there is a submission.
  bool hasSubmission = false;

  /// Container for storing timezones.
  static TimezonesContainer timezoneContainer = TimezonesContainer();

  /// User's timezone.
  static Timezone userTimezone = Timezone('UnsetV', 'Timezone');
}
