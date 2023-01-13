import 'package:adapt_clicker/components/TimezoneDropdown.dart';
import 'package:adapt_clicker/components/drawer_ctn.dart';
import 'package:adapt_clicker/flutter_flow/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../stored_preferences.dart';

class UpdateProfilePageWidget extends StatefulWidget {
  const UpdateProfilePageWidget({Key? key, required this.onSubmit})
      : super(key: key);
  final ValueChanged<String?> onSubmit;

  @override
  _UpdateProfilePageWidgetState createState() =>
      _UpdateProfilePageWidgetState();
}

String firstNameRequired = "The first name field is required.";
String lastNameRequired = "The last name field is required.";
String emailRequired = "The email field is required.";
String idRequired = "The student ID field is required.";
String invalidRecords = "These credentials do not match our records.";

class _UpdateProfilePageWidgetState extends State<UpdateProfilePageWidget> {
  String? timeZoneUpdateDDValue;
  ApiCallResponse? updateProfile;
  ApiCallResponse? logout;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  TextEditingController? emailUpdateTFController;
  TextEditingController? firstNameUpdateTFController;
  TextEditingController? lastNameUpdateTFController;
  TextEditingController? studentIDUpdateTFController;
  bool _submitted = false;

  String? get _emailErrorText {
    final text = emailUpdateTFController?.value.text;
    if (text != null && text.isEmpty) {
      return emailRequired;
    }
    return null;
  }

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
    if (_emailErrorText == null) {
      widget.onSubmit(emailUpdateTFController?.value.text);
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

    emailUpdateTFController = TextEditingController();
    firstNameUpdateTFController = TextEditingController();
    lastNameUpdateTFController = TextEditingController();
    studentIDUpdateTFController = TextEditingController();
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
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            scaffoldKey.currentState!.openDrawer();
          },
          child: Icon(
            Icons.menu,
            color: FlutterFlowTheme.of(context).primaryBackground,
            size: 28,
          ),
        ),
        title: Text(
          'My Profile',
          style: FlutterFlowTheme.of(context).bodyText1.override(
                fontFamily: 'Open Sans',
                color: FlutterFlowTheme.of(context).primaryBackground,
                fontSize: 28,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
            child: InkWell(
              onTap: () async {
                context.pushRoute(NotificationsRouteWidget());
              },
              child: Icon(
                Icons.notifications,
                color: FlutterFlowTheme.of(context).primaryBackground,
                size: 28,
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      drawer: DrawerCtnWidget(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
                          child: TextField(
                              controller: firstNameUpdateTFController,
                              autofocus: true,
                              decoration: InputDecoration(
                                labelText: 'First Name*',
                                errorText:
                                    _submitted ? _firstNameErrorText : null,
                                hintText: 'John',
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: TextField(
                              controller: emailUpdateTFController,
                              decoration: InputDecoration(
                                labelText: 'Email*',
                                errorText: _submitted ? _emailErrorText : null,
                                hintText: 'example@gmail.com',
                                prefixIcon: Icon(
                                  Icons.mail_outline,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
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
                        TimezoneDropdown(
                            timezoneDropDownValue: timeZoneUpdateDDValue),
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
                                  fontSize: 12,
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
                  padding: EdgeInsetsDirectional.fromSTEB(32, 0, 32, 24),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(36),
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      primary: FlutterFlowTheme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () async {
                      updateProfile = await UpdateProfileCall.call(
                        token: StoredPreferences.authToken,
                        firstName: firstNameUpdateTFController!.text,
                        lastName: lastNameUpdateTFController!.text,
                        email: emailUpdateTFController!.text,
                        timeZone: AppState.timezoneContainer!
                            .getValue(timeZoneUpdateDDValue),
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
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).success,
                          ),
                        );
                      } else {
                        _submit();
                        setState(() => AppState().errorsList = (getJsonField(
                              (updateProfile?.jsonBody ?? ''),
                              r'''$.errors..*''',
                            ) as List)
                                .map<String>((s) => s.toString())
                                .toList());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              functions
                                  .getTopError(AppState().errorsList.toList()),
                              style: TextStyle(
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).failure,
                          ),
                        );
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
