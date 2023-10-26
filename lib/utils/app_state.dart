import 'package:adapt_clicker/backend/Router/app_router.dart';
import 'package:adapt_clicker/utils/timezone.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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

  Cookie cookie = Cookie(name: '', value: null);

  final router = AppRouter();

  /// Holds the view.
  dynamic view;

  ///Holds Question IDs from View Call
  List<int> questionIDs = [];

  ///Holds Question urls from View Call
  List<String> urls = [];


  /// Indicates if an assignment is up.
  bool assignmentUp = false;

  /// Indicates if the app is in basic mode.
  int assignmentId = 0;


  /// Container for storing timezones.
  static TimezonesContainer timezoneContainer = TimezonesContainer();

  /// User's timezone.
  static Timezone userTimezone = Timezone('UnsetV', 'Timezone');
}
