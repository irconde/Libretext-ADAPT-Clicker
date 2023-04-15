import 'package:adapt_clicker/flutter_flow/app_router.gr.dart';
import 'package:adapt_clicker/utils/stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';
import '../utils/check_internet_connectivity.dart';
import '../flutter_flow/custom_functions.dart' as functions;

enum DrawerItems { courses, profile, password, contact }

class DrawerCtnWidget extends ConsumerStatefulWidget {
  final DrawerItems? currentSelected;
  const DrawerCtnWidget({Key? key, this.currentSelected}) : super(key: key);

  @override
  ConsumerState<DrawerCtnWidget> createState() => _DrawerCtnWidgetState();
}

class _DrawerCtnWidgetState extends ConsumerState<DrawerCtnWidget> {
  ApiCallResponse? logout;

  bool _checkConnection() {
    ConnectivityStatus? status =
        ref.read(provider.notifier).getConnectionStatus();
    if (status != ConnectivityStatus.isConnected) {
      functions.showSnackbar(context, status);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 273,
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
                      child: Padding(
                        padding: const EdgeInsets.all(Constants.msMargin),
                        child: SvgPicture.asset(
                          'assets/images/libretexts_adapt_logo.svg',
                          fit: BoxFit.scaleDown,
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(Constants.msMargin,
                        Constants.msMargin, Constants.msMargin, 0),
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
                              padding: const EdgeInsets.all(0),
                              child: TextButton.icon(
                                  icon: Icon(
                                    Icons.menu_book,
                                    color: widget.currentSelected ==
                                            DrawerItems.courses
                                        ? FlutterFlowTheme.of(context)
                                            .primaryColor
                                        : FlutterFlowTheme.of(context)
                                            .secondaryColor,
                                    size: Constants.drawerIconSize,
                                  ),
                                  label: const Text('Courses'),
                                  style: TextButton.styleFrom(
                                      fixedSize: const Size(224, 48),
                                      padding: const EdgeInsets.only(left: 12),
                                      alignment: Alignment.centerLeft,
                                      foregroundColor: widget.currentSelected ==
                                              DrawerItems.courses
                                          ? FlutterFlowTheme.of(context)
                                              .primaryColor
                                          : FlutterFlowTheme.of(context)
                                              .secondaryColor,
                                      backgroundColor: widget.currentSelected ==
                                              DrawerItems.courses
                                          ? FlutterFlowTheme.of(context)
                                              .lightPrimaryColor
                                          : Colors.white,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            fontSize: 14,
                                            fontWeight:
                                                widget.currentSelected ==
                                                        DrawerItems.courses
                                                    ? FontWeight.w700
                                                    : FontWeight.normal,
                                          )),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    if (widget.currentSelected ==
                                        DrawerItems.courses) return;
                                    context.pushRoute(CoursesRouteWidget());
                                  }),
                            ),
                            Divider(
                              height: Constants.llMargin,
                              thickness: Constants.dividerThickness,
                              color: FlutterFlowTheme.of(context).lineColor,
                            ),
                            TextButton.icon(
                                icon: Icon(
                                  Icons.person_sharp,
                                  color: widget.currentSelected ==
                                          DrawerItems.profile
                                      ? FlutterFlowTheme.of(context)
                                          .primaryColor
                                      : FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                  size: Constants.drawerIconSize,
                                ),
                                label: const Text('My Profile'),
                                style: TextButton.styleFrom(
                                    fixedSize: const Size(224, 48),
                                    padding: const EdgeInsets.only(left: 12),
                                    alignment: Alignment.centerLeft,
                                    backgroundColor: widget.currentSelected ==
                                            DrawerItems.profile
                                        ? FlutterFlowTheme.of(context)
                                            .lightPrimaryColor
                                        : Colors.white,
                                    foregroundColor: widget.currentSelected ==
                                            DrawerItems.profile
                                        ? FlutterFlowTheme.of(context)
                                            .primaryColor
                                        : FlutterFlowTheme.of(context)
                                            .secondaryColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontSize: 14,
                                          fontWeight: widget.currentSelected ==
                                                  DrawerItems.profile
                                              ? FontWeight.w700
                                              : FontWeight.normal,
                                        )),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  if (widget.currentSelected ==
                                      DrawerItems.profile) return;
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
                                    color: widget.currentSelected ==
                                            DrawerItems.password
                                        ? FlutterFlowTheme.of(context)
                                            .primaryColor
                                        : FlutterFlowTheme.of(context)
                                            .secondaryColor,
                                    size: Constants.drawerIconSize,
                                  ),
                                  label: const Text('My Password'),
                                  style: TextButton.styleFrom(
                                      fixedSize: const Size(224, 48),
                                      padding: const EdgeInsets.only(left: 12),
                                      alignment: Alignment.centerLeft,
                                      backgroundColor: widget.currentSelected ==
                                              DrawerItems.password
                                          ? FlutterFlowTheme.of(context)
                                              .lightPrimaryColor
                                          : Colors.white,
                                      foregroundColor: widget.currentSelected ==
                                              DrawerItems.password
                                          ? FlutterFlowTheme.of(context)
                                              .primaryColor
                                          : FlutterFlowTheme.of(context)
                                              .secondaryColor,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Open Sans',
                                            fontSize: 14,
                                            fontWeight:
                                                widget.currentSelected ==
                                                        DrawerItems.password
                                                    ? FontWeight.w700
                                                    : FontWeight.normal,
                                          )),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    if (widget.currentSelected ==
                                        DrawerItems.password) return;
                                    context.pushRoute(ResetPasswordRouteWidget(
                                      onSubmit: (String value) {},
                                    ));
                                  }),
                            ),
                            Divider(
                              height: Constants.llMargin,
                              thickness: 1,
                              color: FlutterFlowTheme.of(context).lineColor,
                            ),
                            TextButton.icon(
                                icon: Icon(
                                  Icons.send_sharp,
                                  color: widget.currentSelected ==
                                          DrawerItems.contact
                                      ? FlutterFlowTheme.of(context)
                                          .primaryColor
                                      : FlutterFlowTheme.of(context)
                                          .secondaryColor,
                                  size: Constants.drawerIconSize,
                                ),
                                label: const Text('Contact Us'),
                                style: TextButton.styleFrom(
                                    fixedSize: const Size(224, 48),
                                    padding: const EdgeInsets.only(left: 12),
                                    alignment: Alignment.centerLeft,
                                    backgroundColor: widget.currentSelected ==
                                            DrawerItems.contact
                                        ? FlutterFlowTheme.of(context)
                                            .lightPrimaryColor
                                        : Colors.white,
                                    foregroundColor: widget.currentSelected ==
                                            DrawerItems.contact
                                        ? FlutterFlowTheme.of(context)
                                            .primaryColor
                                        : FlutterFlowTheme.of(context)
                                            .secondaryColor,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontSize: 14,
                                          fontWeight: widget.currentSelected ==
                                                  DrawerItems.contact
                                              ? FontWeight.w700
                                              : FontWeight.normal,
                                        )),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  if (widget.currentSelected ==
                                      DrawerItems.contact) return;
                                  context.pushRoute(
                                    ContactUsWidget(
                                      onSubmit: (String? value) {},
                                      openFromDrawer: true,
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
                  padding: const EdgeInsets.all(Constants.msMargin),
                  child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                        foregroundColor:
                            FlutterFlowTheme.of(context).secondaryColor,
                        fixedSize: const Size(330, 36),
                        backgroundColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () async {
                        if (!_checkConnection()) return;
                        logout = await LogoutCall.call(
                          token: StoredPreferences.authToken,
                        );
                        setState(() {
                          StoredPreferences.authToken = '';
                          StoredPreferences.userAccount = '';
                          StoredPreferences.userPassword = '';
                        });
                        if (context.mounted) {
                          await context.pushRoute(WelcomeRouteWidget());
                        }
                        setState(() {});
                      },
                      child: const Text('LOGOUT')),
                )),
          ],
        ),
      ),
    );
  }
}
