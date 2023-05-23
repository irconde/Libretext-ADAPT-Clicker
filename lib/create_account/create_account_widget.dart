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
import '../utils/constants.dart';
import '../utils/stored_preferences.dart';
import '../flutter_flow/custom_functions.dart' as functions;

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
      formFields = [
        firstName,
        lastName,
        studentId,
        email,
        password,
        passwordConfirmation,
        timeZone
      ];
      initFormFieldsInfo();
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
    disposeFocusNodes();
    super.dispose();
  }

  void _openTimezoneSelector() {
    FocusScope.of(context).requestFocus(formValues[timeZone][focusNodeIndex]);
  }

  void _onTimezoneSelected(timezone) {
    setState(() {
      formValues[timeZone] = [
        timezone,
        null,
        formValues[timeZone][focusNodeIndex]
      ];
    });
    checkFormIsReadyToSubmit();
  }

  void _showSignUpSnackbar(String userAccount) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: RichText(
              text: TextSpan(
                text: 'An account for ',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: userAccount,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' has been successfully created.'),
                ],
              ),
            ),
            backgroundColor: FlutterFlowTheme.of(context).secondaryText),
      );
    });
  }

  void _submit() async {
    if (!checkConnection()) return;
    setState(() {
      formState = FormStateValue.processing;
    });
    final String currentEmail = formValues[email][dataIndex];
    final String currentPassword = formValues[password][dataIndex];
    final String currentStudentId = formValues[studentId][dataIndex];
    final timezoneValue =
        AppState.timezoneContainer.getValue(formValues[timeZone][dataIndex]);
    serverRequest = await CreateUserCall.call(
      email: currentEmail,
      password: currentPassword,
      passwordConfirmation: formValues[passwordConfirmation][dataIndex],
      firstName: formValues[firstName][dataIndex],
      lastName: formValues[lastName][dataIndex],
      registrationType: '3',
      studentId: currentStudentId,
      timeZone: timezoneValue,
    );
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      setState(() {
        StoredPreferences.userAccount = currentEmail;
        StoredPreferences.userPassword = currentPassword;
      });

      _showSignUpSnackbar(currentStudentId);

      ApiCallResponse? loginRequest = await LoginCall.call(
        email: currentEmail,
        password: currentPassword,
      );

      if ((loginRequest.succeeded ?? true) && context.mounted) {
        setState(() {
          StoredPreferences.authToken = functions.createToken(getJsonField(
            (loginRequest.jsonBody ?? ''),
            r'''$.token''',
          ).toString());
        });

        FocusScope.of(context).unfocus();
        await context.pushRoute(CoursesRouteWidget());
      } else {
        final errors =
            getJsonField((loginRequest.jsonBody ?? ''), r'''$.errors''');
        onReceivedErrorsFromServer(errors);
      }
    } else {
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
      body: CollapsingLibreAppBar(
        title: 'Create Account',
        iconPath: 'assets/images/person_add1.svg',
        svgIconColor: FlutterFlowTheme.of(context).svgIconColor,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        Constants.mmMargin,
                        Constants.mmMargin,
                        Constants.mmMargin,
                        0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextFormField(
                            autofocus: true,
                            enabled: formState != FormStateValue.processing,
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
                                formValues[firstName] = [
                                  value,
                                  null,
                                  formValues[firstName][focusNodeIndex]
                                ];
                              });
                              checkFormIsReadyToSubmit();
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                            textInputAction: TextInputAction.next,
                            focusNode: formValues[firstName][focusNodeIndex],
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(
                                    formValues[lastName][focusNodeIndex]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextFormField(
                            enabled: formState != FormStateValue.processing,
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
                                formValues[lastName] = [
                                  value,
                                  null,
                                  formValues[lastName][focusNodeIndex]
                                ];
                              });
                              checkFormIsReadyToSubmit();
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                            textInputAction: TextInputAction.next,
                            focusNode: formValues[lastName][focusNodeIndex],
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(
                                    formValues[studentId][focusNodeIndex]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextFormField(
                            enabled: formState != FormStateValue.processing,
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
                                formValues[studentId] = [
                                  value,
                                  null,
                                  formValues[studentId][focusNodeIndex]
                                ];
                              });
                              checkFormIsReadyToSubmit();
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                            textInputAction: TextInputAction.next,
                            focusNode: formValues[studentId][focusNodeIndex],
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(
                                    formValues[email][focusNodeIndex]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextFormField(
                            enabled: formState != FormStateValue.processing,
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
                                formValues[email] = [
                                  value,
                                  null,
                                  formValues[email][focusNodeIndex]
                                ];
                              });
                              checkFormIsReadyToSubmit();
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                            textInputAction: TextInputAction.next,
                            focusNode: formValues[email][focusNodeIndex],
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(
                                    formValues[password][focusNodeIndex]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextFormField(
                            enabled: formState != FormStateValue.processing,
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
                                formValues[password] = [
                                  value,
                                  null,
                                  formValues[password][focusNodeIndex]
                                ];
                              });
                              checkFormIsReadyToSubmit();
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                            textInputAction: TextInputAction.next,
                            focusNode: formValues[password][focusNodeIndex],
                            onFieldSubmitted: (_) => FocusScope.of(context)
                                .requestFocus(formValues[passwordConfirmation]
                                    [focusNodeIndex]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TextFormField(
                            enabled: formState != FormStateValue.processing,
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
                                  null,
                                  formValues[passwordConfirmation]
                                      [focusNodeIndex]
                                ];
                              });
                              checkFormIsReadyToSubmit();
                            },
                            style: FlutterFlowTheme.of(context).bodyText1,
                            textInputAction: TextInputAction.next,
                            focusNode: formValues[passwordConfirmation]
                                [focusNodeIndex],
                            onFieldSubmitted: (_) => _openTimezoneSelector,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, Constants.msMargin),
                          child: TimezoneDropdown(
                            timezoneDropDownValue: formValues[timeZone]
                                [dataIndex],
                            onItemSelectedCallback: _onTimezoneSelected,
                            focusNode: formValues[timeZone][focusNodeIndex],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!(isWeb))
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          Constants.mmMargin,
                          0,
                          Constants.mmMargin,
                          Constants.mmMargin),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, Constants.msMargin),
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
                                0, Constants.msMargin, 0, Constants.mmMargin),
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
                          RichText(
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
                                            color: FlutterFlowTheme.of(context)
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
