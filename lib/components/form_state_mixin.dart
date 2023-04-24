import 'package:adapt_clicker/components/custom_elevated_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_manager.dart';
import '../utils/check_internet_connectivity.dart';
import '../flutter_flow/custom_functions.dart' as functions;

enum FormStateValue { unfilled, normal, processing, error, success }

mixin FormStateMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final int dataIndex = 0;
  final int errorIndex = 1;
  final Map<String, dynamic> formValues = {};
  bool submitted = false;
  bool requiredFieldsFilled = false;
  FormStateValue formState = FormStateValue.unfilled;
  List<String> requiredFields = [];
  ApiCallResponse? serverRequest;

  bool areRequiredFieldsFilled(
      Map<String, dynamic> formData, List<String> requiredFields) {
    for (String field in requiredFields) {
      if (formData[field][dataIndex] == null ||
          formData[field][dataIndex].isEmpty) {
        return false;
      }
    }
    return true;
  }

  void checkFormIsReadyToSubmit() {
    setState(() {
      requiredFieldsFilled =
          areRequiredFieldsFilled(formValues, requiredFields);
      formState = requiredFieldsFilled
          ? FormStateValue.normal
          : FormStateValue.unfilled;
    });
  }

  void onReceivedErrorsFromServer(dynamic errors) {
    setState(() {
      submitted = true;
      formState = FormStateValue.error;
    });
    Map<String, dynamic> errorData = Map<String, dynamic>.from(errors);
    for (String key in errorData.keys) {
      setState(() {
        formValues[key][errorIndex] = errorData[key][0];
      });
    }
  }
}
