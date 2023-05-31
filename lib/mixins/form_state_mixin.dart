import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_manager.dart';

/// Represents the possible states of a form.
enum FormStateValue {
  /// The form is unfilled and incomplete.
  unfilled,

  /// The form is filled and ready for submission.
  normal,

  /// The form is currently being processed.
  processing,

  /// There was an error during form submission.
  error,

  /// The form submission was successful.
  success,
}

/// A mixin that provides form state management functionality to a [ConsumerStatefulWidget].
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

  /// Checks if all required fields in the form are filled.
  ///
  /// Returns `true` if all required fields are filled, `false` otherwise.
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

  /// Initializes the form fields information in the [formValues] map.
  void initFormFieldsInfo() {
    for (String formFieldId in formFields) {
      formValues[formFieldId] = [null, null, FocusNode()];
    }
  }

  /// Disposes the focus nodes used in the form fields.
  void disposeFocusNodes() {
    List<MapEntry<String, dynamic>> formItems = formValues.entries.toList();
    for (MapEntry formItem in formItems) {
      FocusNode focusNode = formItem.value[focusNodeIndex] as FocusNode;
      focusNode.dispose();
    }
  }

  /// Checks if the form is ready to be submitted.
  ///
  /// Updates the [requiredFieldsFilled] and [formState] variables accordingly.
  void checkFormIsReadyToSubmit() {
    setState(() {
      requiredFieldsFilled =
          areRequiredFieldsFilled(formValues, requiredFields);
      formState = requiredFieldsFilled
          ? FormStateValue.normal
          : FormStateValue.unfilled;
    });
  }

  /// Handles the errors received from the server after form submission.
  ///
  /// Updates the [submitted] and [formState] variables, and sets error messages for the respective form fields.
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
