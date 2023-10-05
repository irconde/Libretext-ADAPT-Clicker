// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:adapt_clicker/screens/assignment_screen/assignment_screen.dart'
    as _i1;
import 'package:adapt_clicker/screens/contact_us_screen.dart' as _i2;
import 'package:adapt_clicker/screens/course_details_screen/course_details_screen.dart'
    as _i3;
import 'package:adapt_clicker/screens/course_list_screen/course_list_screen.dart'
    as _i4;
import 'package:adapt_clicker/screens/create_account_screen.dart' as _i5;
import 'package:adapt_clicker/screens/home_screen.dart' as _i6;
import 'package:adapt_clicker/screens/login_screen.dart' as _i7;
import 'package:adapt_clicker/screens/notifications_screen/notifications_screen.dart'
    as _i8;
import 'package:adapt_clicker/screens/question_screen.dart' as _i9;
import 'package:adapt_clicker/screens/reset_password_screen.dart' as _i10;
import 'package:adapt_clicker/screens/update_profile_screen.dart' as _i11;
import 'package:adapt_clicker/widgets/bottom_sheets/poll_widget.dart' as _i12;
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/foundation.dart' as _i15;
import 'package:flutter/material.dart' as _i14;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    AssignmentScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AssignmentScreenArgs>(
          orElse: () =>
              AssignmentScreenArgs(assignmentSum: pathParams.get('summary')));
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AssignmentScreen(
          key: args.key,
          assignmentSum: args.assignmentSum,
        ),
      );
    },
    ContactUsScreen.name: (routeData) {
      final args = routeData.argsAs<ContactUsScreenArgs>(
          orElse: () => const ContactUsScreenArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.ContactUsScreen(
          key: args.key,
          openFromDrawer: args.openFromDrawer,
        ),
      );
    },
    CourseDetailsScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CourseDetailsScreenArgs>(
          orElse: () =>
              CourseDetailsScreenArgs(id: pathParams.getString('course')));
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CourseDetailsScreen(
          key: args.key,
          id: args.id,
        ),
      );
    },
    CourseListScreen.name: (routeData) {
      final args = routeData.argsAs<CourseListScreenArgs>(
          orElse: () => const CourseListScreenArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.CourseListScreen(
          key: args.key,
          isFirstScreen: args.isFirstScreen,
        ),
      );
    },
    CreateAccountScreen.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CreateAccountScreen(),
      );
    },
    HomeScreen.name: (routeData) {
      final args = routeData.argsAs<HomeScreenArgs>(
          orElse: () => const HomeScreenArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.HomeScreen(
          key: args.key,
          isFirstScreen: args.isFirstScreen,
        ),
      );
    },
    LoginScreenWidget.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LoginScreenWidget(),
      );
    },
    NotificationsScreen.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.NotificationsScreen(),
      );
    },
    QuestionScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<QuestionScreenArgs>(
          orElse: () => QuestionScreenArgs(
                assignmentName: pathParams.optString('name'),
                index: queryParams.getInt(
                  'index',
                  0,
                ),
              ));
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.QuestionScreen(
          key: args.key,
          assignmentName: args.assignmentName,
          view: args.view,
          index: args.index,
        ),
      );
    },
    ResetPasswordScreen.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ResetPasswordScreen(),
      );
    },
    UpdateProfileScreen.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.UpdateProfileScreen(),
      );
    },
    PollWidget.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PollWidgetArgs>(
          orElse: () => PollWidgetArgs(
                assignmentName: pathParams.optString('name'),
                poll: pathParams.get('poll'),
              ));
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.PollWidget(
          key: args.key,
          assignmentName: args.assignmentName,
          poll: args.poll,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AssignmentScreen]
class AssignmentScreen extends _i13.PageRouteInfo<AssignmentScreenArgs> {
  AssignmentScreen({
    _i14.Key? key,
    required dynamic assignmentSum,
    List<_i13.PageRouteInfo>? children,
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

  static const _i13.PageInfo<AssignmentScreenArgs> page =
      _i13.PageInfo<AssignmentScreenArgs>(name);
}

class AssignmentScreenArgs {
  const AssignmentScreenArgs({
    this.key,
    required this.assignmentSum,
  });

  final _i14.Key? key;

  final dynamic assignmentSum;

  @override
  String toString() {
    return 'AssignmentScreenArgs{key: $key, assignmentSum: $assignmentSum}';
  }
}

/// generated route for
/// [_i2.ContactUsScreen]
class ContactUsScreen extends _i13.PageRouteInfo<ContactUsScreenArgs> {
  ContactUsScreen({
    _i14.Key? key,
    bool? openFromDrawer = false,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          ContactUsScreen.name,
          args: ContactUsScreenArgs(
            key: key,
            openFromDrawer: openFromDrawer,
          ),
          initialChildren: children,
        );

  static const String name = 'ContactUsScreen';

  static const _i13.PageInfo<ContactUsScreenArgs> page =
      _i13.PageInfo<ContactUsScreenArgs>(name);
}

class ContactUsScreenArgs {
  const ContactUsScreenArgs({
    this.key,
    this.openFromDrawer = false,
  });

  final _i14.Key? key;

  final bool? openFromDrawer;

  @override
  String toString() {
    return 'ContactUsScreenArgs{key: $key, openFromDrawer: $openFromDrawer}';
  }
}

/// generated route for
/// [_i3.CourseDetailsScreen]
class CourseDetailsScreen extends _i13.PageRouteInfo<CourseDetailsScreenArgs> {
  CourseDetailsScreen({
    _i14.Key? key,
    required String id,
    List<_i13.PageRouteInfo>? children,
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

  static const _i13.PageInfo<CourseDetailsScreenArgs> page =
      _i13.PageInfo<CourseDetailsScreenArgs>(name);
}

class CourseDetailsScreenArgs {
  const CourseDetailsScreenArgs({
    this.key,
    required this.id,
  });

  final _i14.Key? key;

  final String id;

  @override
  String toString() {
    return 'CourseDetailsScreenArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i4.CourseListScreen]
class CourseListScreen extends _i13.PageRouteInfo<CourseListScreenArgs> {
  CourseListScreen({
    _i15.Key? key,
    bool? isFirstScreen = false,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          CourseListScreen.name,
          args: CourseListScreenArgs(
            key: key,
            isFirstScreen: isFirstScreen,
          ),
          initialChildren: children,
        );

  static const String name = 'CourseListScreen';

  static const _i13.PageInfo<CourseListScreenArgs> page =
      _i13.PageInfo<CourseListScreenArgs>(name);
}

class CourseListScreenArgs {
  const CourseListScreenArgs({
    this.key,
    this.isFirstScreen = false,
  });

  final _i15.Key? key;

  final bool? isFirstScreen;

  @override
  String toString() {
    return 'CourseListScreenArgs{key: $key, isFirstScreen: $isFirstScreen}';
  }
}

/// generated route for
/// [_i5.CreateAccountScreen]
class CreateAccountScreen extends _i13.PageRouteInfo<void> {
  const CreateAccountScreen({List<_i13.PageRouteInfo>? children})
      : super(
          CreateAccountScreen.name,
          initialChildren: children,
        );

  static const String name = 'CreateAccountScreen';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomeScreen]
class HomeScreen extends _i13.PageRouteInfo<HomeScreenArgs> {
  HomeScreen({
    _i14.Key? key,
    bool? isFirstScreen = false,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          HomeScreen.name,
          args: HomeScreenArgs(
            key: key,
            isFirstScreen: isFirstScreen,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeScreen';

  static const _i13.PageInfo<HomeScreenArgs> page =
      _i13.PageInfo<HomeScreenArgs>(name);
}

class HomeScreenArgs {
  const HomeScreenArgs({
    this.key,
    this.isFirstScreen = false,
  });

  final _i14.Key? key;

  final bool? isFirstScreen;

  @override
  String toString() {
    return 'HomeScreenArgs{key: $key, isFirstScreen: $isFirstScreen}';
  }
}

/// generated route for
/// [_i7.LoginScreenWidget]
class LoginScreenWidget extends _i13.PageRouteInfo<void> {
  const LoginScreenWidget({List<_i13.PageRouteInfo>? children})
      : super(
          LoginScreenWidget.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenWidget';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i8.NotificationsScreen]
class NotificationsScreen extends _i13.PageRouteInfo<void> {
  const NotificationsScreen({List<_i13.PageRouteInfo>? children})
      : super(
          NotificationsScreen.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsScreen';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.QuestionScreen]
class QuestionScreen extends _i13.PageRouteInfo<QuestionScreenArgs> {
  QuestionScreen({
    _i15.Key? key,
    String? assignmentName,
    dynamic view,
    int index = 0,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          QuestionScreen.name,
          args: QuestionScreenArgs(
            key: key,
            assignmentName: assignmentName,
            view: view,
            index: index,
          ),
          rawPathParams: {'name': assignmentName},
          rawQueryParams: {'index': index},
          initialChildren: children,
        );

  static const String name = 'QuestionScreen';

  static const _i13.PageInfo<QuestionScreenArgs> page =
      _i13.PageInfo<QuestionScreenArgs>(name);
}

class QuestionScreenArgs {
  const QuestionScreenArgs({
    this.key,
    this.assignmentName,
    this.view,
    this.index = 0,
  });

  final _i15.Key? key;

  final String? assignmentName;

  final dynamic view;

  final int index;

  @override
  String toString() {
    return 'QuestionScreenArgs{key: $key, assignmentName: $assignmentName, view: $view, index: $index}';
  }
}

/// generated route for
/// [_i10.ResetPasswordScreen]
class ResetPasswordScreen extends _i13.PageRouteInfo<void> {
  const ResetPasswordScreen({List<_i13.PageRouteInfo>? children})
      : super(
          ResetPasswordScreen.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordScreen';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.UpdateProfileScreen]
class UpdateProfileScreen extends _i13.PageRouteInfo<void> {
  const UpdateProfileScreen({List<_i13.PageRouteInfo>? children})
      : super(
          UpdateProfileScreen.name,
          initialChildren: children,
        );

  static const String name = 'UpdateProfileScreen';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i12.PollWidget]
class PollWidget extends _i13.PageRouteInfo<PollWidgetArgs> {
  PollWidget({
    _i15.Key? key,
    String? assignmentName,
    dynamic poll,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          PollWidget.name,
          args: PollWidgetArgs(
            key: key,
            assignmentName: assignmentName,
            poll: poll,
          ),
          rawPathParams: {
            'name': assignmentName,
            'poll': poll,
          },
          initialChildren: children,
        );

  static const String name = 'PollWidget';

  static const _i13.PageInfo<PollWidgetArgs> page =
      _i13.PageInfo<PollWidgetArgs>(name);
}

class PollWidgetArgs {
  const PollWidgetArgs({
    this.key,
    this.assignmentName,
    this.poll,
  });

  final _i15.Key? key;

  final String? assignmentName;

  final dynamic poll;

  @override
  String toString() {
    return 'PollWidgetArgs{key: $key, assignmentName: $assignmentName, poll: $poll}';
  }
}
