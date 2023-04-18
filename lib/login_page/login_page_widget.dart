import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/Router/app_router.gr.dart';
import '../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/components/reset_password_widget.dart';
import '../components/collapsing_libre_app_bar.dart';
import '../components/form_state_mixin.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';

@RoutePage()
class LoginPageWidget extends ConsumerStatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends ConsumerState<LoginPageWidget>
    with FormStateMixin {
  static const String email = 'email';
  static const String password = 'password';
  bool passwordVisibility = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
    requiredFields = [email, password];
    formValues[email] = [null, null];
    formValues[password] = [null, null];
  }

  Future<void> recoverSavedAuthData() async {
    try {
      await _rememberMeCheck();
    } catch (e) {
      // TODO. User logger here
    }
  }

  Future<void> _rememberMeCheck() async {
    String userAccount = StoredPreferences.userAccount;
    String userPassword = StoredPreferences.userPassword;
    if (StoredPreferences.rememberMe) {
      if (userAccount.isNotEmpty && userPassword.isNotEmpty) {
        setState(() {
          formValues[email] = [userAccount, null];
          formValues[password] = [userPassword, null];
          requiredFieldsFilled =
              checkRequiredFieldsFilled(formValues, requiredFields);
        });
      }
    }
  }

  void _submit() async {
    if (!checkConnection()) return;
    serverRequest = await LoginCall.call(
      email: formValues[email][dataIndex],
      password: formValues[password][dataIndex],
    );
    if ((serverRequest?.succeeded ?? true) && context.mounted) {
      setState(() {
        StoredPreferences.authToken = functions.createToken(getJsonField(
          (serverRequest?.jsonBody ?? ''),
          r'''$.token''',
        ).toString());
        StoredPreferences.userAccount = formValues[email][dataIndex];
        StoredPreferences.userPassword = formValues[password][dataIndex];
      });
      await context.pushRoute(const CoursesPageWidget());
      setState(() {});
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CollapsingLibreAppBar(
                title: 'Welcome Back',
                iconPath: 'assets/images/hand_wave.svg',
                svgIconColor: FlutterFlowTheme.of(context).svgIconColor2),
          ];
        },
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder(
                      future: _rememberMeCheck(),
                      builder: (context, snapshot) {
                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  32, 32, 32, 0),
                              child: TextFormField(
                                  autofocus: true,
                                  initialValue: formValues[email][dataIndex],
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    errorText: submitted
                                        ? formValues[email][errorIndex]
                                        : null,
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        fontSize: 16,
                                      ),
                                  onChanged: (value) {
                                    setState(() {
                                      formValues[email] = [value, null];
                                      requiredFieldsFilled =
                                          checkRequiredFieldsFilled(
                                              formValues, requiredFields);
                                    });
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  32, 24, 32, 24),
                              child: TextFormField(
                                  autofocus: true,
                                  initialValue: formValues[password][dataIndex],
                                  obscureText: !passwordVisibility,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    errorText: submitted
                                        ? formValues[password][errorIndex]
                                        : null,
                                    prefixIcon: const Icon(
                                      Icons.lock_outline,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => passwordVisibility =
                                            !passwordVisibility,
                                      ),
                                      focusNode: FocusNode(skipTraversal: true),
                                      child: Icon(
                                        passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryColor,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        fontSize: 16,
                                      ),
                                  onChanged: (value) {
                                    setState(() {
                                      formValues[password] = [value, null];
                                      requiredFieldsFilled =
                                          checkRequiredFieldsFilled(
                                              formValues, requiredFields);
                                    });
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  18, 0, 32, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ToggleIcon(
                                    onPressed: () async {
                                      setState(() =>
                                          StoredPreferences.rememberMe =
                                              !StoredPreferences.rememberMe);
                                    },
                                    value: StoredPreferences.rememberMe,
                                    onIcon: Icon(
                                      Icons.check_box,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      size: 28,
                                    ),
                                    offIcon: Icon(
                                      Icons.check_box_outline_blank,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      size: 28,
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Remember Me ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Open Sans',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                              ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Forgot Password?',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        fontFamily: 'Open Sans',
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: MediaQuery.of(
                                                                context)
                                                            .viewInsets,
                                                        child:
                                                            const ResetPasswordWidget(),
                                                      );
                                                    },
                                                  );
                                                }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  32, 16, 32, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  surfaceTintColor: FlutterFlowTheme.of(context)
                                      .primaryBtnText,
                                  minimumSize: const Size.fromHeight(36),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                onPressed:
                                    requiredFieldsFilled ? _submit : null,
                                child: const Text('SIGN IN WITH ADAPT'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  32, 24, 32, 24),
                              child: Stack(
                                alignment: const AlignmentDirectional(0, 0),
                                children: [
                                  Divider(
                                    height: 0,
                                    thickness: 1,
                                    color:
                                        FlutterFlowTheme.of(context).lineColor,
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              fontSize: 20,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  32, 0, 32, 0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  surfaceTintColor: FlutterFlowTheme.of(context)
                                      .primaryBtnText,
                                  minimumSize: const Size.fromHeight(36),
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                onPressed: () async {
                                  if (!checkConnection()) return;
                                  await mLaunchUrl(
                                      'https://sso.libretexts.org/cas/oauth2.0/authorize?response_type=code&client_id=TLvxKEXF5myFPEr3e3EipScuP0jUPB5t3n4A&redirect_uri=https%3A%2F%2Fdev.adapt.libretexts.org%2Fapi%2Foauth%2Flibretexts%2Fcallback%3Fclicker_app%3Dtrue');
                                },
                                child: const Text('CAMPUS LOGIN'),
                              ),
                            ),
                          ],
                        );
                      }),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 48, 0, 0),
                    child: RichText(
                      text: TextSpan(
                          style: FlutterFlowTheme.of(context).bodyText1,
                          children: [
                            const TextSpan(text: 'Don\'t have an account? '),
                            TextSpan(
                                text: 'Sign up',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      decoration: TextDecoration.underline,
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.normal,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    context.pushRoute(
                                      const CreateAccountWidget(),
                                    );
                                  }),
                          ]),
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
