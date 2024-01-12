// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:adapt_clicker/screens/authentication/create_account_screen.dart'
    as _i1;
import 'package:adapt_clicker/screens/authentication/home_screen.dart' as _i2;
import 'package:adapt_clicker/screens/authentication/login_screen.dart' as _i3;
import 'package:adapt_clicker/screens/content/assignment_screen/assignment_screen.dart'
    as _i4;
import 'package:adapt_clicker/screens/content/course_details_screen/course_details_screen.dart'
    as _i5;
import 'package:adapt_clicker/screens/content/question_screen.dart' as _i6;
import 'package:adapt_clicker/screens/main/contact_us_screen.dart' as _i7;
import 'package:adapt_clicker/screens/main/course_list_screen/course_list_screen.dart'
    as _i8;
import 'package:adapt_clicker/screens/main/notifications_screen/notifications_screen.dart'
    as _i9;
import 'package:adapt_clicker/screens/main/reset_password_screen.dart' as _i10;
import 'package:adapt_clicker/screens/main/update_profile_screen.dart' as _i11;
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/foundation.dart' as _i14;
import 'package:flutter/material.dart' as _i13;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    CreateAccountScreen.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CreateAccountScreen(),
      );
    },
    HomeScreen.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeScreen(),
      );
    },
    LoginScreenWidget.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreenWidget(),
      );
    },
    AssignmentScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssignmentScreenArgs>(
          orElse: () =>
              AssignmentScreenArgs(assignmentSum: pathParams.get('summary')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.AssignmentScreen(
          key: args.key,
          assignmentSum: args.assignmentSum,
        ),
      );
    },
    CourseDetailsScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CourseDetailsScreenArgs>(
          orElse: () =>
              CourseDetailsScreenArgs(id: pathParams.getString('course')));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.CourseDetailsScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    QuestionScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<QuestionScreenArgs>(
          orElse: () => QuestionScreenArgs(
                assignmentName: pathParams.optString('name'),
                index: pathParams.getInt(
                  'index',
                  0,
                ),
              ));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.QuestionScreen(
          key: args.key,
          assignmentName: args.assignmentName,
          view: args.view,
          index: args.index,
          isIndex: args.isIndex,
        ),
      );
    },
    ContactUsScreen.name: (routeData) {
      final args = routeData.argsAs<ContactUsScreenArgs>(
          orElse: () => const ContactUsScreenArgs());
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.ContactUsScreen(
          key: args.key,
          openFromDrawer: args.openFromDrawer,
        ),
      );
    },
    CourseListScreen.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<CourseListScreenArgs>(
          orElse: () => CourseListScreenArgs(
                  token: queryParams.get(
                'token',
                '',
              )));
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.CourseListScreen(
          key: args.key,
          token: args.token,
        ),
      );
    },
    NotificationsScreen.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.NotificationsScreen(),
      );
    },
    ResetPasswordScreen.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ResetPasswordScreen(),
      );
    },
    UpdateProfileScreen.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.UpdateProfileScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.CreateAccountScreen]
class CreateAccountScreen extends _i12.PageRouteInfo<void> {
  const CreateAccountScreen({List<_i12.PageRouteInfo>? children})
      : super(
          CreateAccountScreen.name,
          initialChildren: children,
        );

  static const String name = 'CreateAccountScreen';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreen extends _i12.PageRouteInfo<void> {
  const HomeScreen({List<_i12.PageRouteInfo>? children})
      : super(
          HomeScreen.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreen';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginScreenWidget]
class LoginScreenWidget extends _i12.PageRouteInfo<void> {
  const LoginScreenWidget({List<_i12.PageRouteInfo>? children})
      : super(
          LoginScreenWidget.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenWidget';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AssignmentScreen]
class AssignmentScreen extends _i12.PageRouteInfo<AssignmentScreenArgs> {
  AssignmentScreen({
    _i13.Key? key,
    required dynamic assignmentSum,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          AssignmentScreen.name,
          args: AssignmentScreenArgs(
            key: key,
            assignmentSum: assignmentSum,
          ),
          rawPathParams: {'summary': assignmentSum},
          initialChildren: children,
        );

  static const String name = 'AssignmentScreen';

  static const _i12.PageInfo<AssignmentScreenArgs> page =
      _i12.PageInfo<AssignmentScreenArgs>(name);
}

class AssignmentScreenArgs {
  const AssignmentScreenArgs({
    this.key,
    required this.assignmentSum,
  });

  final _i13.Key? key;

  final dynamic assignmentSum;

  @override
  String toString() {
    return 'AssignmentScreenArgs{key: $key, assignmentSum: $assignmentSum}';
  }
}

/// generated route for
/// [_i5.CourseDetailsScreen]
class CourseDetailsScreen extends _i12.PageRouteInfo<CourseDetailsScreenArgs> {
  CourseDetailsScreen({
    _i13.Key? key,
    required String id,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          CourseDetailsScreen.name,
          args: CourseDetailsScreenArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'course': id},
          initialChildren: children,
        );

  static const String name = 'CourseDetailsScreen';

  static const _i12.PageInfo<CourseDetailsScreenArgs> page =
      _i12.PageInfo<CourseDetailsScreenArgs>(name);
}

class CourseDetailsScreenArgs {
  const CourseDetailsScreenArgs({
    this.key,
    required this.id,
  });

  final _i13.Key? key;

  final String id;

  @override
  String toString() {
    return 'CourseDetailsScreenArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i6.QuestionScreen]
class QuestionScreen extends _i12.PageRouteInfo<QuestionScreenArgs> {
  QuestionScreen({
    _i14.Key? key,
    String? assignmentName,
    dynamic view,
    int index = 0,
    bool isIndex = false,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          QuestionScreen.name,
          args: QuestionScreenArgs(
            key: key,
            assignmentName: assignmentName,
            view: view,
            index: index,
            isIndex: isIndex,
          ),
          rawPathParams: {
            'name': assignmentName,
            'index': index,
          },
          initialChildren: children,
        );

  static const String name = 'QuestionScreen';

  static const _i12.PageInfo<QuestionScreenArgs> page =
      _i12.PageInfo<QuestionScreenArgs>(name);
}

class QuestionScreenArgs {
  const QuestionScreenArgs({
    this.key,
    this.assignmentName,
    this.view,
    this.index = 0,
    this.isIndex = false,
  });

  final _i14.Key? key;

  final String? assignmentName;

  final dynamic view;

  final int index;

  final bool isIndex;

  @override
  String toString() {
    return 'QuestionScreenArgs{key: $key, assignmentName: $assignmentName, view: $view, index: $index, isIndex: $isIndex}';
  }
}

/// generated route for
/// [_i7.ContactUsScreen]
class ContactUsScreen extends _i12.PageRouteInfo<ContactUsScreenArgs> {
  ContactUsScreen({
    _i13.Key? key,
    bool? openFromDrawer = false,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          ContactUsScreen.name,
          args: ContactUsScreenArgs(
            key: key,
            openFromDrawer: openFromDrawer,
          ),
          initialChildren: children,
        );

  static const String name = 'ContactUsScreen';

  static const _i12.PageInfo<ContactUsScreenArgs> page =
      _i12.PageInfo<ContactUsScreenArgs>(name);
}

class ContactUsScreenArgs {
  const ContactUsScreenArgs({
    this.key,
    this.openFromDrawer = false,
  });

  final _i13.Key? key;

  final bool? openFromDrawer;

  @override
  String toString() {
    return 'ContactUsScreenArgs{key: $key, openFromDrawer: $openFromDrawer}';
  }
}

/// generated route for
/// [_i8.CourseListScreen]
class CourseListScreen extends _i12.PageRouteInfo<CourseListScreenArgs> {
  CourseListScreen({
    _i14.Key? key,
    dynamic token = '',
    List<_i12.PageRouteInfo>? children,
  }) : super(
          CourseListScreen.name,
          args: CourseListScreenArgs(
            key: key,
            token: token,
          ),
          rawQueryParams: {'token': token},
          initialChildren: children,
        );

  static const String name = 'CourseListScreen';

  static const _i12.PageInfo<CourseListScreenArgs> page =
      _i12.PageInfo<CourseListScreenArgs>(name);
}

class CourseListScreenArgs {
  const CourseListScreenArgs({
    this.key,
    this.token = '',
  });

  final _i14.Key? key;

  final dynamic token;

  @override
  String toString() {
    return 'CourseListScreenArgs{key: $key, token: $token}';
  }
}

/// generated route for
/// [_i9.NotificationsScreen]
class NotificationsScreen extends _i12.PageRouteInfo<void> {
  const NotificationsScreen({List<_i12.PageRouteInfo>? children})
      : super(
          NotificationsScreen.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsScreen';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ResetPasswordScreen]
class ResetPasswordScreen extends _i12.PageRouteInfo<void> {
  const ResetPasswordScreen({List<_i12.PageRouteInfo>? children})
      : super(
          ResetPasswordScreen.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordScreen';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.UpdateProfileScreen]
class UpdateProfileScreen extends _i12.PageRouteInfo<void> {
  const UpdateProfileScreen({List<_i12.PageRouteInfo>? children})
      : super(
          UpdateProfileScreen.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfileScreen';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}
