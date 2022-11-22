import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUsWidget extends StatefulWidget {
  const ContactUsWidget({Key? key}) : super(key: key);

  @override
  _ContactUsWidgetState createState() => _ContactUsWidgetState();
}

class _ContactUsWidgetState extends State<ContactUsWidget> {
  TextEditingController? contactUsEmailTextFieldController;

  TextEditingController? contactUsNameTextFieldController;

  String? contactUsSubjectDropDownValue;

  TextEditingController? contactUsMessageTextFieldController;

  ApiCallResponse? contactUs;
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
            Size.fromHeight(MediaQuery.of(context).size.height * 0.27),
        child: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(-.96, -0.74),
                child: InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    size: 38,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.75, 0.6),
                child: Text(
                  'Contact\nUs',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Open Sans',
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      fontSize: 38,
                      lineHeight: 1.1,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-.11, .85),
                child: SvgPicture.asset(
                  'assets/images/contact_support.svg',
                ),
              ),
            ],
          ),
          actions: [],
          elevation: 0,
        ),
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(32, 32, 32, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 32),
                      child: Text(
                        'Please use this form to contact us regarding general  questions or issues.',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Open Sans',
                            lineHeight: 1.5,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                      child: TextField(
                        controller: contactUsNameTextFieldController,
                        decoration: InputDecoration(
                          labelText: 'Name*',
                          hintText: 'FirstName LastName',
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: FlutterFlowTheme.of(context)
                                    .textFieldBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor),
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).textFieldBackground,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                      child: TextField(
                        controller: contactUsEmailTextFieldController,
                        decoration: InputDecoration(
                          labelText: 'Email*',
                          hintText: 'example@email.com',
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: FlutterFlowTheme.of(context)
                                    .textFieldBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor),
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).textFieldBackground,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: FlutterFlowTheme.of(context).textFieldBorder, width:1),
                          color: FlutterFlowTheme.of(context).textFieldBackground,
                        ),
                        child: DropdownButton<String>(
                          value: contactUsSubjectDropDownValue,
                          isExpanded: true,
                          items: <String>[
                            'General Inquiry',
                            'Technical Issue',
                            'Email Change',
                            'Request Instructor Access Code',
                            'Request Tester Access Code',
                            'Integrating ADAPT with LMS',
                            'Other'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                child: Text(
                                  value,
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                            );
                          }).toList(),
                          dropdownColor:
                              FlutterFlowTheme.of(context).textFieldBackground,
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              contactUsSubjectDropDownValue = value!;
                            });
                          },
                          style: FlutterFlowTheme.of(context).bodyText1,
                          hint: Text(
                            'General Inquiry',
                            style: FlutterFlowTheme.of(context).bodyText1,
                          ),
                          elevation: 2,
                          focusColor:
                              FlutterFlowTheme.of(context).textFieldBackground,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.top,
                        controller: contactUsMessageTextFieldController,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Message',
                          hintText: 'Enter Message',
                          alignLabelWithHint: true,
                          labelStyle: FlutterFlowTheme.of(context).bodyText2,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: FlutterFlowTheme.of(context)
                                    .textFieldBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color:
                                    FlutterFlowTheme.of(context).primaryColor),
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).textFieldBackground,
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Open Sans',
                              fontSize: 14,
                            ),
                        maxLines: 8,
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
                                fontSize: 12,
                              ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(32, 12, 32, 32),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          primary: FlutterFlowTheme.of(context).primaryColor,
                          fixedSize: const Size(330, 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Inquiry Sent',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBtnText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).success,
                              ),
                            );
                          } else {
                            setState(
                                () => FFAppState().errorsList = (getJsonField(
                                      (contactUs?.jsonBody ?? ''),
                                      r'''$.errors..*''',
                                    ) as List)
                                        .map<String>((s) => s.toString())
                                        .toList());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  functions.getTopError(
                                      FFAppState().errorsList.toList()),
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBtnText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: Color(0xFFFF0000),
                              ),
                            );
                          }

                          setState(() {});
                        },
                        child: const Text('SUBMIT'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
