import 'package:adapt_clicker/flutter_flow/app_router.gr.dart';
import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/collapsing_libre_app_bar.dart';
import '../components/reset_password_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';

import '../utils/check_internet_connectivity.dart';

String passwordRequired = 'The password field is required.';
String emailRequired = 'The email field is required.';
String invalidRecords = 'These credentials do not match our records.';

class LoginPageWidget extends ConsumerStatefulWidget {
  const LoginPageWidget({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  ConsumerState<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends ConsumerState<LoginPageWidget> {
  //Text Controllers
  final _emailTFController = TextEditingController();
  final _passwordTFController = TextEditingController();

  bool _submitted = false;
  bool passwordVisibility = false;

  ApiCallResponse? loginAttempt;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
    //Remember Me
    init();
  }

  //Added so can do async
  Future<void> init() async {
    //Remember Me
    try {
      await _rememberMeCheck();
    } catch (e) {}
  }

  Future<void> _rememberMeCheck() async {
    String userAccount = StoredPreferences.userAccount;
    String userPassword = StoredPreferences.userPassword;

    if (StoredPreferences.rememberMe) {
      if (userAccount.isNotEmpty && userPassword.isNotEmpty) {
        _emailTFController.text = userAccount;
        _passwordTFController.text = userPassword;
      }
    }
  }

  String? get _emailErrorText {
    final text = _emailTFController.value.text;
    if (text.isEmpty) {
      return emailRequired;
    } else {
      return invalidRecords;
    }
  }

  String? get _passwordErrorText {
    final text = _passwordTFController.value.text;
    if (text.isEmpty) {
      return passwordRequired;
    } else {
      return invalidRecords;
    }
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_emailErrorText == null) {
      widget.onSubmit(_emailTFController.value.text);
    }
    if (_passwordErrorText == null) {
      widget.onSubmit(_passwordTFController.value.text);
    }
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 0),
                      child: TextField(
                        controller: _emailTFController,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: _submitted ? _emailErrorText : null,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(32, 24, 32, 24),
                      child: TextField(
                        controller: _passwordTFController,
                        autofocus: true,
                        obscureText: !passwordVisibility,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: _submitted ? _passwordErrorText : null,
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                          ),
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => passwordVisibility = !passwordVisibility,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              passwordVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                              size: 22,
                            ),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 16,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(18, 0, 32, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ToggleIcon(
                            onPressed: () async {
                              setState(() => StoredPreferences.rememberMe =
                                  !StoredPreferences.rememberMe);
                            },
                            value: StoredPreferences.rememberMe,
                            onIcon: Icon(
                              Icons.check_box,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              size: 28,
                            ),
                            offIcon: Icon(
                              Icons.check_box_outline_blank,
                              color:
                                  FlutterFlowTheme.of(context).secondaryColor,
                              size: 28,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Remember Me ',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                            padding: MediaQuery.of(context).viewInsets,
                                        child: ResetPasswordWidget(
                                          onSubmit: (String? value) {},
                                        ));
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          decoration: TextDecoration.underline,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(32, 16, 32, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          surfaceTintColor:
                              FlutterFlowTheme.of(context).primaryBtnText,
                          minimumSize: const Size.fromHeight(36),
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () async {
                          if (!_checkConnection()) return;
                          String email = _emailTFController.text;
                          String password = _passwordTFController.text;
                          loginAttempt = await LoginCall.call(
                            email: email,
                            password: password,
                          );
                          if ((loginAttempt?.succeeded ?? true) &&
                              context.mounted) {
                            setState(() {
                              StoredPreferences.authToken =
                                  functions.createToken(getJsonField(
                                (loginAttempt?.jsonBody ?? ''),
                                r'''$.token''',
                              ).toString());
                              StoredPreferences.userAccount = email;
                              StoredPreferences.userPassword = password;
                            });
                            await context.pushRoute(CoursesRouteWidget());
                          } else {
                            setState(
                                () => AppState().errorsList = (getJsonField(
                                      (loginAttempt?.jsonBody ?? ''),
                                      r'''$.errors..*''',
                                    ) as List)
                                        .map<String>((s) => s.toString())
                                        .toList());
                            _submit();
                          }

                          setState(() {});
                        },
                        child: const Text('SIGN IN WITH ADAPT'),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(32, 24, 32, 24),
                      child: Stack(
                        alignment: const AlignmentDirectional(0, 0),
                        children: [
                          Divider(
                            height: 0,
                            thickness: 1,
                            color: FlutterFlowTheme.of(context).lineColor,
                          ),
                          Container(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
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
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          surfaceTintColor:
                              FlutterFlowTheme.of(context).primaryBtnText,
                          minimumSize: const Size.fromHeight(36),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () async {
                          if (!_checkConnection()) return;
                          await launchURL(
                              'https://sso.libretexts.org/cas/oauth2.0/authorize?response_type=code&client_id=TLvxKEXF5myFPEr3e3EipScuP0jUPB5t3n4A&redirect_uri=https%3A%2F%2Fdev.adapt.libretexts.org%2Fapi%2Foauth%2Flibretexts%2Fcallback%3Fclicker_app%3Dtrue');
                        },
                        child: const Text('CAMPUS LOGIN'),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 120, 0, 0),
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
                                    CreateAccountWidget(
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
        ),
      ),
    );
  }
}
