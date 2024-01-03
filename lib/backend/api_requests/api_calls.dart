import '../../constants/strings.dart';
import '../../utils/utils.dart';
import 'api_manager.dart';
export 'api_manager.dart' show ApiCallResponse;

/// Class responsible for making an API call to perform a login operation.
class LoginCall {
  /// Makes an API call to perform a login operation.
  ///
  /// The [email] parameter represents the user's email address.
  /// The [password] parameter represents the user's password.
  ///
  /// Returns a [Future] that resolves to an [ApiCallResponse] containing the result of the API call.
  static Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) {
    final body = '''
{
  "email": "$email",
  "password": "$password"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: '${Strings.adaptLink}/api/login',
      callType: ApiCallType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.json,
      returnBody: true,
    );
  }
}

/// A static class for making an API call to create a user.
class CreateUserCall {
  /// Creates a new user by making an API call.
  ///
  /// Returns a [Future] that completes with an [ApiCallResponse].
  ///
  /// Optional parameters:
  /// - [email]: The email of the user.
  /// - [password]: The password of the user.
  /// - [passwordConfirmation]: The confirmation password.
  /// - [firstName]: The first name of the user.
  /// - [lastName]: The last name of the user.
  /// - [registrationType]: The type of registration.
  /// - [studentId]: The student ID of the user.
  /// - [timeZone]: The time zone of the user.
  static Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
    String? passwordConfirmation = '',
    String? firstName = '',
    String? lastName = '',
    String? registrationType = '',
    String? studentId = '',
    String? timeZone = '',
  }) {
    final body = '''
{
  "email": "$email",
  "password": "$password",
  "password_confirmation": "$passwordConfirmation",
  "first_name": "$firstName",
  "last_name": "$lastName",
  "registration_type": "$registrationType",
  "student_id": "$studentId",
  "time_zone": "$timeZone"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createUser',
      apiUrl: '${Strings.adaptLink}/api/register',
      callType: ApiCallType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.json,
      returnBody: true,
    );
  }

  /// Extracts the errors from the API response.
  ///
  /// Takes the [response] as a parameter and returns a dynamic object.
  static dynamic errorslist(dynamic response) => getJsonField(
        response,
        r'''$.errors.*..*''',
        true,
      );
}

/// A static class for making an API call to request a password reset.
class ForgotPasswordCall {
  /// Sends a password reset request by making an API call.
  ///
  /// Returns a [Future] that completes with an [ApiCallResponse].
  ///
  /// Optional parameters:
  /// - [email]: The email of the user requesting a password reset.
  static Future<ApiCallResponse> call({
    String? email = '',
  }) {
    final body = '''
{
  "email": "$email"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'forgotPassword',
      apiUrl: '${Strings.adaptLink}/api/password/email',
      callType: ApiCallType.post,
      headers: {
        'accept': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.json,
      returnBody: true,
    );
  }
}

/// A static class for making an API call to refresh an authentication token.
class RefreshTokenCall {
  /// Sends a request to refresh an authentication token by making an API call.
  ///
  /// Returns a [Future] that completes with an [ApiCallResponse].
  ///
  /// Optional parameters:
  /// - [token]: The current authentication token to be refreshed.
  static Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'refreshToken',
      apiUrl: '${Strings.adaptLink}/api/refresh-token',
      callType: ApiCallType.post,
      headers: {
        'Accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      bodyType: BodyType.json,
      returnBody: true,
    );
  }
}

class SetJWT {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'setJWT',
      apiUrl: 'https://dev.adapt.libretexts.org/api/users/set-cookie-user-jwt',
      callType: ApiCallType.get,
      headers: {
        'Accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }
}

/// A static class for making an API call to retrieve user information.
class GetUserCall {
  /// Sends a request to retrieve user information by making an API call.
  ///
  /// Returns a [Future] that completes with an [ApiCallResponse].
  ///
  /// Optional parameters:
  /// - [token]: The authentication token used for authorization.
  static Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getUser',
      apiUrl: '${Strings.adaptLink}/api/user',
      callType: ApiCallType.get,
      headers: {
        'Accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }
}

/// Makes an API call to retrieve user enrollments.
class GetEnrollmentsCall {
  /// Sends a request to retrieve user enrollments.
  ///
  /// The [token] parameter is the authentication token for the API call.
  static Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getEnrollments',
      apiUrl: '${Strings.adaptLink}/api/enrollments',
      callType: ApiCallType.get,
      headers: {
        'Accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }

  /// Extracts the enrollments array from the API response.
  ///
  /// The [response] parameter is the API response object.
  static dynamic enrollmentsArray(dynamic response) => getJsonField(
        response,
        r'''$.enrollments''',
      );
}

/// Makes an API call to update the user's profile.
class UpdateProfileCall {
  /// Sends a request to update the user's profile.
  ///
  /// The [token] parameter is the authentication token for the API call.
  /// The [firstName], [lastName], [email], [timeZone], and [studentId] parameters
  /// are the updated values for the corresponding profile fields.
  static Future<ApiCallResponse> call({
    String? token = '',
    String? firstName = '',
    String? lastName = '',
    String? email = '',
    String? timeZone = '',
    String? studentId = '',
  }) {
    final body = '''
{
  "first_name": "$firstName",
  "last_name": "$lastName",
  "email": "$email",
  "student_id": "$studentId",
  "time_zone": "$timeZone"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateProfile',
      apiUrl: '${Strings.adaptLink}/api/settings/profile',
      callType: ApiCallType.patch,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      body: body,
      bodyType: BodyType.json,
      returnBody: true,
    );
  }
}

/// Makes an API call to update the user's password.
class UpdatePasswordCall {
  /// Sends a request to update the user's password.
  ///
  /// The [token] parameter is the authentication token for the API call.
  /// The [password] parameter is the new password.
  /// The [passwordConfirmation] parameter is the confirmation of the new password.
  static Future<ApiCallResponse> call({
    String? token = '',
    String? password = '',
    String? passwordConfirmation = '',
  }) {
    final body = '''
{
  "password": "$password",
  "password_confirmation": "$passwordConfirmation"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updatePassword',
      apiUrl: '${Strings.adaptLink}/api/settings/password',
      callType: ApiCallType.patch,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      body: body,
      bodyType: BodyType.json,
      returnBody: true,
    );
  }
}

/// Makes an API call to add a course.
class AddCourseCall {
  /// Sends a request to add a course.
  ///
  /// The [token] parameter is the authentication token for the API call.
  /// The [accessCode] parameter is the access code for the course.
  /// The [studentID] parameter is the student ID.
  /// The [isLms] parameter indicates whether the course is an LMS course.
  /// The [timeZone] parameter is the user's time zone.
  static Future<ApiCallResponse> call({
    String? token = '',
    String? accessCode = '',
    String? studentID = '',
    bool? isLms,
    String? timeZone = '',
  }) {
    final body = '''
{
  "access_code": "$accessCode",
  "student_id": "$studentID",
  "is_lms": "$isLms",
  "time_zone": "$timeZone"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'addCourse',
      apiUrl: '${Strings.adaptLink}/api/enrollments',
      callType: ApiCallType.post,
      headers: {
        'Accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      body: body,
      bodyType: BodyType.json,
      returnBody: true,
    );
  }
}

/// Makes an API call to contact customer support.
class ContactUsCall {
  /// Sends a request to contact customer support.
  ///
  /// The [email] parameter is the email address of the sender.
  /// The [name] parameter is the name of the sender.
  /// The [school] parameter is the school of the sender.
  /// The [subject] parameter is the subject of the inquiry (default: 'General Inquiry').
  /// The [text] parameter is the text of the inquiry.
  /// The [toUserId] parameter is the ID of the user to receive the inquiry (default: 'contact_us').
  /// The [type] parameter is the type of inquiry.
  static Future<ApiCallResponse> call({
    String? email = '',
    String? name = '',
    String? school = '',
    String? subject = 'General Inquiry',
    String? text = '',
    String? toUserId = 'contact_us',
    String? type = '',
  }) {
    final body = '''
{
  "name": "$name",
  "email": "$email",
  "school": "$school",
  "subject": "$subject",
  "text": "$text",
  "to_user_id": "$toUserId",
  "type": "$type"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'contactUs',
      apiUrl: '${Strings.adaptLink}/api/email/send',
      callType: ApiCallType.post,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.json,
      returnBody: true,
    );
  }
}

/// Makes an API call to get scores by user for a specific course.
class GetScoresByUserCall {
  /// Retrieves the scores of a user for a specific course.
  ///
  /// The [token] parameter is the access token for authentication.
  /// The [course] parameter is the ID of the course to retrieve scores from.
  static Future<ApiCallResponse> call({
    String? token = '',
    int? course,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getScoresByUser',
      apiUrl:
          '${Strings.adaptLink}/api/scores/$course/get-course-scores-by-user',
      callType: ApiCallType.get,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }

  /// Extracts the assignments from the API response.
  static dynamic assignments(dynamic response) => getJsonField(
        response,
        r'''$.assignments''',
      );
}

/// Makes an API call to get information about a specific course.
class GetCourse {
  /// Retrieves information about a specific course.
  ///
  /// The [token] parameter is the access token for authentication.
  /// The [course] parameter is the ID of the course to retrieve information for.
  static Future<ApiCallResponse> call({
    String? token = '',
    int? course,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getScoresByUser',
      apiUrl: '${Strings.adaptLink}/api/courses/$course/',
      callType: ApiCallType.get,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }
}

/// Makes an API call to view questions for a specific assignment.
class ViewCall {
  /// Retrieves questions for a specific assignment.
  ///
  /// The [assignmentID] parameter is the ID of the assignment.
  /// The [token] parameter is the access token for authentication.
  static Future<ApiCallResponse> call({
    int? assignmentID,
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'view',
      apiUrl:
          '${Strings.adaptLink}/api/assignments/$assignmentID/questions/view',
      callType: ApiCallType.get,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }

  /// Extracts the questions from the API response.
  ///
  /// The [response] parameter is the API response object.
  static dynamic questions(dynamic response) => getJsonField(
        response,
        r'''$.questions''',
      );
}

class GetQuestionPageCall {
  /// Retrieves the webpage for a question
  ///
  /// The [token] parameter is the access token for authentication.
  /// The [assignmentID] parameter is the number of the assignment.
  /// The [questionID] parameter is the number of the assignment.
  static Future<ApiCallResponse> call({
    String? token = '',
    int? assignmentID,
    int? questionID,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getAssignmentSummary',
      apiUrl:
          '${Strings.adaptLink}/assignments/$assignmentID/questions/view/$questionID',
      callType: ApiCallType.get,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
      html: true,
    );
  }
}

/// Makes an API call to retrieve the summary of an assignment.
class GetAssignmentSummaryCall {
  /// Retrieves the summary of an assignment.
  ///
  /// The [token] parameter is the access token for authentication.
  /// The [assignmentNum] parameter is the number of the assignment.
  static Future<ApiCallResponse> call({
    String? token = '',
    int? assignmentNum,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getAssignmentSummary',
      apiUrl:
          '${Strings.adaptLink}/api/assignments/$assignmentNum/summary',
      callType: ApiCallType.get,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }

  /// Extracts the assignment ID from the API response.
  ///
  /// The [response] parameter is the API response object.
  static dynamic id(dynamic response) => getJsonField(
        response,
        r'''$.assignment.id''',
      );

  /// Extracts the assignment name from the API response.
  ///
  /// The [response] parameter is the API response object.
  static dynamic name(dynamic response) => getJsonField(
        response,
        r'''$.assignment.name''',
      );

  /// Extracts the late policy of the assignment from the API response.
  ///
  /// The [response] parameter is the API response object.
  static dynamic latePolicy(dynamic response) => getJsonField(
        response,
        r'''$.assignment.formatted_late_policy''',
      );

  /// Extracts the total points of the assignment from the API response.
  ///
  /// The [response] parameter is the API response object.
  static dynamic points(dynamic response) => getJsonField(
        response,
        r'''$.assignment.total_points''',
      );

  /// Extracts the due date of the assignment from the API response.
  ///
  /// The [response] parameter is the API response object.
  static dynamic dueDate(dynamic response) => getJsonField(
        response,
        r'''$.assignment.formatted_due''',
      );

  /// Extracts the assignment object from the API response.
  ///
  /// The [response] parameter is the API response object.
  static dynamic assignment(dynamic response) => getJsonField(
        response,
        r'''$.assignment''',
      );
}

/// Makes an API call to log out the user.
class LogoutCall {
  /// Logs out the user.
  ///
  /// The [token] parameter is the access token for authentication.
  static Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'logout',
      apiUrl: '${Strings.adaptLink}/api/logout',
      callType: ApiCallType.post,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
        'authority': 'adapt.libretexts.org',
      },
      params: {},
      bodyType: BodyType.json,
      returnBody: true,
    );
  }
}

/// Makes an API call to retrieve non-technology iframe content.
class GetNonTechnologyIframeCall {
  /// Retrieves non-technology iframe content.
  ///
  /// The [pageId] parameter is the ID of the page to retrieve the content for.
  /// The [token] parameter is the access token for authentication.
  static Future<ApiCallResponse> call({
    int? pageId,
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getNonTechnologyIframe',
      apiUrl:
          '${Strings.adaptLink}/api/get-locally-saved-page-contents/phys/$pageId',
      callType: ApiCallType.get,
      html: true,
      headers: {
        'accept': 'text/html',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }
}

/// Makes an API call to retrieve the available timezones.
class GetTimezonesCall {
  /// Retrieves the available timezones.
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'getTimezones',
      apiUrl: '${Strings.adaptLink}/api/time-zones',
      callType: ApiCallType.get,
      headers: {
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
    );
  }

  /// Extracts the timezones from the API response.
  ///
  /// The [response] parameter is the API response to extract the timezones from.
  static dynamic timezones(dynamic response) => getJsonField(
        response,
        r'''$.time_zones''',
        true,
      );
}

/// Makes an API call to send a token to the server.
class SendTokenCall {
  /// Sends a token to the server.
  ///
  /// The [token] parameter is the authorization token.
  /// The [fcmToken] parameter is the Firebase Cloud Messaging token to send.
  static Future<ApiCallResponse> call({
    String? token = '',
    String? fcmToken = '',
  }) {
    final body = '''
{
  "fcm_token": "$fcmToken"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'sendToken',
      apiUrl: '${Strings.adaptLink}/api/fcm-tokens',
      callType: ApiCallType.post,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': '$token',
      },
      params: {},
      body: body,
      bodyType: BodyType.json,
      returnBody: true,
      cache: false,
    );
  }
}
