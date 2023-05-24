// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:adapt_clicker/screens/course_details_screen/course_details_screen.dart'
    as _i1;
import 'package:adapt_clicker/screens/assignment_screen/assignment_screen.dart' as _i2;
import 'package:adapt_clicker/screens/question_screen.dart' as _i3;
import 'package:adapt_clicker/screens/contact_us_screen.dart' as _i4;
import 'package:adapt_clicker/screens/course_list_screen/course_list_screen.dart' as _i5;
import 'package:adapt_clicker/screens/create_account_screen.dart' as _i6;
import 'package:adapt_clicker/screens/login_screen.dart' as _i7;
import 'package:adapt_clicker/screens/notifications_screen/notifications_screen.dart'
    as _i8;
import 'package:adapt_clicker/screens/reset_password_screen.dart'
    as _i9;
import 'package:adapt_clicker/screens/update_profile_screen.dart'
    as _i10;
import 'package:adapt_clicker/screens/home_screen.dart' as _i11;
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/foundation.dart' as _i14;
import 'package:flutter/material.dart' as _i13;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    AssignmentsRouteWidget.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssignmentsRouteWidgetArgs>(
          orElse: () =>
              AssignmentsRouteWidgetArgs(id: pathParams.getString('course')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CourseDetailsScreen(
          key: args.key,
          id: args.id,
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
        child: _i2.AssignmentScreen(
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
        child: _i3.QuestionScreen(
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
        child: _i4.ContactUsScreen(
          key: args.key,
          openFromDrawer: args.openFromDrawer,
        ),
      );
    },
    CoursesRouteWidget.name: (routeData) {
      final args = routeData.argsAs<CoursesRouteWidgetArgs>(
          orElse: () => const CoursesRouteWidgetArgs());
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.CourseListScreen(
          key: args.key,
          isFirstScreen: args.isFirstScreen,
        ),
      );
    },
    CreateAccountWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CreateAccountScreen(),
      );
    },
    LoginRouteWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginScreenWidget(),
      );
    },
    NotificationsRouteWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.NotificationsScreen(),
      );
    },
    ResetPasswordRouteWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ResetPasswordScreen(),
      );
    },
    UpdateProfileRouteWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.UpdateProfileScreen(),
      );
    },
    WelcomeRouteWidget.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteWidgetArgs>(
          orElse: () => const WelcomeRouteWidgetArgs());
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.HomeScreen(
          key: args.key,
          isFirstScreen: args.isFirstScreen,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.CourseDetailsScreen]
class AssignmentsRouteWidget
    extends _i12.PageRouteInfo<AssignmentsRouteWidgetArgs> {
  AssignmentsRouteWidget({
    _i13.Key? key,
    required String id,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          AssignmentsRouteWidget.name,
          args: AssignmentsRouteWidgetArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'course': id},
          initialChildren: children,
        );

  static const String name = 'AssignmentsRouteWidget';

  static const _i12.PageInfo<AssignmentsRouteWidgetArgs> page =
      _i12.PageInfo<AssignmentsRouteWidgetArgs>(name);
}

class AssignmentsRouteWidgetArgs {
  const AssignmentsRouteWidgetArgs({
    this.key,
    required this.id,
  });

  final _i13.Key? key;

  final String id;

  @override
  String toString() {
    return 'AssignmentsRouteWidgetArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i2.AssignmentScreen]
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
/// [_i3.QuestionScreen]
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
/// [_i4.ContactUsScreen]
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
/// [_i5.CourseListScreen]
class CoursesRouteWidget extends _i12.PageRouteInfo<CoursesRouteWidgetArgs> {
  CoursesRouteWidget({
    _i13.Key? key,
    bool? isFirstScreen = false,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          CoursesRouteWidget.name,
          args: CoursesRouteWidgetArgs(
            key: key,
            isFirstScreen: isFirstScreen,
          ),
          initialChildren: children,
        );

  static const String name = 'CoursesRouteWidget';

  static const _i12.PageInfo<CoursesRouteWidgetArgs> page =
      _i12.PageInfo<CoursesRouteWidgetArgs>(name);
}

class CoursesRouteWidgetArgs {
  const CoursesRouteWidgetArgs({
    this.key,
    this.isFirstScreen = false,
  });

  final _i13.Key? key;

  final bool? isFirstScreen;

  @override
  String toString() {
    return 'CoursesRouteWidgetArgs{key: $key, isFirstScreen: $isFirstScreen}';
  }
}

/// generated route for
/// [_i6.CreateAccountScreen]
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
/// [_i7.LoginScreenWidget]
class LoginRouteWidget extends _i12.PageRouteInfo<void> {
  const LoginRouteWidget({List<_i12.PageRouteInfo>? children})
      : super(
          LoginRouteWidget.name,
          initialChildren: children,
        );

  static const String name = 'LoginRouteWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i8.NotificationsScreen]
class NotificationsRouteWidget extends _i12.PageRouteInfo<void> {
  const NotificationsRouteWidget({List<_i12.PageRouteInfo>? children})
      : super(
          NotificationsRouteWidget.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsRouteWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ResetPasswordScreen]
class ResetPasswordRouteWidget extends _i12.PageRouteInfo<void> {
  const ResetPasswordRouteWidget({List<_i12.PageRouteInfo>? children})
      : super(
          ResetPasswordRouteWidget.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRouteWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.UpdateProfileScreen]
class UpdateProfileRouteWidget extends _i12.PageRouteInfo<void> {
  const UpdateProfileRouteWidget({List<_i12.PageRouteInfo>? children})
      : super(
          UpdateProfileRouteWidget.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfileRouteWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.HomeScreen]
class WelcomeRouteWidget extends _i12.PageRouteInfo<WelcomeRouteWidgetArgs> {
  WelcomeRouteWidget({
    _i13.Key? key,
    bool? isFirstScreen = false,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          WelcomeRouteWidget.name,
          args: WelcomeRouteWidgetArgs(
            key: key,
            isFirstScreen: isFirstScreen,
          ),
          initialChildren: children,
        );

  static const String name = 'WelcomeRouteWidget';

  static const _i12.PageInfo<WelcomeRouteWidgetArgs> page =
      _i12.PageInfo<WelcomeRouteWidgetArgs>(name);
}

class WelcomeRouteWidgetArgs {
  const WelcomeRouteWidgetArgs({
    this.key,
    this.isFirstScreen = false,
  });

  final _i13.Key? key;

  final bool? isFirstScreen;

  @override
  String toString() {
    return 'WelcomeRouteWidgetArgs{key: $key, isFirstScreen: $isFirstScreen}';
  }
}
