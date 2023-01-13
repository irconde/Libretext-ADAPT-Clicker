import 'package:move_to_background/move_to_background.dart';

import '../backend/api_requests/api_calls.dart';
import '../contact_us/contact_us_widget.dart';
import '../courses_page/courses_page_widget.dart';
import '../create_account/create_account_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../login_page/login_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';


class WelcomePageWidget extends StatefulWidget {
  const WelcomePageWidget({Key? key}) : super(key: key);

  @override
  _WelcomePageWidgetState createState() => _WelcomePageWidgetState();
}

class _WelcomePageWidgetState extends State<WelcomePageWidget> {
  ApiCallResponse? getUser;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().rememberMe) {
        if (FFAppState().authToken != null && FFAppState().authToken != '') {
          getUser = await GetUserCall.call(
            token: FFAppState().authToken,
          );
          if ((getUser?.succeeded ?? true)) {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 1000),
                reverseDuration: Duration(milliseconds: 1000),
                child: CoursesPageWidget(),
              ),
            );
          }
        }
      } else {
        setState(() => FFAppState().authToken = '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              width: double.infinity,
              child: Stack(
                alignment: AlignmentDirectional(0, 0),
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, -0.4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, -0.6),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(42, 42, 42, 24),
                            child: SvgPicture.asset(
                              'assets/images/libetext_adapt_logo.svg',
                              width: 270,
                              height: 170,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(32, 0, 32, 8),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              onPrimary: FlutterFlowTheme.of(context).primaryBtnText,
                              minimumSize: Size.fromHeight(36),
                              primary: FlutterFlowTheme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPageWidget(onSubmit: (String value) {},),
                                ),
                              );
                            },
                            child: const Text('LOGIN'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(32, 8, 32, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              onPrimary: FlutterFlowTheme.of(context).primaryColor,
                              minimumSize: Size.fromHeight(36),
                              primary: FlutterFlowTheme.of(context).primaryBackground,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAccountWidget(onSubmit: (String? value) {},),
                                ),
                              );
                            },
                            child: const Text('CREATE ACCOUNT'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 91),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-0.06, 1),
                            child: Text(
                              'Having problems? ',
                              style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.06, 1),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ContactUsWidget(onSubmit: (String? value) {  },),
                                  ),
                                );
                              },
                              child: Text(
                                'Contact us',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Open Sans',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
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
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
      return false;
      },
    );
  }
}