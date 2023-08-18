import 'dart:convert';
import 'package:adapt_clicker/backend/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../user_stored_preferences.dart';
import '../api_requests/api_calls.dart';

/// AppRouter class that extends the generated router class.
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: HomeScreen.page),
    AutoRoute(page: ContactUsScreen.page),
    AutoRoute(page: CreateAccountScreen.page),
    AutoRoute(page: LoginScreenWidget.page),
    AutoRoute(page: CourseListScreen.page, path: '/courses/', ), //takes in token through query
    AutoRoute(page: CourseDetailsScreen.page, path: '/Course/:course'),
    AutoRoute(page: AssignmentScreen.page, path: '/Assignment/:summary'),
    AutoRoute(page: UpdateProfileScreen.page),
    AutoRoute(page: ResetPasswordScreen.page),
    AutoRoute(page: NotificationsScreen.page, path: '/Notifications/'),
    AutoRoute(page: QuestionScreen.page, path: '/Question/:name/:view')
  ];
}
/// RouteHandler class for handling navigation and data retrieval.
class RouteHandler {
  /// Navigates to a specified route with optional arguments.
  void navigateTo(BuildContext context, String route, String args) {
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

  /// Retrieves the summary of an assignment.
  Future<String> getSummary(String id) async {
    dynamic assignmentSummary = await GetAssignmentSummaryCall.call(
        token: UserStoredPreferences.authToken, assignmentNum: int.parse(id));
    return jsonEncode(assignmentSummary.jsonBody['assignment']);
  }

  /// Retrieves the question for a specific assignment.
  Future<String> getQuestion(List<String> args) async {
    dynamic courseCall = await ViewCall.call(
        token: UserStoredPreferences.authToken,
        assignmentID: int.parse(args[1]));
    courseCall.jsonBody['course'].remove('textbook_url');
    return jsonEncode(courseCall.jsonBody['course']);
  }

  /// Retrieves the arguments based on the provided path and arguments list.
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
