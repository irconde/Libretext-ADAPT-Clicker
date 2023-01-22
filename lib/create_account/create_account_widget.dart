import '../backend/api_requests/api_calls.dart';
import '../courses_page/courses_page_widget.dart';
import 'package:adapt_clicker/components/TimezoneDropdown.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../login_page/login_page_widget.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';

String firstNameRequired = "The first name field is required.";
String lastNameRequired = "The last name field is required.";
String idRequired = "The student ID field is required.";
String emailRequired = "The email field is required.";
String passwordRequired = "The password field is required.";
String confirmPasswordRequired = "The confirm password field is required.";
String invalidRecords = "These credentials do not match our records.";

class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({Key? key, required this.onSubmit})
      : super(key: key);
  final ValueChanged<String?> onSubmit;

  @override
  _CreateAccountWidgetState createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  var top = 0.0;
  bool _submitted = false;

  TextEditingController? firstNameFieldCAController;
  TextEditingController? lastNameFieldCAController;
  TextEditingController? studentIDFieldController;
  TextEditingController? emailFieldCAController;
  TextEditingController? passwordFieldCAController;
  TextEditingController? confirmPasswordFieldCAController;

  late bool passwordFieldCAVisibility;
  late bool confirmPasswordFieldCAVisibility;

  String? tZDropDownCAValue;
  ApiCallResponse? createUser;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  String? get _firstNameErrorText {
    final text = firstNameFieldCAController?.value.text;
    if (text != null && text.isEmpty) {
      return firstNameRequired;
    } else {
      return invalidRecords;
    }
  }

  String? get _lastNameErrorText {
    final text = lastNameFieldCAController?.value.text;
    if (text != null && text.isEmpty) {
      return lastNameRequired;
    } else {
      return invalidRecords;
    }
  }

  String? get _idErrorText {
    final text = studentIDFieldController?.value.text;
    if (text != null && text.isEmpty) {
      return idRequired;
    } else {
      return invalidRecords;
    }
  }

  String? get _emailErrorText {
    final text = emailFieldCAController?.value.text;
    if (text != null && text.isEmpty) {
      return emailRequired;
    } else {
      return invalidRecords;
    }
  }

  String? get _passwordErrorText {
    final text = passwordFieldCAController?.value.text;
    if (text != null && text.isEmpty) {
      return passwordRequired;
    } else {
      return invalidRecords;
    }
  }

  String? get _confirmPasswordErrorText {
    final text = confirmPasswordFieldCAController?.value.text;
    if (text != null && text.isEmpty) {
      return confirmPasswordRequired;
    } else {
      return invalidRecords;
    }
  }

  void _submit() {
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
    }
  }

  String checkTop(var topSize) {
    if (topSize <= 120) {
      return "Create Account";
    } else {
      return "Create\nAccount";
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

    confirmPasswordFieldCAController = TextEditingController();
    confirmPasswordFieldCAVisibility = false;
    emailFieldCAController = TextEditingController();
    firstNameFieldCAController = TextEditingController();
    lastNameFieldCAController = TextEditingController();
    studentIDFieldController = TextEditingController();
    passwordFieldCAController = TextEditingController();
    passwordFieldCAVisibility = false;
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
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      key: scaffoldKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryColor,
                expandedHeight: 160.0,
                pinned: true,
                snap: false,
                floating: false,
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
                        'assets/images/person_add1.svg',
                        fit: BoxFit.scaleDown,
                        color: FlutterFlowTheme.of(context).svgIconColor,
                      ),
                    ),
                  );
                })),
          ];
        },
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                        child: TextField(
                          controller: firstNameFieldCAController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            labelText: 'First Name',
                            errorText: _submitted ? _firstNameErrorText : null,
                            prefixIcon: Icon(
                              Icons.person_outline,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                        child: TextField(
                          controller: lastNameFieldCAController,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            labelText: 'Last Name',
                            errorText: _submitted ? _lastNameErrorText : null,
                            prefixIcon: Icon(
                              Icons.person_outline,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                        child: TextField(
                          controller: studentIDFieldController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.school_outlined,
                            ),
                            labelText: 'Student ID',
                            errorText: _submitted ? _idErrorText : null,
                            hintText: 'Student ID',
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                        child: TextField(
                          controller: emailFieldCAController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            errorText: _submitted ? _emailErrorText : null,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                        child: TextField(
                          controller: passwordFieldCAController,
                          obscureText: !passwordFieldCAVisibility,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            errorText: _submitted ? _passwordErrorText : null,
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
                                size: 20,
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                        child: TextField(
                          controller: confirmPasswordFieldCAController,
                          obscureText: !confirmPasswordFieldCAVisibility,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            labelText: 'Confirm Password',
                            errorText:
                                _submitted ? _confirmPasswordErrorText : null,
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
                                size: 20,
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      TimezoneDropdown(
                          timezoneDropDownValue: tZDropDownCAValue),
                    ],
                  ),
                ),
                if (!(isWeb
                    ? MediaQuery.of(context).viewInsets.bottom > 0
                    : _isKeyboardVisible))
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                              backgroundColor:
                                  FlutterFlowTheme.of(context).primaryColor,
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              minimumSize: Size.fromHeight(36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
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
                                timeZone: tZDropDownCAValue,
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
                              }

                              setState(() {});
                            },
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
                          alignment: AlignmentDirectional(0, 0),
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
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              minimumSize: Size.fromHeight(36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () async {
                              await launchURL(
                                  'https://sso.libretexts.org/cas/oauth2.0/authorize?response_type=code&client_id=TLvxKEXF5myFPEr3e3EipScuP0jUPB5t3n4A&redirect_uri=https%3A%2F%2Fdev.adapt.libretexts.org%2Fapi%2Foauth%2Flibretexts%2Fcallback%3Fclicker_app%3Dtrue');
                            },
                            child: const Text('CAMPUS REGISTRATION'),
                          ),
                        ),
                        Row(
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
                      ],
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
