import 'package:adapt_clicker/flutter_flow/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:adapt_clicker/components/collapsing_libre_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/components/timezone_dropdown.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import '../utils/check_internet_connectivity.dart';
import '../utils/stored_preferences.dart';

class CreateAccountWidget extends ConsumerStatefulWidget {
  const CreateAccountWidget({Key? key, required this.onSubmit})
      : super(key: key);
  final ValueChanged<String?> onSubmit;

  @override
  ConsumerState<CreateAccountWidget> createState() =>
      _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends ConsumerState<CreateAccountWidget> {
  final int dataIndex = 0;
  final int errorIndex = 1;
  bool _submitted = false;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formValues = {
    'first_name': [null, null],
    'last_name': [null, null],
    'student_id': [null, null],
    'email': [null, null],
    'password': [null, null],
    'confirm_password': [null, null],
  };
  bool _allFieldsFilled = false;
  bool passwordFieldCAVisibility = false;
  bool confirmPasswordFieldCAVisibility = false;
  String? _timeZone;
  ApiCallResponse? createUser;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  void _old_submit() {
    // TODO irconde. To be fixed
    /*
    setState(() => _submitted = true);
    if (_firstNameErrorText == null) {
      widget.onSubmit(firstNameFieldCAController?.value.text);
    } else if (_lastNameErrorText == null) {
      widget.onSubmit(lastNameFieldCAController?.value.text);
    } else if (_idErrorText == null) {
      widget.onSubmit(studentIDFieldController?.value.text);
    } else if (_emailErrorText == null) {
      widget.onSubmit(emailFieldCAController?.value.text);
    } else if (_passwordErrorText == null) {
      widget.onSubmit(passwordFieldCAController?.value.text);
    } else if (_confirmPasswordErrorText == null) {
      widget.onSubmit(confirmPasswordFieldCAController?.value.text);
    }*/
  }

  bool allFieldsFilled(Map<String, dynamic> formData) {
    for (dynamic value in formData.values) {
      if (value[dataIndex] == null || value[dataIndex].isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _allFieldsFilled = allFieldsFilled(_formValues);
    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        setState(() {
          _isKeyboardVisible = visible;
        });
      });
    }
  }

  @override
  void dispose() {
    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  bool _checkConnection() {
    ConnectivityStatus? status =
        ref.read(provider.notifier).getConnectionStatus();
    if (status != ConnectivityStatus.isConnected) {
      functions.showSnackbar(context, status);
      return false;
    }
    return true;
  }

  void onTimezoneSelected(timezone) {
    setState(() {
      _timeZone = timezone;
    });
  }

  void _submit() async {
    // TODO. irconde fix this
    /*
    if (!_checkConnection()) return;
    String email = emailFieldCAController!.text;
    String password = passwordFieldCAController!.text;
    final timezoneValue = AppState.timezoneContainer?.getValue(_timeZone) ??
        AppState.timezoneContainer!.timeZones.first.value;
    createUser = await CreateUserCall.call(
      email: email,
      password: password,
      passwordConfirmation: confirmPasswordFieldCAController!.text,
      firstName: firstNameFieldCAController!.text,
      lastName: lastNameFieldCAController!.text,
      registrationType: '3',
      studentId: studentIDFieldController!.text,
      timeZone: timezoneValue,
    );
    if ((createUser?.succeeded ?? true) && context.mounted) {
      setState(() {
        StoredPreferences.userAccount = email;
        StoredPreferences.userPassword = password;
      });
      await context.pushRoute(CoursesRouteWidget());
    } else {
      _old_submit();
    }
    setState(() {});*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      key: scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CollapsingLibreAppBar(
              title: 'Create Account',
              iconPath: 'assets/images/person_add1.svg',
              svgIconColor: FlutterFlowTheme.of(context).svgIconColor,
            ),
          ];
        },
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              labelText: 'First Name',
                              errorText: _submitted
                                  ? _formValues['first_name'][errorIndex]
                                  : null,
                              prefixIcon: const Icon(
                                Icons.person_outline,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _formValues['first_name'] = [value, null];
                                _allFieldsFilled = allFieldsFilled(_formValues);
                              });
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              labelText: 'Last Name',
                              errorText: _submitted
                                  ? _formValues['last_name'][errorIndex]
                                  : null,
                              prefixIcon: const Icon(
                                Icons.person_outline,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _formValues['last_name'] = [value, null];
                                _allFieldsFilled = allFieldsFilled(_formValues);
                              });
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.school_outlined,
                              ),
                              labelText: 'Student ID',
                              errorText: _submitted
                                  ? _formValues['student_id'][errorIndex]
                                  : null,
                              hintText: 'Student ID',
                            ),
                            onChanged: (value) {
                              setState(() {
                                _formValues['student_id'] = [value, null];
                                _allFieldsFilled = allFieldsFilled(_formValues);
                              });
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              labelText: 'Email',
                              errorText: _submitted
                                  ? _formValues['email'][errorIndex]
                                  : null,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _formValues['email'] = [value, null];
                                _allFieldsFilled = allFieldsFilled(_formValues);
                              });
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: TextFormField(
                            obscureText: !passwordFieldCAVisibility,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              labelText: 'Password',
                              errorText: _submitted
                                  ? _formValues['password'][errorIndex]
                                  : null,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => passwordFieldCAVisibility =
                                      !passwordFieldCAVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  passwordFieldCAVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 20,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _formValues['password'] = [value, null];
                                _allFieldsFilled = allFieldsFilled(_formValues);
                              });
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: TextFormField(
                            obscureText: !confirmPasswordFieldCAVisibility,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              labelText: 'Confirm Password',
                              errorText: _submitted
                                  ? _formValues['confirm_password'][errorIndex]
                                  : null,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                              ),
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => confirmPasswordFieldCAVisibility =
                                      !confirmPasswordFieldCAVisibility,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  confirmPasswordFieldCAVisibility
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 20,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _formValues['confirm_password'] = [value, null];
                                _allFieldsFilled = allFieldsFilled(_formValues);
                              });
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: TimezoneDropdown(
                            timezoneDropDownValue: _timeZone,
                            onItemSelectedCallback: onTimezoneSelected,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!(isWeb
                      ? MediaQuery.of(context).viewInsets.bottom > 0
                      : _isKeyboardVisible))
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primaryColor,
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                                minimumSize: const Size.fromHeight(36),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: _allFieldsFilled ? _submit : null,
                              child: Text(
                                'REGISTER',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                              ),
                            ),
                          ),
                          Stack(
                            alignment: const AlignmentDirectional(0, 0),
                            children: [
                              Divider(
                                height: 0,
                                thickness: 1,
                                color: FlutterFlowTheme.of(context).lineColor,
                              ),
                              Container(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'OR',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 20,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 20, 0, 32),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondaryColor,
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                                minimumSize: const Size.fromHeight(36),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: () async {
                                if (!_checkConnection()) return;
                                await mLaunchUrl(
                                    'https://sso.libretexts.org/cas/oauth2.0/authorize?response_type=code&client_id=TLvxKEXF5myFPEr3e3EipScuP0jUPB5t3n4A&redirect_uri=https%3A%2F%2Fdev.adapt.libretexts.org%2Fapi%2Foauth%2Flibretexts%2Fcallback%3Fclicker_app%3Dtrue');
                              },
                              child: const Text('CAMPUS REGISTRATION'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 56),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                  children: [
                                    const TextSpan(text: 'Having problems? '),
                                    TextSpan(
                                        text: 'Contact us',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryColor,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontFamily: 'Open Sans',
                                              fontWeight: FontWeight.normal,
                                            ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            context.pushRoute(
                                              ContactUsWidget(
                                                onSubmit: (String? value) {},
                                              ),
                                            );
                                          }),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
