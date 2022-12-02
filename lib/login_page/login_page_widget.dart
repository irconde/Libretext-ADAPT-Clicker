import '../backend/api_requests/api_calls.dart';
import '../components/reset_password_widget.dart';
import '../courses_page/courses_page_widget.dart';
import '../create_account/create_account_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    }else{
      return invalidRecords;
    }
  }

  String? get _passwordErrorText {
    final text = _controller2.value.text;
    if (text.isEmpty) {
      return passwordRequired;
    }else{
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: 160.0,
                pinned: true,
                snap: false,
                floating: false,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: 1.0,
                          child: Text(checkTop(top))),
                      background: Image.asset('assets/images/libreHand.png'));
                })),
          ];
        },
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Container(
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional(0, 0),
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      35, 0, 35, 12),
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
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      35, 12, 35, 12),
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
                                          () => passwordVisibility =
                                              !passwordVisibility,
                                        ),
                                        focusNode:
                                            FocusNode(skipTraversal: true),
                                        child: Icon(
                                          passwordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Color(0xFF757575),
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
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 12, 35, 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ToggleIcon(
                                        onPressed: () async {
                                          setState(() =>
                                              FFAppState().rememberMe =
                                                  !FFAppState().rememberMe);
                                        },
                                        value: FFAppState().rememberMe,
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
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Remember Me ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Open Sans',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                      ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      child:
                                                          ResetPasswordWidget(onSubmit: (String? value) {  },),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
                                                'Forgot Password?',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Open Sans',
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                  padding: EdgeInsetsDirectional.fromSTEB(35, 12, 35, 12),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      textStyle: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.w600),
                                      onPrimary: FlutterFlowTheme.of(context).primaryBtnText,
                                      fixedSize: const Size(330, 36),
                                      primary: FlutterFlowTheme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    onPressed: () async {
                                      loginAttempt = await LoginCall.call(
                                        email: _controller1!.text,
                                        password: _controller2!.text,
                                      );
                                      if ((loginAttempt?.succeeded ?? true)) {
                                        setState(() => FFAppState().authToken =
                                                functions
                                                    .createToken(getJsonField(
                                              (loginAttempt?.jsonBody ?? ''),
                                              r'''$.token''',
                                            ).toString()));
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CoursesPageWidget(),
                                          ),
                                        );
                                      } else {
                                        setState(() => FFAppState().errorsList =
                                                (getJsonField(
                                              (loginAttempt?.jsonBody ?? ''),
                                              r'''$.errors..*''',
                                            ) as List)
                                                    .map<String>(
                                                        (s) => s.toString())
                                                    .toList());
                                        _submit();
                                      }

                                      setState(() {});
                                    },
                                    child: const Text('SIGN IN WITH ADAPT'),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Text(
                                        'OR',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText1
                                            .override(
                                              fontFamily: 'Open Sans',
                                              fontSize: 22,
                                              color: FlutterFlowTheme.of(context).secondaryText,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(35, 12, 35, 0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      textStyle: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.w600),
                                      onPrimary: FlutterFlowTheme.of(context).primaryBtnText,
                                      fixedSize: const Size(330, 36),
                                      primary: FlutterFlowTheme.of(context).secondaryColor,
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
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account? ',
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CreateAccountWidget(onSubmit: (String? value) {  },),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
