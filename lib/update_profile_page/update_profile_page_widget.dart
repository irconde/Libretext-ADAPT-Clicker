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
  static const String email = 'email';
  static const String studentId = 'student_id';
  static const String timeZone = 'time_zone';

  ApiCallResponse? _userInfoRequest;
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
    _userInfoRequest = await GetUserCall.call(
      token: StoredPreferences.authToken,
    );
    if ((_userInfoRequest?.succeeded ?? true)) {
      currentUserInfo[firstName] =
          getJsonField(_userInfoRequest!.jsonBody, r'''$.first_name''')
              .toString();
      currentUserInfo[lastName] =
          getJsonField(_userInfoRequest!.jsonBody, r'''$.last_name''')
              .toString();
      currentUserInfo[email] =
          getJsonField(_userInfoRequest!.jsonBody, r'''$.email''').toString();
      currentUserInfo[studentId] =
          getJsonField(_userInfoRequest!.jsonBody, r'''$.student_id''')
              .toString();
      // TODO. Fix this. The way we deal with the timezone is messy. We need to fix that
      /*
      AppState.userTimezone!.setValue(
          getJsonField(_userInfoRequest!.jsonBody, r'''$.time_zone''')
              .toString());
      AppState.userTimezone!.setText(timeZone);
      currentUserInfo[timeZone] = AppState.timezoneContainer!
          .getText(AppState.userTimezone!.value)
          .toString();
       */
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
      formValues[timeZone] = [null, null];
      // TODO Fix this.
      //formValues[timeZone] = [inputValues[timeZone],null];
      requiredFieldsFilled =
          checkRequiredFieldsFilled(formValues, requiredFields);
    });
  }

  void _submit() async {
    if (!checkConnection()) return;
    serverRequest = await UpdateProfileCall.call(
        token: StoredPreferences.authToken,
        firstName: formValues[firstName][dataIndex],
        lastName: formValues[lastName][dataIndex],
        email: formValues[email][dataIndex],
        /* TODO. Fix this */
        timeZone: '',
        /*timeZone: AppState.timezoneContainer
                ?.getValue(AppState.userTimezone.toString()) ??
            AppState.timezoneContainer!.timeZones.first.value, */
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
                                            requiredFieldsFilled =
                                                checkRequiredFieldsFilled(
                                                    formValues, requiredFields);
                                          });
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
                                            requiredFieldsFilled =
                                                checkRequiredFieldsFilled(
                                                    formValues, requiredFields);
                                          });
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
                                            requiredFieldsFilled =
                                                checkRequiredFieldsFilled(
                                                    formValues, requiredFields);
                                          });
                                        }),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, Constants.smMargin),
                                    child: TimezoneDropdown(
                                        /** TODO. Fix this **/
                                        timezoneDropDownValue:
                                            snapshot.data?[timeZone]),
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
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}
