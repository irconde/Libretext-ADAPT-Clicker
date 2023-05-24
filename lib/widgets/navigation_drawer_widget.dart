import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import '../backend/router/app_router.gr.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/constants.dart';

enum DrawerItems { courses, profile, password, contact }

class NavigationDrawerWidget extends ConsumerStatefulWidget {
  final DrawerItems? currentSelected;

  const NavigationDrawerWidget({Key? key, this.currentSelected}) : super(key: key);

  @override
  ConsumerState<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends ConsumerState<NavigationDrawerWidget>
    with ConnectionStateMixin {
  ApiCallResponse? logout;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 273,
      child: Container(
        width: double.infinity,
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: AppTheme.of(context).primaryBackground,
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
                      color: AppTheme.of(context).primaryColor,
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.all(Constants.msMargin),
                        child: SvgPicture.asset(
                          'assets/images/libretexts_adapt_logo.svg',
                          fit: BoxFit.scaleDown,
                          color: AppTheme.of(context).primaryBackground,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        Constants.msMargin,
                        Constants.msMargin,
                        Constants.msMargin,
                        0),
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
                                        ? AppTheme.of(context)
                                            .primaryColor
                                        : AppTheme.of(context)
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
                                          ? AppTheme.of(context)
                                              .primaryColor
                                          : AppTheme.of(context)
                                              .secondaryColor,
                                      backgroundColor: widget.currentSelected ==
                                              DrawerItems.courses
                                          ? AppTheme.of(context)
                                              .lightPrimaryColor
                                          : Colors.white,
                                      textStyle: AppTheme.of(context)
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
                              color: AppTheme.of(context).lineColor,
                            ),
                            TextButton.icon(
                                icon: Icon(
                                  Icons.person_sharp,
                                  color: widget.currentSelected ==
                                          DrawerItems.profile
                                      ? AppTheme.of(context)
                                          .primaryColor
                                      : AppTheme.of(context)
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
                                        ? AppTheme.of(context)
                                            .lightPrimaryColor
                                        : Colors.white,
                                    foregroundColor: widget.currentSelected ==
                                            DrawerItems.profile
                                        ? AppTheme.of(context)
                                            .primaryColor
                                        : AppTheme.of(context)
                                            .secondaryColor,
                                    textStyle: AppTheme.of(context)
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
                                          DrawerItems.profile ||
                                      !checkConnection()) {
                                    return;
                                  }
                                  context.pushRoute(
                                      const UpdateProfileRouteWidget());
                                }),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, Constants.xsMargin, 0, 0),
                              child: TextButton.icon(
                                  icon: Icon(
                                    Icons.lock_rounded,
                                    color: widget.currentSelected ==
                                            DrawerItems.password
                                        ? AppTheme.of(context)
                                            .primaryColor
                                        : AppTheme.of(context)
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
                                          ? AppTheme.of(context)
                                              .lightPrimaryColor
                                          : Colors.white,
                                      foregroundColor: widget.currentSelected ==
                                              DrawerItems.password
                                          ? AppTheme.of(context)
                                              .primaryColor
                                          : AppTheme.of(context)
                                              .secondaryColor,
                                      textStyle: AppTheme.of(context)
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
                                            DrawerItems.password ||
                                        !checkConnection()) {
                                      return;
                                    }
                                    context.pushRoute(
                                        const ResetPasswordRouteWidget());
                                  }),
                            ),
                            Divider(
                              height: Constants.llMargin,
                              thickness: 1,
                              color: AppTheme.of(context).lineColor,
                            ),
                            TextButton.icon(
                                icon: Icon(
                                  Icons.send_sharp,
                                  color: widget.currentSelected ==
                                          DrawerItems.contact
                                      ? AppTheme.of(context)
                                          .primaryColor
                                      : AppTheme.of(context)
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
                                        ? AppTheme.of(context)
                                            .lightPrimaryColor
                                        : Colors.white,
                                    foregroundColor: widget.currentSelected ==
                                            DrawerItems.contact
                                        ? AppTheme.of(context)
                                            .primaryColor
                                        : AppTheme.of(context)
                                            .secondaryColor,
                                    textStyle: AppTheme.of(context)
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
                                      DrawerItems.contact ||
                                      !checkConnection()) {
                                    return;
                                  }
                                  context.pushRoute(
                                    ContactUsWidget(
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
                            AppTheme.of(context).secondaryColor,
                        fixedSize: const Size(330, 36),
                        backgroundColor:
                            AppTheme.of(context).primaryBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () async {
                        if (!checkConnection()) {
                          Navigator.pop(context);
                          return;
                        }
                        logout = await LogoutCall.call(
                          token: UserStoredPreferences.authToken,
                        );
                        setState(() {
                          UserStoredPreferences.authToken = '';
                          UserStoredPreferences.userAccount = '';
                          UserStoredPreferences.userPassword = '';
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
