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
import 'package:adapt_clicker/courses_page/courses_page_widget.dart' as _i2;
import 'package:adapt_clicker/welcome_page/welcome_page_widget.dart' as _i1;
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    WelcomeRouteWidget.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i1.WelcomePageWidget(),
      );
    },
    CoursesRouteWidget.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.CoursesPageWidget(),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          WelcomeRouteWidget.name,
          path: '/welcome-page-widget',
        ),
        _i3.RouteConfig(
          CoursesRouteWidget.name,
          path: '/courses-page-widget',
        ),
      ];
}

/// generated route for
/// [_i1.WelcomePageWidget]
class WelcomeRouteWidget extends _i3.PageRouteInfo<void> {
  const WelcomeRouteWidget()
      : super(
          WelcomeRouteWidget.name,
          path: '/welcome-page-widget',
        );

  static const String name = 'WelcomeRouteWidget';
}

/// generated route for
/// [_i2.CoursesPageWidget]
class CoursesRouteWidget extends _i3.PageRouteInfo<void> {
  const CoursesRouteWidget()
      : super(
          CoursesRouteWidget.name,
          path: '/courses-page-widget',
        );

  static const String name = 'CoursesRouteWidget';
}
