import 'package:adapt_clicker/components/timezone_dropdown.dart';
import 'package:adapt_clicker/components/drawer_ctn.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/custom_elevated_button.dart';
import '../components/main_app_bar.dart';
import '../components/form_state_mixin.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../utils/constants.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../utils/stored_preferences.dart';

@RoutePage()
class UpdateProfilePageWidget extends ConsumerStatefulWidget {
  const UpdateProfilePageWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<UpdateProfilePageWidget> createState() =>
      _UpdateProfilePageWidgetState();
}

class _UpdateProfilePageWidgetState
    extends ConsumerState<UpdateProfilePageWidget> with FormStateMixin {
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String email = 'email';
  static const String studentId = 'student_id';
  static const String timeZone = 'time_zone';

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;
  late Future<Map<String, String>> _initialProfileValues;

  @override
  void initState() {
    super.initState();
    _initialProfileValues = _loadInitialUserInfo();
    requiredFields = [firstName, lastName, studentId];
    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState(() {
          _isKeyboardVisible = visible;
        });
      });
    }
  }

  Future<Map<String, String>> _loadInitialUserInfo() async {
    Map<String, String> currentUserInfo = {};
    final userInfoRequest = await GetUserCall.call(
      token: StoredPreferences.authToken,
    );
    await AppState.timezoneContainer.initTimezones();
    if (userInfoRequest.succeeded) {
      currentUserInfo[firstName] =
          getJsonField(userInfoRequest.jsonBody, r'''$.first_name''')
              .toString();
      currentUserInfo[lastName] =
          getJsonField(userInfoRequest.jsonBody, r'''$.last_name''').toString();
      currentUserInfo[email] =
          getJsonField(userInfoRequest.jsonBody, r'''$.email''').toString();
      currentUserInfo[studentId] =
          getJsonField(userInfoRequest.jsonBody, r'''$.student_id''')
              .toString();
      currentUserInfo[timeZone] = AppState.timezoneContainer
          .getText(getJsonField(userInfoRequest.jsonBody, r'''$.time_zone''')
              .toString())
          .toString();
    }
    _initFormData(currentUserInfo);
    return currentUserInfo;
  }

  void _initFormData(Map<String, String> inputValues) {
    setState(() {
      formValues[firstName] = [inputValues[firstName], null];
      formValues[lastName] = [inputValues[lastName], null];
      formValues[studentId] = [inputValues[studentId], null];
      formValues[email] = [inputValues[email], null];
      formValues[timeZone] = [inputValues[timeZone], null];
    });
    checkFormIsReadyToSubmit();
  }

  void onTimezoneSelected(timezone) {
    setState(() {
      formValues[timeZone] = [timezone, null];
    });
  }

  void _submit() async {
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    serverRequest = await UpdateProfileCall.call(
        token: StoredPreferences.authToken,
        firstName: formValues[firstName][dataIndex],
        lastName: formValues[lastName][dataIndex],
        email: formValues[email][dataIndex],
        timeZone: AppState.timezoneContainer
            .getValue(formValues[timeZone][dataIndex]),
        studentId: formValues[studentId][dataIndex]);
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      setState(() {});
      setState(() {
        formState = FormStateValue.success;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          formState = FormStateValue.normal;
        });
      });
    } else {
      setState(() {
        formState = FormStateValue.error;
      });
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
          child: FutureBuilder<Map<String, String>>(
              future: _initialProfileValues,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
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
                            child: Form(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, Constants.msMargin),
                                    child: TextFormField(
                                        autofocus: true,
                                        initialValue: snapshot.data?[firstName],
                                        decoration: InputDecoration(
                                          labelText: 'First Name*',
                                          errorText: submitted
                                              ? formValues[firstName]
                                                  [errorIndex]
                                              : null,
                                          hintText: 'John',
                                          filled: true,
                                          prefixIcon: const Icon(
                                            Icons.person_outline,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            formValues[firstName] = [
                                              value,
                                              null
                                            ];
                                          });
                                          checkFormIsReadyToSubmit();
                                        }),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, Constants.msMargin),
                                    child: TextFormField(
                                        initialValue: snapshot.data?[lastName],
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
                                            formValues[lastName] = [
                                              value,
                                              null
                                            ];
                                          });
                                          checkFormIsReadyToSubmit();
                                        }),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, Constants.msMargin),
                                    child: TextFormField(
                                        initialValue: snapshot.data?[studentId],
                                        decoration: InputDecoration(
                                          labelText: 'Student ID*',
                                          errorText: submitted
                                              ? formValues[studentId]
                                                  [errorIndex]
                                              : null,
                                          hintText: 'example@gmail.com',
                                          prefixIcon: const Icon(
                                            Icons.school_outlined,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            formValues[studentId] = [
                                              value,
                                              null
                                            ];
                                          });
                                          checkFormIsReadyToSubmit();
                                        }),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, Constants.smMargin),
                                    child: TimezoneDropdown(
                                        timezoneDropDownValue:
                                            formValues[timeZone][dataIndex],
                                        onItemSelectedCallback:
                                            onTimezoneSelected),
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
                                            fontSize:
                                                Constants.requiredTextSize,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (!(isWeb
                          ? MediaQuery.of(context).viewInsets.bottom > 0
                          : _isKeyboardVisible))
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              Constants.mmMargin, 0, Constants.mmMargin, Constants.msMargin),
                          child: CustomElevatedButton(
                            formState: formState,
                            normalText: 'UPDATE PROFILE',
                            errorText: 'TRY IT AGAIN',
                            successText: 'PROFILE UPDATED',
                            processingText: 'UPDATING',
                            onPressed: _submit,
                          ),
                        ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}
