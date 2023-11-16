import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/logger.dart';

/// Represents the possible connectivity statuses.
enum ConnectivityStatus {
  initializing,
  notDetermined,
  isConnected,
  isDisconnected
}

/// Provider for the connectivity status notifier.
final provider =
    AsyncNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(() {
  return ConnectivityStatusNotifier();
});

/// Notifier for the connectivity status.
class ConnectivityStatusNotifier extends AsyncNotifier<ConnectivityStatus> {
  ConnectivityStatus _lastState = ConnectivityStatus.notDetermined;
  bool _startedListening = false;

  /// Converts the [ConnectivityResult] to [ConnectivityStatus].
  ConnectivityStatus _resultToStatus(ConnectivityResult connectionResult) {
    ConnectivityStatus newState = ConnectivityStatus.notDetermined;
    switch (connectionResult) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        newState = ConnectivityStatus.isConnected;
        break;
      case ConnectivityResult.none:
        newState = ConnectivityStatus.isDisconnected;
        break;
      default:
        logger.e('Unknown Connectivity Status found');
        break;
    }
    return newState;
  }

  /// Starts listening to connectivity changes.
  void startWatchingConnectivity() {
    if (_startedListening) return;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      ConnectivityStatus newState = _resultToStatus(result);
      if (newState != _lastState) {
        _lastState = newState;
        state = AsyncData(newState);
      }
    });
    _startedListening = true;
  }

  @override
  Future<ConnectivityStatus> build() async {
    ConnectivityStatus connectionStatus = ConnectivityStatus.notDetermined;
    final ConnectivityResult initConnection =
        await Connectivity().checkConnectivity();
    ConnectivityStatus auxConnectionStatus = _resultToStatus(initConnection);
    if (auxConnectionStatus == ConnectivityStatus.isConnected) {
      connectionStatus = ConnectivityStatus.initializing;
    } else {
      connectionStatus = auxConnectionStatus;
    }
    _lastState = auxConnectionStatus;
    return connectionStatus;
  }

  /// Gets the current connection status.
  ConnectivityStatus getConnectionStatus() {
    return _lastState;
  }
}
