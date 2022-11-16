import '../backend/api_requests/api_calls.dart';
import '../contact_us/contact_us_widget.dart';
import '../courses_page/courses_page_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../reset_password_page/reset_password_page_widget.dart';
import '../update_profile_page/update_profile_page_widget.dart';
import '../welcome_page/welcome_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerCtnWidget extends StatefulWidget {
  const DrawerCtnWidget({Key? key}) : super(key: key);

  @override
  _DrawerCtnWidgetState createState() => _DrawerCtnWidgetState();
}

class _DrawerCtnWidgetState extends State<DrawerCtnWidget> {
  ApiCallResponse? logout;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
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
                    height: 120,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryColor,
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(32, 32, 32, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CoursesPageWidget(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.menu_book,
                                  color: FlutterFlowTheme.of(context)
                                      .mainGrey,
                                  size: 28,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 4),
                                  child: Text(
                                    'Courses',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Open Sans',
                                      color:
                                      FlutterFlowTheme.of(context)
                                          .mainGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).mainGrey,
                        ),
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateProfilePageWidget(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.person_sharp,
                                  color: FlutterFlowTheme.of(context)
                                      .mainGrey,
                                  size: 28,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 4),
                                  child: Text(
                                    'My Profile',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Open Sans',
                                      color:
                                      FlutterFlowTheme.of(context)
                                          .mainGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 24, 0, 24),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ResetPasswordPageWidget(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.lock_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .mainGrey,
                                  size: 28,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 4),
                                  child: Text(
                                    'My Password',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Open Sans',
                                      color:
                                      FlutterFlowTheme.of(context)
                                          .mainGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: FlutterFlowTheme.of(context).mainGrey,
                        ),
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactUsWidget(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.send_sharp,
                                  color: FlutterFlowTheme.of(context)
                                      .mainGrey,
                                  size: 28,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 0, 4),
                                  child: Text(
                                    'Contact Us',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                      fontFamily: 'Open Sans',
                                      color:
                                      FlutterFlowTheme.of(context)
                                          .mainGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
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
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, 1),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(32, 0, 32, 32),
              child: FFButtonWidget(
                onPressed: () async {
                  logout = await LogoutCall.call(
                    token: FFAppState().authToken,
                  );
                  setState(() => FFAppState().authToken = '');
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WelcomePageWidget(),
                    ),
                  );

                  setState(() {});
                },
                text: 'LOGOUT',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 36,
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  textStyle:
                  FlutterFlowTheme.of(context).subtitle2.override(
                    fontFamily: 'Open Sans',
                    color: FlutterFlowTheme.of(context).mainGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  elevation: 0,
                  borderSide: BorderSide(
                    color: FlutterFlowTheme.of(context).borderGrey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
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
    );

  }
}
