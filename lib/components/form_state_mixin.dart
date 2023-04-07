import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_manager.dart';
import '../utils/check_internet_connectivity.dart';
import '../flutter_flow/custom_functions.dart' as functions;

mixin FormStateMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final int dataIndex = 0;
  final int errorIndex = 1;
  final Map<String, dynamic> formValues = {};
  bool submitted = false;
  bool requiredFieldsFilled = false;
  List<String> requiredFields = [];
  ApiCallResponse? serverRequest;

  bool checkRequiredFieldsFilled(
      Map<String, dynamic> formData, List<String> requiredFields) {
    for (String field in requiredFields) {
      if (formData[field][dataIndex] == null ||
          formData[field][dataIndex].isEmpty) {
        return false;
      }
    }
    return true;
  }

  bool checkConnection() {
    ConnectivityStatus? status =
        ref.read(provider.notifier).getConnectionStatus();
    if (status != ConnectivityStatus.isConnected) {
      functions.showSnackbar(context, status);
      return false;
    }
    return true;
  }

  void onReceivedErrorsFromServer(dynamic errors) {
    setState(() => submitted = true);
    Map<String, dynamic> errorData = Map<String, dynamic>.from(errors);
    for (String key in errorData.keys) {
      setState(() {
        formValues[key][errorIndex] = errorData[key][0];
      });
    }
  }
}
