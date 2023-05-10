import 'dart:convert';
import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../../utils/stored_preferences.dart';
import '../api_requests/api_calls.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: WelcomeRouteWidget.page),
    AutoRoute(page: ContactUsWidget.page),
    AutoRoute(page: CreateAccountWidget.page),
    AutoRoute(page: LoginRouteWidget.page),
    AutoRoute(page: CoursesRouteWidget.page),
    AutoRoute(page: AssignmentsRouteWidget.page, path: '/Course/:course'),
    AutoRoute(page: AssignmentDetailsWidget.page, path: '/Assignment/:summary'),
    AutoRoute(page: UpdateProfileRouteWidget.page),
    AutoRoute(page: ResetPasswordRouteWidget.page),
    AutoRoute(page: NotificationsRouteWidget.page, path: '/Notifications/'),
    AutoRoute(page: QuestionCTNWidget.page, path: '/Question/:name/:view')
  ];
}

class RouteHandler {
  void navigateTo(BuildContext context, String route, String args) {
    //print("Route: $route, Args: $args");
    if (route.isNotEmpty) {
      try {
        if (args.isNotEmpty) {
          route = '$route/$args';
        }
        context.navigateNamedTo(route);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  Future<String> getSummary(String id) async {
    dynamic assignmentSummary = await GetAssignmentSummaryCall.call(
        token: StoredPreferences.authToken, assignmentNum: int.parse(id));
    return jsonEncode(assignmentSummary.jsonBody['assignment']);
  }


  Future<String> getQuestion(List<String> args) async {
    dynamic courseCall = await ViewCall.call(
        token: StoredPreferences.authToken, assignmentID: int.parse(args[1]));
    courseCall.jsonBody['course'].remove('textbook_url');
    return jsonEncode(courseCall.jsonBody['course']);
  }

  Future<String> getArgs(String path, List<String> args) async {
    switch (path) {
      case '/Assignment':
        return getSummary(args[0]);
      case '/Course':
        return args[0];
      case '/Question':
        return getQuestion(args);
      default:
        return '';
    }
  }
}
