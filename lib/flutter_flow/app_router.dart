import 'package:auto_route/auto_route.dart';
import '../assignments_page/assignments_page_widget.dart';
import '../contact_us/contact_us_widget.dart';
import '../create_account/create_account_widget.dart';
import '../login_page/login_page_widget.dart';
import '../notifications_page/notifications_page_widget.dart';
import '../reset_password_page/reset_password_page_widget.dart';
import '../update_profile_page/update_profile_page_widget.dart';
import '../welcome_page/welcome_page_widget.dart';
import '../courses_page/courses_page_widget.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: WelcomePageWidget),
    AutoRoute(page: CoursesPageWidget),
    AutoRoute(page: LoginPageWidget),
    AutoRoute(page: UpdateProfilePageWidget),
    AutoRoute(page: NotificationsPageWidget),
    AutoRoute(page: CreateAccountWidget),
    AutoRoute(page: ContactUsWidget),
    AutoRoute(page: ResetPasswordPageWidget),
    AutoRoute(page: AssignmentsPageWidget),
  ],
)
class $AppRouter {}