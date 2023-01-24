import 'package:flutter/gestures.dart';
import '../backend/api_requests/api_calls.dart';
import '../components/reset_password_widget.dart';
import '../courses_page/courses_page_widget.dart';
import '../create_account/create_account_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String passwordRequired = "The password field is required.";
String emailRequired = "The email field is required.";
String invalidRecords = "These credentials do not match our records.";

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  bool _submitted = false;

  late bool passwordVisibility;

  ApiCallResponse? loginAttempt;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
  }

  String? get _emailErrorText {
    final text = _controller1.value.text;
    if (text.isEmpty) {
      return emailRequired;
    } else {
      return invalidRecords;
    }
  }

  String? get _passwordErrorText {
    final text = _controller2.value.text;
    if (text.isEmpty) {
      return passwordRequired;
    } else {
      return invalidRecords;
    }
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_emailErrorText == null) {
      widget.onSubmit(_controller1.value.text);
    }
    if (_passwordErrorText == null) {
      widget.onSubmit(_controller2.value.text);
    }
  }

  String checkTop(var topSize) {
    if (topSize <= 120) {
      return "Welcome Back";
    } else {
      return "Welcome\nBack";
    }
  }

  @override
  Widget build(BuildContext context) {
    var top = 0.0;
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      key: scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                expandedHeight: 160.0,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                    titlePadding:
                        const EdgeInsetsDirectional.fromSTEB(48, 0, 0, 12),
                    title: Text(checkTop(top),
                        style: FlutterFlowTheme.of(context).title2),
                    background: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(64, 28, 0, 0),
                      child: SvgPicture.asset(
                        'assets/images/hand_wave.svg',
                        fit: BoxFit.scaleDown,
                        color: FlutterFlowTheme.of(context).svgIconColor2,
                      ),
                    ),
                  );
                })),
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
                        controller: _controller1,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: _submitted ? _emailErrorText : null,
                          prefixIcon: Icon(
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
                      padding: EdgeInsetsDirectional.fromSTEB(32, 24, 32, 24),
                      child: TextField(
                        controller: _controller2,
                        autofocus: true,
                        obscureText: !passwordVisibility,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: _submitted ? _passwordErrorText : null,
                          prefixIcon: Icon(
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
                              setState(() => AppState().rememberMe =
                                  !AppState().rememberMe);
                            },
                            value: AppState().rememberMe,
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
                                        return ResetPasswordWidget(
                                          onSubmit: (String? value) {},
                                        );
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
                      padding: EdgeInsetsDirectional.fromSTEB(32, 16, 32, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          surfaceTintColor:
                              FlutterFlowTheme.of(context).primaryBtnText,
                          minimumSize: Size.fromHeight(36),
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () async {
                          loginAttempt = await LoginCall.call(
                            email: _controller1.text,
                            password: _controller2.text,
                          );
                          if ((loginAttempt?.succeeded ?? true)) {
                            setState(() => AppState().authToken =
                                    functions.createToken(getJsonField(
                                  (loginAttempt?.jsonBody ?? ''),
                                  r'''$.token''',
                                ).toString()));
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CoursesPageWidget(),
                              ),
                            );
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
                        alignment: AlignmentDirectional(0, 0),
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
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          surfaceTintColor:
                              FlutterFlowTheme.of(context).primaryBtnText,
                          minimumSize: Size.fromHeight(36),
                          backgroundColor:
                              FlutterFlowTheme.of(context).secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () async {
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
                          TextSpan(text: 'Don\'t have an account? '),
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
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateAccountWidget(
                                        onSubmit: (String? value) {},
                                      ),
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
