import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/connectivity_status_management.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';

mixin ConnectionStateMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  void _showSnackbar(BuildContext context, ConnectivityStatus? status) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          status == ConnectivityStatus.isConnected
              ? Strings.connected
              : Strings.notConnected,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        backgroundColor: status == ConnectivityStatus.isConnected
            ? CColors.success
            : CColors.failure,
      ),
    );
  }

  bool checkConnection() {
    ConnectivityStatus? status =
        ref.read(provider.notifier).getConnectionStatus();
    if (status != ConnectivityStatus.isConnected) {
      _showSnackbar(context, status);
      return false;
    }
    return true;
  }

  void startWatchingConnection() {
    final AsyncValue<ConnectivityStatus> connectivityStatusProvider =
        ref.watch(provider);
    ConnectivityStatus? status;
    connectivityStatusProvider.whenData((value) => {status = value});
    if (status != null) {
      if (status != ConnectivityStatus.isConnected) {
        ref.read(provider.notifier).startWatchingConnectivity();
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (status == null || status == ConnectivityStatus.initializing) {
          return;
        }
        _showSnackbar(context, status!);
      });
    }
  }
}