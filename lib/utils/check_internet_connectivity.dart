import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ConnectivityStatus {
  initializing,
  notDetermined,
  isConnected,
  isDisconnected
}

final provider =
    AsyncNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>(() {
  return ConnectivityStatusNotifier();
});

class ConnectivityStatusNotifier extends AsyncNotifier<ConnectivityStatus> {
  bool firstTime = true;
  bool startedListening = false;

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
    }
    return newState;
  }

  @override
  Future<ConnectivityStatus> build() async {
    final ConnectivityResult initConnection =
        await Connectivity().checkConnectivity();
    ConnectivityStatus connectionStatus = _resultToStatus(initConnection);
    if (firstTime) {
      if (connectionStatus == ConnectivityStatus.isConnected) {
        connectionStatus = ConnectivityStatus.initializing;
      }
      firstTime = !firstTime;
    }
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (startedListening) {
        ConnectivityStatus newState = _resultToStatus(result);
        state = AsyncValue.data(newState);
      }
      if (!startedListening) {
        startedListening = !startedListening;
        if (state.value == ConnectivityStatus.isDisconnected) {
          state = AsyncValue.data(_resultToStatus(result));
        }
      }
    });

    return connectionStatus;
  }
}
