import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_manager.dart';

enum FormStateValue { unfilled, normal, processing, error, success }

mixin FormStateMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final int dataIndex = 0;
  final int errorIndex = 1;
  final int focusNodeIndex = 2;
  final Map<String, dynamic> formValues = {};
  bool submitted = false;
  bool requiredFieldsFilled = false;
  FormStateValue formState = FormStateValue.unfilled;
  List<String> requiredFields = [];
  List<String> formFields = [];
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

  void initFormFieldsInfo() {
    for (String formFieldId in formFields) {
      formValues[formFieldId] = [null, null, FocusNode()];
    }
  }

  void disposeFocusNodes() {
    List<MapEntry<String, dynamic>> formItems = formValues.entries.toList();
    for (MapEntry formItem in formItems) {
      FocusNode focusNode = formItem.value[focusNodeIndex] as FocusNode;
      focusNode.dispose();
    }
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
