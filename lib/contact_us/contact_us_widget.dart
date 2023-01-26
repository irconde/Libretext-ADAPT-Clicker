import 'package:auto_route/auto_route.dart';
import 'package:adapt_clicker/components/collapsing_libre_app_bar.dart';

import '../backend/api_requests/api_calls.dart';
import 'package:adapt_clicker/components/ContactUsDropDownList.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

String nameRequired = "The name field is required.";
String emailRequired = "The email field is required.";
String messageRequired = "The message field is required.";
String invalidRecords = "These credentials do not match our records.";

class ContactUsWidget extends StatefulWidget {
  const ContactUsWidget({Key? key, required this.onSubmit}) : super(key: key);
  final ValueChanged<String?> onSubmit;

  @override
  _ContactUsWidgetState createState() => _ContactUsWidgetState();
}

class _ContactUsWidgetState extends State<ContactUsWidget> {
  TextEditingController? contactUsEmailTextFieldController;
  TextEditingController? contactUsNameTextFieldController;
  String? contactUsSubjectDropDownValue;
  TextEditingController? contactUsMessageTextFieldController;
  bool _submitted = false;

  ApiCallResponse? contactUs;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    contactUsEmailTextFieldController = TextEditingController();
    contactUsNameTextFieldController = TextEditingController();
    contactUsMessageTextFieldController = TextEditingController();
  }

  String? get _emailErrorText {
    final text = contactUsEmailTextFieldController?.value.text;
    if (text != null && text.isEmpty) {
      return emailRequired;
    } else {
      return invalidRecords;
    }
  }

  String? get _nameErrorText {
    final text = contactUsNameTextFieldController?.value.text;
    if (text != null && text.isEmpty) {
      return nameRequired;
    } else {
      return invalidRecords;
    }
  }

  String? get _messageErrorText {
    final text = contactUsMessageTextFieldController?.value.text;
    if (text != null && text.isEmpty) {
      return messageRequired;
    } else {
      return invalidRecords;
    }
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_emailErrorText == null) {
      widget.onSubmit(contactUsEmailTextFieldController?.value.text);
    }
    if (_nameErrorText == null) {
      widget.onSubmit(contactUsNameTextFieldController?.value.text);
    }
    if (_messageErrorText == null) {
      widget.onSubmit(contactUsMessageTextFieldController?.value.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CollapsingLibreAppBar(
              titleNoSpace: "Contact Us",
              titleSpace: "Contact\nUs",
              iconPath: 'assets/images/contact_support.svg',
              svgIconColor: FlutterFlowTheme.of(context).svgIconColor,
            ),
          ];
        },
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
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                  fontFamily: 'Open Sans',
                                  lineHeight: 1.5,
                                  fontWeight: FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                        child: TextField(
                            autofocus: true,
                            controller: contactUsNameTextFieldController,
                            decoration: InputDecoration(
                              labelText: 'Name*',
                              errorText: _submitted ? _nameErrorText : null,
                              hintText: 'FirstName LastName',
                            )),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                        child: TextField(
                          controller: contactUsEmailTextFieldController,
                          decoration: InputDecoration(
                            labelText: 'Email*',
                            floatingLabelStyle: TextStyle(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor),
                            errorText: _submitted ? _emailErrorText : null,
                            hintText: 'example@email.com',
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      ContactUsDropDownList(
                          contactUsSubjectDropDownValue:
                              contactUsSubjectDropDownValue),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.top,
                          controller: contactUsMessageTextFieldController,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            errorText: _submitted ? _messageErrorText : null,
                            hintText: 'Enter Message',
                            alignLabelWithHint: true,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Open Sans',
                                    fontSize: 14,
                                  ),
                          maxLines: 8,
                        ),
                      ),
                      Align(
                        alignment: Alignment(1, 0),
                        child: Text(
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
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(36),
                            backgroundColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
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
                              context.popRoute();
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
                              _submit();
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
      ),
    );
  }
}
