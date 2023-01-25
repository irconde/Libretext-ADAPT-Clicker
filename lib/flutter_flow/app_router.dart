import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../welcome_page/welcome_page_widget.dart';
import '../courses_page/courses_page_widget.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: WelcomePageWidget, initial: true),
    AutoRoute(page: CoursesPageWidget),
  ],
)
class $AppRouter {}