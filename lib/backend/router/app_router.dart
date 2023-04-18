import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../utils/stored_preferences.dart';
import '../api_requests/api_calls.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: WelcomePageWidget.page, path: '/Welcome/'),
    AutoRoute(page: ContactUsWidget.page, path: '/Contact_Us/'),
    AutoRoute(page: CreateAccountWidget.page, path: '/Create_Account/'),
    AutoRoute(page: LoginPageWidget.page, path: '/Login/'),
    AutoRoute(page: CoursesPageWidget.page,  path: '/Courses/'),
    AutoRoute(page: AssignmentsPageWidget.page, path: '/Course/:course'), //This is assignments_page, it is just the course
    AutoRoute(page: AssignmentDetailsWidget.page, path: '/Assignment/:summary'),
    AutoRoute(page: UpdateProfilePageWidget.page, path: '/Profile/'),
    AutoRoute(page: ResetPasswordPageWidget.page, path: '/Password/'),
    AutoRoute(page: NotificationsPageWidget.page, path: '/Notifications/'),
    AutoRoute(page: QuestionCTNWidget.page, path: '/Question/:name/:view'),
  ];
}
class RouteHandler {
  void navigateTo(BuildContext context, String route, String args){
    //print("Route: $route, Args: $args");
    if (route.isNotEmpty) {
      try {
        if (args.isNotEmpty) {
          route = '$route/$args';
        }
        context.navigateNamedTo(route);
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
  Future<String> getSummary(String id) async
  {
    dynamic assignmentSummary = await GetAssignmentSummaryCall.call(
        token: StoredPreferences.authToken,
        assignmentNum: int.parse(id));
    return jsonEncode(assignmentSummary.jsonBody['assignment']);
  }
  Future<String> getCourse(String course) async
  {
    dynamic courseCall =  await GetCourse.call(
        token: StoredPreferences.authToken,
        course: int.parse(course));
    //print('Course Body: ${courseCall.jsonBody['course']}');
    courseCall.jsonBody['course'].remove('textbook_url');
    return jsonEncode(courseCall.jsonBody['course']);
  }
  Future<String> getQuestion(List<String> args) async
  {
    dynamic courseCall =  await ViewCall.call(
        token: StoredPreferences.authToken,
        assignmentID: int.parse(args[1]));
    courseCall.jsonBody['course'].remove('textbook_url');
    return jsonEncode(courseCall.jsonBody['course']);
  }
  Future<String> getArgs(String path, List<String> args) async{
    switch(path){
      case '/Assignment':
        return getSummary(args[0]);
      case '/Course':
        return getCourse(args[0]);
      case '/Question':
        return getQuestion(args);
      default:
        return '';
    }
  }
}