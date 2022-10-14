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



class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

showErrorWidget(){
  if(functions.getTopError(FFAppState().errorsList.toList()).isEmpty) {
    return "Enter Valid Information";
  }else if (functions.getTopError(FFAppState().errorsList.toList()).isNotEmpty){
    return functions.getTopError(FFAppState().errorsList.toList());
  }
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  TextEditingController? textController1;

  TextEditingController? textController2;

  late bool passwordVisibility;

  ApiCallResponse? loginAttempt;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(-0.94, -0.48),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    size: 28,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.73, 0.75),
                child: Text(
                  'Welcome\nBack',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: FlutterFlowTheme.of(context).primaryBtnText,
                        fontSize: 32,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0.5),
                child: Image.asset(
                  'assets/images/libreHand.png',
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          actions: [],
          elevation: 4,
        ),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
            child: Container(
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional(0, 0),
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
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
                                      36, 8, 36, 8),
                                  child: TextFormField(
                                    controller: textController1,
                                    autofocus: true,
                                    obscureText: false,
                                    decoration: InputDecoration(  //TODO - Show Error After Button Press
                                      errorText: showErrorWidget(),
                                      errorStyle: TextStyle(fontSize: 14),
                                      hintText: 'Email',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF1862B3),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF0000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF0000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .textFieldBackground,
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
                                      36, 4, 36, 4),
                                  child: TextFormField(
                                    controller: textController2,
                                    autofocus: true,
                                    obscureText: !passwordVisibility,
                                    decoration: InputDecoration(  //TODO - Show Error After Button Press
                                      errorText: showErrorWidget(),
                                      errorStyle: TextStyle(fontSize: 14),
                                      hintText: 'Password',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyText2,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF1862B3),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF0000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFFF0000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .textFieldBackground,
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
                                      24, 0, 36, 12),
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
                                          size: 25,
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      child:
                                                          ResetPasswordWidget(),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
                                                'Forgot Password',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Open Sans',
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      36, 0, 36, 15),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      loginAttempt = await LoginCall.call(
                                        email: textController1!.text,
                                        password: textController2!.text,
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
                                      }
                                      //TODO - Potentially Remove Snackbar Errors
                                      else {
                                        setState(() => FFAppState().errorsList =
                                                (getJsonField(
                                              (loginAttempt?.jsonBody ?? ''),
                                              r'''$.errors..*''',
                                            ) as List)
                                                    .map<String>(
                                                        (s) => s.toString())
                                                    .toList());
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   SnackBar(
                                        //     content: Text(
                                        //       functions.getTopError(FFAppState()
                                        //           .errorsList
                                        //           .toList()),
                                        //       style: GoogleFonts.getFont(
                                        //         'Open Sans',
                                        //         color:
                                        //             FlutterFlowTheme.of(context)
                                        //                 .primaryBtnText,
                                        //         fontSize: 18,
                                        //       ),
                                        //     ),
                                        //     duration:
                                        //         Duration(milliseconds: 4000),
                                        //     backgroundColor:
                                        //         FlutterFlowTheme.of(context)
                                        //             .failure,
                                        //   ),
                                        // );
                                      }

                                      setState(() {});
                                    },
                                    text: 'Sign in with Adapt',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 50,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
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
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      36, 12, 36, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      await launchURL(
                                          'https://sso.libretexts.org/cas/oauth2.0/authorize?response_type=code&client_id=TLvxKEXF5myFPEr3e3EipScuP0jUPB5t3n4A&redirect_uri=https%3A%2F%2Fdev.adapt.libretexts.org%2Fapi%2Foauth%2Flibretexts%2Fcallback%3Fclicker_app%3Dtrue');
                                    },
                                    text: 'Campus Login',
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 50,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .subtitle2
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            fontSize: 20,
                                          ),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
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
                                            CreateAccountWidget(),
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
