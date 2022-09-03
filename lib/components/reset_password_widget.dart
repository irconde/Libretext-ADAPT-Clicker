import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../welcome_page/welcome_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({Key? key}) : super(key: key);

  @override
  _ResetPasswordWidgetState createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  ApiCallResponse? forgotPassword;
  TextEditingController? forgotPasswordEmailFieldController;

  @override
  void initState() {
    super.initState();
    forgotPasswordEmailFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/lock.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
                Text(
                  'Password Recovery',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Open Sans',
                        color: FlutterFlowTheme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                ),
              ],
            ),
            Divider(
              height: 48,
              thickness: 1,
              color: FlutterFlowTheme.of(context).secondaryColor,
            ),
            Text(
              'Please enter the email address used for \nregistration.',
              textAlign: TextAlign.start,
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Open Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 24),
              child: Container(
                width: 300,
                child: TextFormField(
                  controller: forgotPasswordEmailFieldController,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Email',
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
                    fillColor: FlutterFlowTheme.of(context).textFieldBackground,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                    ),
                  ),
                  style: FlutterFlowTheme.of(context).bodyText1,
                ),
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                forgotPassword = await ForgotPasswordCall.call(
                  email: forgotPasswordEmailFieldController!.text,
                );
                if ((forgotPassword?.succeeded ?? true)) {
                  await Future.delayed(const Duration(milliseconds: 3000));
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 300),
                      reverseDuration: Duration(milliseconds: 300),
                      child: WelcomePageWidget(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        getJsonField(
                          (forgotPassword?.jsonBody ?? ''),
                          r'''$.message''',
                        ).toString(),
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryBtnText,
                        ),
                      ),
                      duration: Duration(milliseconds: 4000),
                      backgroundColor: Color(0xFFFF0000),
                    ),
                  );
                }

                setState(() {});
              },
              text: 'RESET PASSWORD',
              options: FFButtonOptions(
                width: 300,
                height: 40,
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                      fontFamily: 'Open Sans',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
