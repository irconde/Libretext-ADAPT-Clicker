import 'package:adapt_clicker/components/TimezoneDropdown.dart';
import 'package:adapt_clicker/components/drawer_ctn.dart';
import 'package:adapt_clicker/flutter_flow/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../gen/assets.gen.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../utils/check_internet_connectivity.dart';
import '../utils/stored_preferences.dart';

class UpdateProfilePageWidget extends ConsumerStatefulWidget {
  const UpdateProfilePageWidget({Key? key, required this.onSubmit})
      : super(key: key);
  final ValueChanged<String?> onSubmit;

  @override
  _UpdateProfilePageWidgetState createState() =>
      _UpdateProfilePageWidgetState();
}

String firstNameRequired = "The first name field is required.";
String lastNameRequired = "The last name field is required.";
String idRequired = "The student ID field is required.";
String invalidRecords = "These credentials do not match our records.";

class _UpdateProfilePageWidgetState extends ConsumerState<UpdateProfilePageWidget> {
  static String? timeZoneUpdateDDValue;
  ApiCallResponse? updateProfile;
  ApiCallResponse? getUser;
  ApiCallResponse? logout;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  TextEditingController? firstNameUpdateTFController;
  TextEditingController? lastNameUpdateTFController;
  TextEditingController? studentIDUpdateTFController;
  bool _submitted = false;

  String? get _firstNameErrorText {
    final text = firstNameUpdateTFController?.value.text;
    if (text != null && text.isEmpty) {
      return firstNameRequired;
    }
    return null;
  }

  String? get _lastNameErrorText {
    final text = firstNameUpdateTFController?.value.text;
    if (text != null && text.isEmpty) {
      return lastNameRequired;
    }
    return null;
  }

  String? get _idErrorText {
    final text = studentIDUpdateTFController?.value.text;
    if (text != null && text.isEmpty) {
      return idRequired;
    }
    return null;
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_firstNameErrorText == null) {
      widget.onSubmit(firstNameUpdateTFController?.value.text);
    }
    if (_lastNameErrorText == null) {
      widget.onSubmit(lastNameUpdateTFController?.value.text);
    }
    if (_idErrorText == null) {
      widget.onSubmit(studentIDUpdateTFController?.value.text);
    }
  }

  @override
  void initState() {
    super.initState();
    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    firstNameUpdateTFController = TextEditingController();
    lastNameUpdateTFController = TextEditingController();
    studentIDUpdateTFController = TextEditingController();

    //Autofills user info
    updateUserInfo();
  }

  String firstName = '', lastName = '', email = '', studentID = '';

  Future<void> updateUserInfo() async {
    getUser = await GetUserCall.call(
      token: StoredPreferences.authToken,
    );
    if ((getUser?.succeeded ?? true)) {
      //Gets values from API call
      firstName = getJsonField(
        getUser!.jsonBody,
        r'''$.first_name''',
      ).toString();

      lastName = getJsonField(
        getUser!.jsonBody,
        r'''$.last_name''',
      ).toString();

      email = getJsonField(
        getUser!.jsonBody,
        r'''$.email''',
      ).toString();

      studentID = getJsonField(
        getUser!.jsonBody,
        r'''$.student_id''',
      ).toString();

      //Gets val from apicall
      AppState.userTimezone!.setValue(getJsonField(
        getUser!.jsonBody,
        r'''$.time_zone''',
      ).toString());

      //Gets text from matching val in list
      AppState.userTimezone!.setText(AppState.timezoneContainer!
          .getText(AppState.userTimezone!.value)); //set this

      //Sets text fields
      firstNameUpdateTFController?.text = firstName;
      lastNameUpdateTFController?.text = lastName;
      studentIDUpdateTFController?.text = studentID;
    }
  }

  @override
  void dispose() {
    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  bool _checkConnection(){
    ConnectivityStatus? status = ref.read(provider.notifier).getConnectionStatus();
    if (status != ConnectivityStatus.isConnected) {
      functions.showSnackbar(context, status);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Text('My Profile'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
            ),
            onPressed: () async {
              context.pushRoute(NotificationsRouteWidget());
            },
          ),
        ],
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      drawer: DrawerCtnWidget(currentSelected: DrawerItems.profile),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextField(
                              controller: firstNameUpdateTFController,
                              autofocus: true,
                              decoration: InputDecoration(
                                labelText: 'First Name*',
                                errorText:
                                    _submitted ? _firstNameErrorText : null,
                                hintText: firstName,
                                filled: true,
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextField(
                              controller: lastNameUpdateTFController,
                              decoration: InputDecoration(
                                labelText: 'Last Name*',
                                errorText:
                                    _submitted ? _lastNameErrorText : null,
                                hintText: 'Doe',
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextField(
                              controller: studentIDUpdateTFController,
                              decoration: InputDecoration(
                                labelText: 'Student ID*',
                                errorText: _submitted ? _idErrorText : null,
                                hintText: 'example@gmail.com',
                                prefixIcon: Icon(
                                  Icons.school_outlined,
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.smMargin),
                          child: TimezoneDropdown(
                              timezoneDropDownValue: timeZoneUpdateDDValue),
                        ),
                        Align(
                          alignment: Alignment(1, 0),
                          child: Text(
                            '*Required Fields',
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Open Sans',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
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
                  padding: EdgeInsetsDirectional.fromSTEB(
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
                    onPressed: () async {
                      if (!_checkConnection()) return;
                      updateProfile = await UpdateProfileCall.call(
                        token: StoredPreferences.authToken,
                        firstName: firstNameUpdateTFController!.text,
                        lastName: lastNameUpdateTFController!.text,
                        email: email,
                        timeZone: AppState.timezoneContainer
                                ?.getValue(AppState.userTimezone.toString()) ??
                            AppState.timezoneContainer!.timezones.first.value,
                        studentId: studentIDUpdateTFController!.text,
                      );
                      if ((updateProfile?.succeeded ?? true)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Profile Updated Successfully',
                              style: TextStyle(
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                              ),
                            ),
                            duration: Duration(
                                milliseconds: Constants.snackBarDurationMil),
                            backgroundColor:
                                FlutterFlowTheme.of(context).success,
                          ),
                        );
                      } else {
                        _submit();
                      }
                      setState(() {});
                    },
                    child: const Text('UPDATE PROFILE'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
