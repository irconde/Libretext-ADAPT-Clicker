import 'package:adapt_clicker/components/timezone_dropdown.dart';
import 'package:adapt_clicker/components/drawer_ctn.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/MainAppBar.dart';
import '../components/form_state_mixin.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../gen/assets.gen.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../utils/stored_preferences.dart';

class UpdateProfilePageWidget extends ConsumerStatefulWidget {
  const UpdateProfilePageWidget({Key? key, required this.onSubmit})
      : super(key: key);
  final ValueChanged<String?> onSubmit;

  @override
  ConsumerState<UpdateProfilePageWidget> createState() =>
      _UpdateProfilePageWidgetState();
}

class _UpdateProfilePageWidgetState
    extends ConsumerState<UpdateProfilePageWidget> with FormStateMixin {
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String studentId = 'student_id';
  static const String timeZone = 'time_zone';

  ApiCallResponse? _userInfoRequest;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;
  String? _email;

  @override
  void initState() {
    super.initState();
    requiredFields = [firstName, lastName, studentId];
    formValues[firstName] = [null, null];
    formValues[lastName] = [null, null];
    formValues[studentId] = [null, null];
    formValues[timeZone] = [null, null];
    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState(() {
          _isKeyboardVisible = visible;
        });
      });
    }
    updateUserInfo();
  }

  Future<void> updateUserInfo() async {
    String currentFirstName = '',
        currentLastName = '',
        currentEmail = '',
        currentStudentId = '';
    _userInfoRequest = await GetUserCall.call(
      token: StoredPreferences.authToken,
    );
    if ((_userInfoRequest?.succeeded ?? true)) {
      currentFirstName =
          getJsonField(_userInfoRequest!.jsonBody, r'''$.first_name''')
              .toString();
      currentLastName =
          getJsonField(_userInfoRequest!.jsonBody, r'''$.last_name''')
              .toString();
      currentEmail =
          getJsonField(_userInfoRequest!.jsonBody, r'''$.email''').toString();
      currentStudentId =
          getJsonField(_userInfoRequest!.jsonBody, r'''$.student_id''')
              .toString();
      AppState.userTimezone!.setValue(
          getJsonField(_userInfoRequest!.jsonBody, r'''$.time_zone''')
              .toString());
      AppState.userTimezone!.setText(timeZone);
      setState(() {
        formValues[firstName] = [currentFirstName, null];
        formValues[lastName] = [currentLastName, null];
        formValues[studentId] = [currentStudentId, null];
        formValues[timeZone] = [
          AppState.timezoneContainer!
              .getText(AppState.userTimezone!.value)
              .toString(),
          null
        ];
        _email = currentEmail;
      });
    }
  }

  void _submit() async {
    if (!checkConnection()) return;
    serverRequest = await UpdateProfileCall.call(
        token: StoredPreferences.authToken,
        firstName: formValues[firstName][dataIndex],
        lastName: formValues[lastName][dataIndex],
        email: _email,
        timeZone: AppState.timezoneContainer
                ?.getValue(AppState.userTimezone.toString()) ??
            AppState.timezoneContainer!.timeZones.first.value,
        studentId: formValues[studentId][dataIndex]);
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Profile Updated Successfully',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryBtnText,
            ),
          ),
          duration: const Duration(milliseconds: Constants.snackBarDurationMil),
          backgroundColor: FlutterFlowTheme.of(context).success,
        ),
      );
    } else {
      final errors =
          getJsonField((serverRequest?.jsonBody ?? ''), r'''$.errors''');
      onReceivedErrorsFromServer(errors);
    }
  }

  @override
  void dispose() {
    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: MainAppBar(
          title: 'My Profile',
          scaffoldKey: scaffoldKey,
          setState: (VoidCallback fn) {
            setState(fn);
          }),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      drawer: const DrawerCtnWidget(currentSelected: DrawerItems.profile),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          Constants.mmMargin,
                          Constants.mmMargin,
                          Constants.mmMargin,
                          0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.msMargin),
                            child: TextFormField(
                                autofocus: true,
                                initialValue: formValues[firstName][dataIndex],
                                decoration: InputDecoration(
                                  labelText: 'First Name*',
                                  errorText: submitted
                                      ? formValues[firstName][errorIndex]
                                      : null,
                                  hintText: 'John',
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.person_outline,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    formValues[firstName] = [value, null];
                                    requiredFieldsFilled =
                                        checkRequiredFieldsFilled(
                                            formValues, requiredFields);
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.msMargin),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Last Name*',
                                  errorText: submitted
                                      ? formValues[lastName][errorIndex]
                                      : null,
                                  hintText: 'Doe',
                                  prefixIcon: const Icon(
                                    Icons.person_outline,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    formValues[lastName] = [value, null];
                                    requiredFieldsFilled =
                                        checkRequiredFieldsFilled(
                                            formValues, requiredFields);
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.msMargin),
                            child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Student ID*',
                                  errorText: submitted
                                      ? formValues[studentId][errorIndex]
                                      : null,
                                  hintText: 'example@gmail.com',
                                  prefixIcon: const Icon(
                                    Icons.school_outlined,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    formValues[studentId] = [value, null];
                                    requiredFieldsFilled =
                                        checkRequiredFieldsFilled(
                                            formValues, requiredFields);
                                  });
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.smMargin),
                            child: TimezoneDropdown(
                                timezoneDropDownValue: formValues[timeZone]
                                    [dataIndex]),
                          ),
                          Align(
                            alignment: const Alignment(1, 0),
                            child: Text(
                              '*Required Fields',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Open Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                    fontSize: Constants.requiredTextSize,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!(isWeb
                    ? MediaQuery.of(context).viewInsets.bottom > 0
                    : _isKeyboardVisible))
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        Constants.mmMargin, 0, Constants.mmMargin, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            const Size.fromHeight(Constants.buttonHeight),
                        backgroundColor:
                            FlutterFlowTheme.of(context).primaryColor,
                        textStyle: FlutterFlowTheme.of(context).title3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: requiredFieldsFilled ? _submit : null,
                      child: const Text('UPDATE PROFILE'),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
