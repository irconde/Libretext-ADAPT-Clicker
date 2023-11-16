import 'package:adapt_clicker/constants/icons.dart';
import 'package:adapt_clicker/mixins/connection_state_mixin.dart';
import '../backend/router/app_router.gr.dart';
import 'package:adapt_clicker/backend/user_stored_preferences.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../backend/api_requests/api_calls.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/dimens.dart';

/// An enum representing the items in the navigation drawer.
enum DrawerItems {
  courses,
  profile,
  password,
  contact,
}

/// A widget that displays a navigation drawer.
class NavigationDrawerWidget extends ConsumerStatefulWidget {
  /// The currently selected item in the navigation drawer.
  final DrawerItems? currentSelected;

  const NavigationDrawerWidget({Key? key, this.currentSelected})
      : super(key: key);

  @override
  ConsumerState<NavigationDrawerWidget> createState() =>
      _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends ConsumerState<NavigationDrawerWidget>
    with ConnectionStateMixin {
  ApiCallResponse? logout;

  @override
  Widget build(BuildContext context) {
    var theme = AppTheme.of(context);
    return BlockSemantics(
      child: SizedBox(
        width: Dimens.drawerWidth,
        child: Container(
          width: double.infinity,
          height: double.maxFinite,
          decoration: const BoxDecoration(
            color: CColors.primaryBackground,
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
                      height: Dimens.drawerTopImageHeight,
                      decoration: const BoxDecoration(
                        color: CColors.primaryColor,
                      ),
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.all(Dimens.msMargin),
                          child: SvgPicture.asset(
                            'assets/images/libretexts_adapt_logo.svg',
                            fit: BoxFit.scaleDown,
                            color: CColors.primaryBackground,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          Dimens.msMargin, Dimens.msMargin, Dimens.msMargin, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: TextButton.icon(
                                icon: IIcons.drawerCourse(selected: widget.currentSelected ==
                                    DrawerItems.courses),
                                label: const Text(Strings.courses),
                                style: TextButton.styleFrom(
                                    fixedSize: const Size(Dimens.drawerButtonPageWidth, Dimens.drawerButtonPageHeight),
                                    padding: const EdgeInsets.only(left: Dimens.smMargin),
                                    alignment: Alignment.centerLeft,
                                    foregroundColor: widget.currentSelected ==
                                            DrawerItems.courses
                                        ? CColors.primaryColor
                                        : CColors.secondaryColor,
                                    backgroundColor: widget.currentSelected ==
                                            DrawerItems.courses
                                        ? CColors.lightPrimaryColor
                                        : Colors.white,
                                    textStyle: theme
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontWeight: widget.currentSelected ==
                                                  DrawerItems.courses
                                              ? FontWeight.w700
                                              : FontWeight.normal,
                                        )),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  if (widget.currentSelected ==
                                      DrawerItems.courses) return;
                                  context.pushRoute(CourseListScreen());
                                }),
                          ),
                          const Divider(
                            height: Dimens.llMargin,
                            thickness: Dimens.dividerThickness,
                            color: CColors.lineColor,
                          ),
                          TextButton.icon(
                              icon: IIcons.drawerProfile(selected: widget.currentSelected ==
                                  DrawerItems.profile),
                              label: const Text(Strings.myProfile),
                              style: TextButton.styleFrom(
                                  fixedSize: const Size(Dimens.drawerButtonPageWidth, Dimens.drawerButtonPageHeight),
                                  padding: const EdgeInsets.only(left: Dimens.smMargin),
                                  alignment: Alignment.centerLeft,
                                  backgroundColor: widget.currentSelected ==
                                          DrawerItems.profile
                                      ? CColors.lightPrimaryColor
                                      : Colors.white,
                                  foregroundColor: widget.currentSelected ==
                                          DrawerItems.profile
                                      ? CColors.primaryColor
                                      : CColors.secondaryColor,
                                  textStyle: theme
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
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
                                    const UpdateProfileScreen());
                              }),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, Dimens.xsMargin, 0, 0),
                            child: TextButton.icon(
                                icon: IIcons.drawerPassword(selected: widget.currentSelected ==
                                    DrawerItems.password),
                                label: const Text(Strings.myPassword),
                                style: TextButton.styleFrom(
                                    fixedSize: const Size(Dimens.drawerButtonPageWidth, Dimens.drawerButtonPageHeight),
                                    padding: const EdgeInsets.only(left: Dimens.smMargin),
                                    alignment: Alignment.centerLeft,
                                    backgroundColor: widget.currentSelected ==
                                            DrawerItems.password
                                        ? CColors.lightPrimaryColor
                                        : Colors.white,
                                    foregroundColor: widget.currentSelected ==
                                            DrawerItems.password
                                        ? CColors.primaryColor
                                        : CColors.secondaryColor,
                                    textStyle: theme
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Open Sans',
                                          fontWeight: widget.currentSelected ==
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
                                      const ResetPasswordScreen());
                                }),
                          ),
                          const Divider(
                            height: Dimens.llMargin,
                            thickness: 1,
                            color: CColors.lineColor,
                          ),
                          TextButton.icon(
                              icon: IIcons.drawerContact(selected: widget.currentSelected ==
                                  DrawerItems.contact),
                              label: const Text(Strings.contactUs),
                              style: TextButton.styleFrom(
                                  fixedSize: const Size(Dimens.drawerButtonPageWidth, Dimens.drawerButtonPageHeight),
                                  padding: const EdgeInsets.only(left: Dimens.smMargin),
                                  alignment: Alignment.centerLeft,
                                  backgroundColor: widget.currentSelected ==
                                          DrawerItems.contact
                                      ? CColors.lightPrimaryColor
                                      : Colors.white,
                                  foregroundColor: widget.currentSelected ==
                                          DrawerItems.contact
                                      ? CColors.primaryColor
                                      : CColors.secondaryColor,
                                  textStyle: theme
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Open Sans',
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
                                  ContactUsScreen(
                                    openFromDrawer: true,
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.msMargin),
                    child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: theme.title3,
                          foregroundColor: CColors.secondaryColor,
                          fixedSize: const Size(Dimens.buttonWidth, Dimens.buttonHeight),
                          backgroundColor: CColors.primaryBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimens.buttonRoundedValue),
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
                            await context.pushRoute(HomeScreen());
                          }
                          setState(() {});
                        },
                        child: const Text(Strings.logoutBtnLabel)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
