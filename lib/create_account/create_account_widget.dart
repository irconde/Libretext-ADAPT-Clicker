import '../backend/api_requests/api_calls.dart';
import '../courses_page/courses_page_widget.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../login_page/login_page_widget.dart';
import 'dart:async';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';

String invalidPasswordChar =
    "The password must be at least 8 characters and contain at least one uppercase character, one number, and one special character.";
String passwordRequired = "The password field is required.";
String emailRequired = "The email field is required.";
String emailTaken = "The email has already been taken.";
String invalidEmail = "The email must be a valid email address.";
String firstNameRequired = "The first name field is required.";
String lastNameRequired = "The last name field is required.";

class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({Key? key, required this.onSubmit})
      : super(key: key);
  final ValueChanged<String> onSubmit;

  @override
  _CreateAccountWidgetState createState() => _CreateAccountWidgetState();
}

String checkTop(var topSize) {
  if (topSize <= 120) {
    return "Create Account";
  } else {
    return "Create\nAccount";
  }
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  late bool confirmPasswordFieldCAVisibility = false;

  final emailFieldCAController = TextEditingController();
  final firstNameFieldCAController = TextEditingController();
  final lastNameFieldCAController = TextEditingController();
  final studentIDFieldController = TextEditingController();
  final passwordFieldCAController = TextEditingController();
  final confirmPasswordFieldCAController = TextEditingController();

  bool _submitted = false;

  late bool passwordFieldCAVisibility = false;

  String? tZDropDownCAValue;
  ApiCallResponse? createUser;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

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
  }

  String? get _FNErrorText {
    final text = firstNameFieldCAController.value.text;
    if (text.isEmpty) {
      return firstNameRequired;
    }
    return null;
  }

  String? get _LNErrorText {
    final text = lastNameFieldCAController.value.text;
    if (text.isEmpty) {
      return lastNameRequired;
    }
    return null;
  }

  String? get _emailErrorText {
    final text = emailFieldCAController.value.text;
    if (text.isEmpty) {
      return emailRequired;
    }else if (!text.contains('@')){
      return invalidEmail;
    }else{
      return emailTaken;
    }
  }

  String? get _passwordErrorText {
    final text = passwordFieldCAController.value.text;
    if (text.isEmpty) {
      return passwordRequired;
    }else if (text.length < 8){
      return invalidPasswordChar;
    }
    return null;
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_FNErrorText == null) {
      widget.onSubmit(firstNameFieldCAController.value.text);
    }
    if (_LNErrorText == null) {
      widget.onSubmit(lastNameFieldCAController.value.text);
    }
    if (_emailErrorText == null) {
      widget.onSubmit(emailFieldCAController.value.text);
    }
    if (_passwordErrorText == null) {
      widget.onSubmit(passwordFieldCAController.value.text);
    }

    @override
    void dispose() {
      if (!isWeb) {
        _keyboardVisibilitySubscription.cancel();
      }
      super.dispose();
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
                      background:
                          Image.asset('assets/images/libreAddPerson.png'));
                })),
          ];
        },
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(32, 16, 32, 24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 4),
                        child: TextField(
                          controller: firstNameFieldCAController,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            errorText: _submitted ? _FNErrorText : null, //TODO FIX
                            prefixIcon: Icon(
                              Icons.person_outline,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                        child: TextField(
                          controller: lastNameFieldCAController,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            errorText: _submitted ? _LNErrorText : null, //TODO FIX
                            prefixIcon: Icon(
                              Icons.person_outline,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                        child: TextField(
                          controller: studentIDFieldController,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Student ID',
                            prefixIcon: Icon(
                              Icons.school_outlined,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                        child: TextField(
                          controller: emailFieldCAController,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            errorText: _submitted ? _emailErrorText : null,
                            //TODO FIX
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                        child: TextField(
                          controller: passwordFieldCAController,
                          autofocus: true,
                          obscureText: !passwordFieldCAVisibility,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            errorText: _submitted ? _passwordErrorText : null, //TODO FIX
                            prefixIcon: Icon(
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
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                        child: TextField(
                          controller: confirmPasswordFieldCAController,
                          autofocus: true,
                          obscureText: !confirmPasswordFieldCAVisibility,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            errorText: _submitted ? _passwordErrorText : null, //TODO FIX
                            prefixIcon: Icon(
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
                                color: Color(0xFF757575),
                                size: 22,
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: FlutterFlowDropDown(
                          options: FFAppState.timezoneContainer?.textzones ?? [''],
                          onChanged: (val) =>
                              setState(() => tZDropDownCAValue = FFAppState.timezoneContainer!.getValue(val)),
                          width: 365,
                          height: 50,
                          textStyle: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                            fontFamily: 'Open Sans',
                            color: FlutterFlowTheme.of(context)
                                .primaryText,
                          ),
                          hintText: 'Pick a timezone',
                          icon: Icon(
                            Icons.access_time,
                            size: 15,
                          ),
                          fillColor: FlutterFlowTheme.of(context)
                              .primaryBackground,
                          elevation: 2,
                          borderColor:
                          FlutterFlowTheme.of(context).primaryColor,
                          borderWidth: 1,
                          borderRadius: 0,
                          margin: EdgeInsetsDirectional.fromSTEB(
                              12, 4, 12, 4),
                          hidesUnderline: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!(isWeb
                  ? MediaQuery.of(context).viewInsets.bottom > 0
                  : _isKeyboardVisible))
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                      child: FFButtonWidget(
                        onPressed: () async {
                          createUser = await CreateUserCall.call(
                            email: emailFieldCAController!.text,
                            password: passwordFieldCAController!.text,
                            passwordConfirmation:
                                confirmPasswordFieldCAController!.text,
                            firstName: firstNameFieldCAController!.text,
                            lastName: lastNameFieldCAController!.text,
                            registrationType: '3',
                            studentId: studentIDFieldController!.text,
                            timeZone: 'America/Belize',
                          );
                          if ((createUser?.succeeded ?? true)) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CoursesPageWidget(),
                              ),
                            );
                          } else {
                            _submit();
                            setState(
                                () => FFAppState().errorsList = (getJsonField(
                                      (createUser?.jsonBody ?? ''),
                                      r'''$.errors..*''',
                                    ) as List)
                                        .map<String>((s) => s.toString())
                                        .toList());
                          }

                          setState(() {});
                        },
                        text: 'REGISTER',
                        options: FFButtonOptions(
                          width: 330,
                          height: 36,
                          color: FlutterFlowTheme.of(context).primaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
                      child: Text(
                        'OR',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 20,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await launchURL(
                              'https://sso.libretexts.org/cas/oauth2.0/authorize?response_type=code&client_id=TLvxKEXF5myFPEr3e3EipScuP0jUPB5t3n4A&redirect_uri=https%3A%2F%2Fdev.adapt.libretexts.org%2Fapi%2Foauth%2Flibretexts%2Fcallback%3Fclicker_app%3Dtrue');
                        },
                        text: 'CAMPUS REGISTRATION',
                        options: FFButtonOptions(
                          width: 330,
                          height: 36,
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Open Sans',
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                          InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPageWidget(
                                    onSubmit: (String value) {},
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Login',
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
            ],
          ),
        ),
      ),
    );
  }
}
