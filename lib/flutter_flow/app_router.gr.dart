// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:adapt_clicker/assignments_page/assignments_page_widget.dart'
    as _i9;
import 'package:adapt_clicker/contact_us/contact_us_widget.dart' as _i7;
import 'package:adapt_clicker/courses_page/courses_page_widget.dart' as _i2;
import 'package:adapt_clicker/create_account/create_account_widget.dart' as _i6;
import 'package:adapt_clicker/login_page/login_page_widget.dart' as _i3;
import 'package:adapt_clicker/notifications_page/notifications_page_widget.dart'
    as _i5;
import 'package:adapt_clicker/reset_password_page/reset_password_page_widget.dart'
    as _i8;
import 'package:adapt_clicker/update_profile_page/update_profile_page_widget.dart'
    as _i4;
import 'package:adapt_clicker/welcome_page/welcome_page_widget.dart' as _i1;
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    WelcomeRouteWidget.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i1.WelcomePageWidget(),
      );
    },
    CoursesRouteWidget.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.CoursesPageWidget(),
      );
    },
    LoginRouteWidget.name: (routeData) {
      final args = routeData.argsAs<LoginRouteWidgetArgs>();
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i3.LoginPageWidget(
          key: args.key,
          onSubmit: args.onSubmit,
        ),
      );
    },
    UpdateProfileRouteWidget.name: (routeData) {
      final args = routeData.argsAs<UpdateProfileRouteWidgetArgs>();
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i4.UpdateProfilePageWidget(
          key: args.key,
          onSubmit: args.onSubmit,
        ),
      );
    },
    NotificationsRouteWidget.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.NotificationsPageWidget(),
      );
    },
    CreateAccountWidget.name: (routeData) {
      final args = routeData.argsAs<CreateAccountWidgetArgs>();
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i6.CreateAccountWidget(
          key: args.key,
          onSubmit: args.onSubmit,
        ),
      );
    },
    ContactUsWidget.name: (routeData) {
      final args = routeData.argsAs<ContactUsWidgetArgs>();
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.ContactUsWidget(
          key: args.key,
          onSubmit: args.onSubmit,
          openFromDrawer: args.openFromDrawer,
        ),
      );
    },
    ResetPasswordRouteWidget.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteWidgetArgs>();
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.ResetPasswordPageWidget(
          key: args.key,
          onSubmit: args.onSubmit,
        ),
      );
    },
    AssignmentsRouteWidget.name: (routeData) {
      final args = routeData.argsAs<AssignmentsRouteWidgetArgs>(
          orElse: () => const AssignmentsRouteWidgetArgs());
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i9.AssignmentsPageWidget(
          key: args.key,
          courseNumber: args.courseNumber,
          course: args.course,
        ),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          WelcomeRouteWidget.name,
          path: '/welcome-page-widget',
        ),
        _i10.RouteConfig(
          CoursesRouteWidget.name,
          path: '/courses-page-widget',
        ),
        _i10.RouteConfig(
          LoginRouteWidget.name,
          path: '/login-page-widget',
        ),
        _i10.RouteConfig(
          UpdateProfileRouteWidget.name,
          path: '/update-profile-page-widget',
        ),
        _i10.RouteConfig(
          NotificationsRouteWidget.name,
          path: '/notifications-page-widget',
        ),
        _i10.RouteConfig(
          CreateAccountWidget.name,
          path: '/create-account-widget',
        ),
        _i10.RouteConfig(
          ContactUsWidget.name,
          path: '/contact-us-widget',
        ),
        _i10.RouteConfig(
          ResetPasswordRouteWidget.name,
          path: '/reset-password-page-widget',
        ),
        _i10.RouteConfig(
          AssignmentsRouteWidget.name,
          path: '/assignments-page-widget',
        ),
      ];
}

/// generated route for
/// [_i1.WelcomePageWidget]
class WelcomeRouteWidget extends _i10.PageRouteInfo<void> {
  const WelcomeRouteWidget()
      : super(
          WelcomeRouteWidget.name,
          path: '/welcome-page-widget',
        );

  static const String name = 'WelcomeRouteWidget';
}

/// generated route for
/// [_i2.CoursesPageWidget]
class CoursesRouteWidget extends _i10.PageRouteInfo<void> {
  const CoursesRouteWidget()
      : super(
          CoursesRouteWidget.name,
          path: '/courses-page-widget',
        );

  static const String name = 'CoursesRouteWidget';
}

/// generated route for
/// [_i3.LoginPageWidget]
class LoginRouteWidget extends _i10.PageRouteInfo<LoginRouteWidgetArgs> {
  LoginRouteWidget({
    _i11.Key? key,
    required void Function(String) onSubmit,
  }) : super(
          LoginRouteWidget.name,
          path: '/login-page-widget',
          args: LoginRouteWidgetArgs(
            key: key,
            onSubmit: onSubmit,
          ),
        );

  static const String name = 'LoginRouteWidget';
}

class LoginRouteWidgetArgs {
  const LoginRouteWidgetArgs({
    this.key,
    required this.onSubmit,
  });

  final _i11.Key? key;

  final void Function(String) onSubmit;

  @override
  String toString() {
    return 'LoginRouteWidgetArgs{key: $key, onSubmit: $onSubmit}';
  }
}

/// generated route for
/// [_i4.UpdateProfilePageWidget]
class UpdateProfileRouteWidget
    extends _i10.PageRouteInfo<UpdateProfileRouteWidgetArgs> {
  UpdateProfileRouteWidget({
    _i11.Key? key,
    required void Function(String?) onSubmit,
  }) : super(
          UpdateProfileRouteWidget.name,
          path: '/update-profile-page-widget',
          args: UpdateProfileRouteWidgetArgs(
            key: key,
            onSubmit: onSubmit,
          ),
        );

  static const String name = 'UpdateProfileRouteWidget';
}

class UpdateProfileRouteWidgetArgs {
  const UpdateProfileRouteWidgetArgs({
    this.key,
    required this.onSubmit,
  });

  final _i11.Key? key;

  final void Function(String?) onSubmit;

  @override
  String toString() {
    return 'UpdateProfileRouteWidgetArgs{key: $key, onSubmit: $onSubmit}';
  }
}

/// generated route for
/// [_i5.NotificationsPageWidget]
class NotificationsRouteWidget extends _i10.PageRouteInfo<void> {
  const NotificationsRouteWidget()
      : super(
          NotificationsRouteWidget.name,
          path: '/notifications-page-widget',
        );

  static const String name = 'NotificationsRouteWidget';
}

/// generated route for
/// [_i6.CreateAccountWidget]
class CreateAccountWidget extends _i10.PageRouteInfo<CreateAccountWidgetArgs> {
  CreateAccountWidget({
    _i11.Key? key,
    required void Function(String?) onSubmit,
  }) : super(
          CreateAccountWidget.name,
          path: '/create-account-widget',
          args: CreateAccountWidgetArgs(
            key: key,
            onSubmit: onSubmit,
          ),
        );

  static const String name = 'CreateAccountWidget';
}

class CreateAccountWidgetArgs {
  const CreateAccountWidgetArgs({
    this.key,
    required this.onSubmit,
  });

  final _i11.Key? key;

  final void Function(String?) onSubmit;

  @override
  String toString() {
    return 'CreateAccountWidgetArgs{key: $key, onSubmit: $onSubmit}';
  }
}

/// generated route for
/// [_i7.ContactUsWidget]
class ContactUsWidget extends _i10.PageRouteInfo<ContactUsWidgetArgs> {
  ContactUsWidget({
    _i11.Key? key,
    required void Function(String?) onSubmit,
    bool? openFromDrawer = false,
  }) : super(
          ContactUsWidget.name,
          path: '/contact-us-widget',
          args: ContactUsWidgetArgs(
            key: key,
            onSubmit: onSubmit,
            openFromDrawer: openFromDrawer,
          ),
        );

  static const String name = 'ContactUsWidget';
}

class ContactUsWidgetArgs {
  const ContactUsWidgetArgs({
    this.key,
    required this.onSubmit,
    this.openFromDrawer = false,
  });

  final _i11.Key? key;

  final void Function(String?) onSubmit;

  final bool? openFromDrawer;

  @override
  String toString() {
    return 'ContactUsWidgetArgs{key: $key, onSubmit: $onSubmit, openFromDrawer: $openFromDrawer}';
  }
}

/// generated route for
/// [_i8.ResetPasswordPageWidget]
class ResetPasswordRouteWidget
    extends _i10.PageRouteInfo<ResetPasswordRouteWidgetArgs> {
  ResetPasswordRouteWidget({
    _i11.Key? key,
    required void Function(String) onSubmit,
  }) : super(
          ResetPasswordRouteWidget.name,
          path: '/reset-password-page-widget',
          args: ResetPasswordRouteWidgetArgs(
            key: key,
            onSubmit: onSubmit,
          ),
        );

  static const String name = 'ResetPasswordRouteWidget';
}

class ResetPasswordRouteWidgetArgs {
  const ResetPasswordRouteWidgetArgs({
    this.key,
    required this.onSubmit,
  });

  final _i11.Key? key;

  final void Function(String) onSubmit;

  @override
  String toString() {
    return 'ResetPasswordRouteWidgetArgs{key: $key, onSubmit: $onSubmit}';
  }
}

/// generated route for
/// [_i9.AssignmentsPageWidget]
class AssignmentsRouteWidget
    extends _i10.PageRouteInfo<AssignmentsRouteWidgetArgs> {
  AssignmentsRouteWidget({
    _i11.Key? key,
    int? courseNumber,
    dynamic course,
  }) : super(
          AssignmentsRouteWidget.name,
          path: '/assignments-page-widget',
          args: AssignmentsRouteWidgetArgs(
            key: key,
            courseNumber: courseNumber,
            course: course,
          ),
        );

  static const String name = 'AssignmentsRouteWidget';
}

class AssignmentsRouteWidgetArgs {
  const AssignmentsRouteWidgetArgs({
    this.key,
    this.courseNumber,
    this.course,
  });

  final _i11.Key? key;

  final int? courseNumber;

  final dynamic course;

  @override
  String toString() {
    return 'AssignmentsRouteWidgetArgs{key: $key, courseNumber: $courseNumber, course: $course}';
  }
}
