// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:adapt_clicker/assignments_page/assignments_page_widget.dart'
    as _i1;
import 'package:adapt_clicker/components/assignment_details_widget.dart' as _i2;
import 'package:adapt_clicker/components/question_c_t_n_widget.dart' as _i3;
import 'package:adapt_clicker/contact_us/contact_us_widget.dart' as _i4;
import 'package:adapt_clicker/courses_page/courses_page_widget.dart' as _i5;
import 'package:adapt_clicker/create_account/create_account_widget.dart' as _i6;
import 'package:adapt_clicker/login_page/login_page_widget.dart' as _i7;
import 'package:adapt_clicker/notifications_page/notifications_page_widget.dart'
    as _i8;
import 'package:adapt_clicker/reset_password_page/reset_password_page_widget.dart'
    as _i9;
import 'package:adapt_clicker/update_profile_page/update_profile_page_widget.dart'
    as _i10;
import 'package:adapt_clicker/welcome_page/welcome_page_widget.dart' as _i11;
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/foundation.dart' as _i14;
import 'package:flutter/material.dart' as _i13;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    AssignmentsPageWidget.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssignmentsPageWidgetArgs>(
          orElse: () =>
              AssignmentsPageWidgetArgs(course: pathParams.get('course')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AssignmentsPageWidget(
          key: args.key,
          course: args.course,
        ),
      );
    },
    AssignmentDetailsWidget.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssignmentDetailsWidgetArgs>(
          orElse: () => AssignmentDetailsWidgetArgs(
              assignmentSum: pathParams.get('summary')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AssignmentDetailsWidget(
          key: args.key,
          assignmentSum: args.assignmentSum,
        ),
      );
    },
    QuestionCTNWidget.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<QuestionCTNWidgetArgs>(
          orElse: () => QuestionCTNWidgetArgs(
                assignmentName: pathParams.optString('name'),
                view: pathParams.optString('view'),
              ));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.QuestionCTNWidget(
          key: args.key,
          assignmentName: args.assignmentName,
          view: args.view,
        ),
      );
    },
    ContactUsWidget.name: (routeData) {
      final args = routeData.argsAs<ContactUsWidgetArgs>(
          orElse: () => const ContactUsWidgetArgs());
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.ContactUsWidget(
          key: args.key,
          openFromDrawer: args.openFromDrawer,
        ),
      );
    },
    CoursesPageWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CoursesPageWidget(),
      );
    },
    CreateAccountWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CreateAccountWidget(),
      );
    },
    LoginPageWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginPageWidget(),
      );
    },
    NotificationsPageWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.NotificationsPageWidget(),
      );
    },
    ResetPasswordPageWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ResetPasswordPageWidget(),
      );
    },
    UpdateProfilePageWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.UpdateProfilePageWidget(),
      );
    },
    WelcomePageWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.WelcomePageWidget(),
      );
    },
  };
}

/// generated route for
/// [_i1.AssignmentsPageWidget]
class AssignmentsPageWidget
    extends _i12.PageRouteInfo<AssignmentsPageWidgetArgs> {
  AssignmentsPageWidget({
    _i13.Key? key,
    required dynamic course,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          AssignmentsPageWidget.name,
          args: AssignmentsPageWidgetArgs(
            key: key,
            course: course,
          ),
          rawPathParams: {'course': course},
          initialChildren: children,
        );

  static const String name = 'AssignmentsPageWidget';

  static const _i12.PageInfo<AssignmentsPageWidgetArgs> page =
      _i12.PageInfo<AssignmentsPageWidgetArgs>(name);
}

class AssignmentsPageWidgetArgs {
  const AssignmentsPageWidgetArgs({
    this.key,
    required this.course,
  });

  final _i13.Key? key;

  final dynamic course;

  @override
  String toString() {
    return 'AssignmentsPageWidgetArgs{key: $key, course: $course}';
  }
}

/// generated route for
/// [_i2.AssignmentDetailsWidget]
class AssignmentDetailsWidget
    extends _i12.PageRouteInfo<AssignmentDetailsWidgetArgs> {
  AssignmentDetailsWidget({
    _i13.Key? key,
    required dynamic assignmentSum,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          AssignmentDetailsWidget.name,
          args: AssignmentDetailsWidgetArgs(
            key: key,
            assignmentSum: assignmentSum,
          ),
          rawPathParams: {'summary': assignmentSum},
          initialChildren: children,
        );

  static const String name = 'AssignmentDetailsWidget';

  static const _i12.PageInfo<AssignmentDetailsWidgetArgs> page =
      _i12.PageInfo<AssignmentDetailsWidgetArgs>(name);
}

class AssignmentDetailsWidgetArgs {
  const AssignmentDetailsWidgetArgs({
    this.key,
    required this.assignmentSum,
  });

  final _i13.Key? key;

  final dynamic assignmentSum;

  @override
  String toString() {
    return 'AssignmentDetailsWidgetArgs{key: $key, assignmentSum: $assignmentSum}';
  }
}

/// generated route for
/// [_i3.QuestionCTNWidget]
class QuestionCTNWidget extends _i12.PageRouteInfo<QuestionCTNWidgetArgs> {
  QuestionCTNWidget({
    _i14.Key? key,
    String? assignmentName,
    String? view,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          QuestionCTNWidget.name,
          args: QuestionCTNWidgetArgs(
            key: key,
            assignmentName: assignmentName,
            view: view,
          ),
          rawPathParams: {
            'name': assignmentName,
            'view': view,
          },
          initialChildren: children,
        );

  static const String name = 'QuestionCTNWidget';

  static const _i12.PageInfo<QuestionCTNWidgetArgs> page =
      _i12.PageInfo<QuestionCTNWidgetArgs>(name);
}

class QuestionCTNWidgetArgs {
  const QuestionCTNWidgetArgs({
    this.key,
    this.assignmentName,
    this.view,
  });

  final _i14.Key? key;

  final String? assignmentName;

  final String? view;

  @override
  String toString() {
    return 'QuestionCTNWidgetArgs{key: $key, assignmentName: $assignmentName, view: $view}';
  }
}

/// generated route for
/// [_i4.ContactUsWidget]
class ContactUsWidget extends _i12.PageRouteInfo<ContactUsWidgetArgs> {
  ContactUsWidget({
    _i13.Key? key,
    bool? openFromDrawer = false,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ContactUsWidget.name,
          args: ContactUsWidgetArgs(
            key: key,
            openFromDrawer: openFromDrawer,
          ),
          initialChildren: children,
        );

  static const String name = 'ContactUsWidget';

  static const _i12.PageInfo<ContactUsWidgetArgs> page =
      _i12.PageInfo<ContactUsWidgetArgs>(name);
}

class ContactUsWidgetArgs {
  const ContactUsWidgetArgs({
    this.key,
    this.openFromDrawer = false,
  });

  final _i13.Key? key;

  final bool? openFromDrawer;

  @override
  String toString() {
    return 'ContactUsWidgetArgs{key: $key, openFromDrawer: $openFromDrawer}';
  }
}

/// generated route for
/// [_i5.CoursesPageWidget]
class CoursesPageWidget extends _i12.PageRouteInfo<void> {
  const CoursesPageWidget({List<_i12.PageRouteInfo>? children})
      : super(
          CoursesPageWidget.name,
          initialChildren: children,
        );

  static const String name = 'CoursesPageWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CreateAccountWidget]
class CreateAccountWidget extends _i12.PageRouteInfo<void> {
  const CreateAccountWidget({List<_i12.PageRouteInfo>? children})
      : super(
          CreateAccountWidget.name,
          initialChildren: children,
        );

  static const String name = 'CreateAccountWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LoginPageWidget]
class LoginPageWidget extends _i12.PageRouteInfo<void> {
  const LoginPageWidget({List<_i12.PageRouteInfo>? children})
      : super(
          LoginPageWidget.name,
          initialChildren: children,
        );

  static const String name = 'LoginPageWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i8.NotificationsPageWidget]
class NotificationsPageWidget extends _i12.PageRouteInfo<void> {
  const NotificationsPageWidget({List<_i12.PageRouteInfo>? children})
      : super(
          NotificationsPageWidget.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsPageWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ResetPasswordPageWidget]
class ResetPasswordPageWidget extends _i12.PageRouteInfo<void> {
  const ResetPasswordPageWidget({List<_i12.PageRouteInfo>? children})
      : super(
          ResetPasswordPageWidget.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordPageWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.UpdateProfilePageWidget]
class UpdateProfilePageWidget extends _i12.PageRouteInfo<void> {
  const UpdateProfilePageWidget({List<_i12.PageRouteInfo>? children})
      : super(
          UpdateProfilePageWidget.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfilePageWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.WelcomePageWidget]
class WelcomePageWidget extends _i12.PageRouteInfo<void> {
  const WelcomePageWidget({List<_i12.PageRouteInfo>? children})
      : super(
          WelcomePageWidget.name,
          initialChildren: children,
        );

  static const String name = 'WelcomePageWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}
