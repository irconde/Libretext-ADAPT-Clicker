import 'package:adapt_clicker/flutter_flow/app_router.gr.dart';
import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';

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
      width: 270,
      child: Container(
        width: double.infinity,
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryColor,
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: SvgPicture.asset(
                        'assets/images/libretexts_adapt_logo.svg',
                        fit: BoxFit.none,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(Constants.msMargin,
                        Constants.mmMargin, Constants.msMargin, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: TextButton.icon(
                                  icon: Icon(
                                    Icons.menu_book,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryColor,
                                    size: Constants.drawerIconSize,
                                  ),
                                  label: Text('Courses'),
                                  style: TextButton.styleFrom(
                                      foregroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryColor,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          )),
                                  onPressed: () async {
                                    context.pushRoute(CoursesRouteWidget());
                                  }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                height: Constants.llMargin,
                                thickness: Constants.dividerThickness,
                                color: FlutterFlowTheme.of(context).lineColor,
                              ),
                            ),
                            TextButton.icon(
                                icon: Icon(
                                  Icons.person_sharp,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryColor,
                                  size: Constants.drawerIconSize,
                                ),
                                label: Text('My Profile'),
                                style: TextButton.styleFrom(
                                    foregroundColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
                                onPressed: () async {
                                  context.pushRoute(UpdateProfileRouteWidget(
                                    onSubmit: (String? value) {},
                                  ));
                                }),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, Constants.xsMargin, 0, 0),
                              child: TextButton.icon(
                                  icon: Icon(
                                    Icons.lock_rounded,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryColor,
                                    size: Constants.drawerIconSize,
                                  ),
                                  label: Text('My Password'),
                                  style: TextButton.styleFrom(
                                      foregroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryColor,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          )),
                                  onPressed: () async {
                                    context.pushRoute(ResetPasswordRouteWidget(
                                      onSubmit: (String value) {},
                                    ));
                                  }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                height: Constants.llMargin,
                                thickness: 1,
                                color: FlutterFlowTheme.of(context).lineColor,
                              ),
                            ),
                            TextButton.icon(
                                icon: Icon(
                                  Icons.send_sharp,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryColor,
                                  size: Constants.drawerIconSize,
                                ),
                                label: Text('Contact Us'),
                                style: TextButton.styleFrom(
                                    foregroundColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
                                onPressed: () async {
                                  context.pushRoute(
                                    ContactUsWidget(
                                      onSubmit: (String? value) {},
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(Constants.mmMargin),
                  child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        foregroundColor:
                            FlutterFlowTheme.of(context).secondaryColor,
                        fixedSize: const Size(330, 36),
                        backgroundColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      onPressed: () async {
                        logout = await LogoutCall.call(
                          token: StoredPreferences.authToken,
                        );
                        setState(() {
                          StoredPreferences.authToken = '';
                          StoredPreferences.userAccount = '';
                          StoredPreferences.userPassword = '';
                        });
                        await context.pushRoute(WelcomeRouteWidget());
                        setState(() {});
                      },
                      child: Text('LOGOUT')),
                )),
          ],
        ),
      ),
    );
  }
}
