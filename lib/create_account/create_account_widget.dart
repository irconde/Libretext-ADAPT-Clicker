import 'package:adapt_clicker/components/connection_state_mixin.dart';
import 'package:adapt_clicker/components/form_state_mixin.dart';
import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:adapt_clicker/components/collapsing_libre_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/components/timezone_dropdown.dart';
import '../components/custom_elevated_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../utils/stored_preferences.dart';

@RoutePage()
class CreateAccountWidget extends ConsumerStatefulWidget {
  const CreateAccountWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateAccountWidget> createState() =>
      _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends ConsumerState<CreateAccountWidget>
    with FormStateMixin, ConnectionStateMixin {
  final _formKey = GlobalKey<FormState>();
  static const String firstName = 'first_name';
  static const String lastName = 'last_name';
  static const String studentId = 'student_id';
  static const String email = 'email';
  static const String password = 'password';
  static const String passwordConfirmation = 'password_confirmation';
  static const String timeZone = 'time_zone';
  bool passwordFieldCAVisibility = false;
  bool confirmPasswordFieldCAVisibility = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  Future<void> _loadTimeZones() async {
    await AppState.timezoneContainer.initTimezones();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadTimeZones();
    setState(() {
      requiredFields = [
        firstName,
        lastName,
        studentId,
        email,
        password,
        passwordConfirmation,
        timeZone
      ];
      formValues[firstName] = [null, null];
      formValues[lastName] = [null, null];
      formValues[studentId] = [null, null];
      formValues[email] = [null, null];
      formValues[password] = [null, null];
      formValues[passwordConfirmation] = [null, null];
      formValues[timeZone] = [null, null];
    });
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

  void onTimezoneSelected(timezone) {
    setState(() {
      formValues[timeZone] = [timezone, null];
    });
    checkFormIsReadyToSubmit();
  }

  void _submit() async {
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    final String currentEmail = formValues[email][dataIndex];
    final String currentPassword = formValues[password][dataIndex];
    final timezoneValue =
        AppState.timezoneContainer.getValue(formValues[timeZone][dataIndex]);
    serverRequest = await CreateUserCall.call(
      email: currentEmail,
      password: currentPassword,
      passwordConfirmation: formValues[passwordConfirmation][dataIndex],
      firstName: formValues[firstName][dataIndex],
      lastName: formValues[lastName][dataIndex],
      registrationType: '3',
      studentId: formValues[studentId][dataIndex],
      timeZone: timezoneValue,
    );
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      setState(() {
        StoredPreferences.userAccount = currentEmail;
        StoredPreferences.userPassword = currentPassword;
      });
      await context.pushRoute(CoursesRouteWidget());
      setState(() {});
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
                              errorText: submitted
                                  ? formValues[firstName][errorIndex]
                                  : null,
                              prefixIcon: const Icon(
                                Icons.person_outline,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                formValues[firstName] = [value, null];
                              });
                              checkFormIsReadyToSubmit();
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
                              errorText: submitted
                                  ? formValues[lastName][errorIndex]
                                  : null,
                              prefixIcon: const Icon(
                                Icons.person_outline,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                formValues[lastName] = [value, null];
                              });
                              checkFormIsReadyToSubmit();
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
                              errorText: submitted
                                  ? formValues[studentId][errorIndex]
                                  : null,
                              hintText: 'Student ID',
                            ),
                            onChanged: (value) {
                              setState(() {
                                formValues[studentId] = [value, null];
                              });
                              checkFormIsReadyToSubmit();
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
                              errorText: submitted
                                  ? formValues[email][errorIndex]
                                  : null,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                formValues[email] = [value, null];
                              });
                              checkFormIsReadyToSubmit();
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
                              errorText: submitted
                                  ? formValues[password][errorIndex]
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
                                formValues[password] = [value, null];
                              });
                              checkFormIsReadyToSubmit();
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
                              errorText: submitted
                                  ? formValues[passwordConfirmation][errorIndex]
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
                                formValues[passwordConfirmation] = [
                                  value,
                                  null
                                ];
                              });
                              checkFormIsReadyToSubmit();
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: TimezoneDropdown(
                            timezoneDropDownValue: formValues[timeZone]
                                [dataIndex],
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
                            child: CustomElevatedButton(
                              formState: formState,
                              normalText: 'REGISTER',
                              errorText: 'TRY IT AGAIN',
                              processingText: 'CREATING ACCOUNT',
                              onPressed: _submit,
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
                            child: CustomElevatedButton(
                              type: ButtonType.external,
                              normalText: 'CAMPUS REGISTRATION',
                              onPressed: () async {
                                if (!checkConnection()) return;
                                await mLaunchUrl(
                                    'https://sso.libretexts.org/cas/oauth2.0/authorize?response_type=code&client_id=TLvxKEXF5myFPEr3e3EipScuP0jUPB5t3n4A&redirect_uri=https%3A%2F%2Fdev.adapt.libretexts.org%2Fapi%2Foauth%2Flibretexts%2Fcallback%3Fclicker_app%3Dtrue');
                              },
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
                                              ContactUsWidget(),
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
