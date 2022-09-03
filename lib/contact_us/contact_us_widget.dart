import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsWidget extends StatefulWidget {
  const ContactUsWidget({Key? key}) : super(key: key);

  @override
  _ContactUsWidgetState createState() => _ContactUsWidgetState();
}

class _ContactUsWidgetState extends State<ContactUsWidget> {
  ApiCallResponse? contactUs;
  String? contactUsSubjectDropDownValue;
  TextEditingController? contactUsEmailTextFieldController;
  TextEditingController? contactUsNameTextFieldController;
  TextEditingController? contactUsMessageTextFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    contactUsEmailTextFieldController = TextEditingController();
    contactUsNameTextFieldController = TextEditingController();
    contactUsMessageTextFieldController = TextEditingController();
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
                alignment: AlignmentDirectional(-0.73, 0.7),
                child: Text(
                  'Contact\nUs',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        fontSize: 32,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.1, 1),
                child: Image.asset(
                  'assets/images/libreQuestion.png',
                  width: 175,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          actions: [],
          elevation: 2,
        ),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      drawer: Drawer(
        elevation: 16,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              if (responsiveVisibility(
                context: context,
                desktop: false,
              ))
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 90,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(36, 16, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 4, 0),
                                      child: Icon(
                                        Icons.library_books_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .drawerIconColor,
                                        size: 26,
                                      ),
                                    ),
                                    Text(
                                      'Courses',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 4, 0),
                                      child: Icon(
                                        Icons.person_outline,
                                        color: FlutterFlowTheme.of(context)
                                            .drawerIconColor,
                                        size: 26,
                                      ),
                                    ),
                                    Text(
                                      'Profile',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 24),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 4, 0),
                                      child: Icon(
                                        Icons.lock_outlined,
                                        color: FlutterFlowTheme.of(context)
                                            .drawerIconColor,
                                        size: 26,
                                      ),
                                    ),
                                    Text(
                                      'Password',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 8,
                                thickness: 1,
                                endIndent: 40,
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 8, 0, 8),
                                  child: Text(
                                    'Contact Us',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 8,
                                thickness: 1,
                                endIndent: 40,
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(36, 24, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'Log Out',
                              options: FFButtonOptions(
                                width: 220,
                                height: 40,
                                color: Color(0xFF2685C9),
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Open Sans',
                                      color: Colors.white,
                                    ),
                                elevation: 4,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Align(
                alignment: AlignmentDirectional(-0.35, -1.05),
                child: Image.asset(
                  'assets/images/libretexts_logo_main_white.png',
                  width: 250,
                  height: 125,
                  fit: BoxFit.none,
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(36, 0, 36, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                      child: Text(
                        'Please use this form to contact us regarding general questions or issues. If you have a course specific, please contact your instructor using your own email client.',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 14,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: TextFormField(
                        controller: contactUsNameTextFieldController,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Name*',
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
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
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).textFieldBackground,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: TextFormField(
                        controller: contactUsEmailTextFieldController,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Email*',
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
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
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).textFieldBackground,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(1, 1, 1, 1),
                      child: FlutterFlowDropDown(
                        options: ['Option 1'],
                        onChanged: (val) =>
                            setState(() => contactUsSubjectDropDownValue = val),
                        width: double.infinity,
                        height: 50,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyText1.override(
                                  fontFamily: 'Open Sans',
                                  color: Colors.black,
                                ),
                        hintText: 'General Inquiry',
                        fillColor:
                            FlutterFlowTheme.of(context).textFieldBackground,
                        elevation: 2,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        borderRadius: 0,
                        margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                        hidesUnderline: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                      child: TextFormField(
                        controller: contactUsMessageTextFieldController,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: 'Enter Message',
                          hintStyle: FlutterFlowTheme.of(context).bodyText2,
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
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          filled: true,
                          fillColor:
                              FlutterFlowTheme.of(context).textFieldBackground,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 12,
                            ),
                        maxLines: 12,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '*Required Fields',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Open Sans',
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    contactUs = await ContactUsCall.call(
                      email: contactUsEmailTextFieldController!.text,
                      name: contactUsNameTextFieldController!.text,
                      subject: contactUsSubjectDropDownValue,
                      text: contactUsMessageTextFieldController!.text,
                      school: '\"\"',
                      toUserId: '0',
                      type: 'contact_us',
                    );
                    if ((contactUs?.succeeded ?? true)) {
                      Navigator.pop(context);
                    } else {
                      setState(() => FFAppState().errorsList = (getJsonField(
                            (contactUs?.jsonBody ?? ''),
                            r'''$.errors..*.*''',
                          ) as List)
                              .map<String>((s) => s.toString())
                              .toList());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            functions
                                .getTopError(FFAppState().errorsList.toList()),
                            style: TextStyle(
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor: Color(0xFFFF0000),
                        ),
                      );
                    }

                    setState(() {});
                  },
                  text: 'SUBMIT',
                  options: FFButtonOptions(
                    width: 310,
                    height: 40,
                    color: FlutterFlowTheme.of(context).primaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Open Sans',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
