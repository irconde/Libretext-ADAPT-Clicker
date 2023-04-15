import '../../flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';
export 'api_manager.dart' show ApiCallResponse;

class LoginCall {
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
      apiUrl: 'https://adapt.libretexts.org/api/login',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class CreateUserCall {
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
      apiUrl: 'https://adapt.libretexts.org/api/register',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }

  static dynamic errorslist(dynamic response) => getJsonField(
        response,
        r'''$.errors.*..*''',
        true,
      );
}

class ForgotPasswordCall {
  static Future<ApiCallResponse> call({
    String? email = '',
  }) {
    final body = '''
{
  "email": "$email"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'forgotPassword',
      apiUrl: 'https://adapt.libretexts.org/api/password/email',
      callType: ApiCallType.POST,
      headers: {
        'accept': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class RefreshTokenCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'refreshToken',
      apiUrl: 'https://adapt.libretexts.org/api/refresh-token',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class GetUserCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getUser',
      apiUrl: 'https://adapt.libretexts.org/api/user',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }
}

class GetEnrollmentsCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getEnrollments',
      apiUrl: 'https://adapt.libretexts.org/api/enrollments',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }

  static dynamic enrollmentsArray(dynamic response) => getJsonField(
        response,
        r'''$.enrollments''',
      );
}

class UpdateProfileCall {
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
      apiUrl: 'https://adapt.libretexts.org/api/settings/profile',
      callType: ApiCallType.PATCH,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class UpdatePasswordCall {
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
      apiUrl: 'https://adapt.libretexts.org/api/settings/password',
      callType: ApiCallType.PATCH,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class AddCourseCall {
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
      apiUrl: 'https://adapt.libretexts.org/api/enrollments',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class ContactUsCall {
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
      apiUrl: 'https://adapt.libretexts.org/api/email/send',
      callType: ApiCallType.POST,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class GetScoresByUserCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    int? course,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getScoresByUser',
      apiUrl:
          'https://adapt.libretexts.org/api/scores/$course/get-course-scores-by-user',
      callType: ApiCallType.GET,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }

  static dynamic assignments(dynamic response) => getJsonField(
        response,
        r'''$.assignments''',
      );
}

class ViewCall {
  static Future<ApiCallResponse> call({
    int? assignmentID,
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'view',
      apiUrl:
          'https://adapt.libretexts.org/api/assignments/$assignmentID/questions/view',
      callType: ApiCallType.GET,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }

  static dynamic questions(dynamic response) => getJsonField(
        response,
        r'''$.questions''',
      );
}

class GetAssignmentSummaryCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    int? assignmentNum,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getAssignmentSummary',
      apiUrl:
          'https://adapt.libretexts.org/api/assignments/$assignmentNum/summary',
      callType: ApiCallType.GET,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
      },
      params: {},
      returnBody: true,
    );
  }

  static dynamic id(dynamic response) => getJsonField(
        response,
        r'''$.assignment.id''',
      );

  static dynamic name(dynamic response) => getJsonField(
        response,
        r'''$.assignment.name''',
      );

  static dynamic latePolicy(dynamic response) => getJsonField(
        response,
        r'''$.assignment.formatted_late_policy''',
      );

  static dynamic points(dynamic response) => getJsonField(
        response,
        r'''$.assignment.total_points''',
      );

  static dynamic dueDate(dynamic response) => getJsonField(
        response,
        r'''$.assignment.formatted_due''',
      );

  static dynamic assignment(dynamic response) => getJsonField(
        response,
        r'''$.assignment''',
      );
}

class LogoutCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'logout',
      apiUrl: 'https://adapt.libretexts.org/api/logout',
      callType: ApiCallType.POST,
      headers: {
        'accept': 'application/json',
        'authorization': '$token',
        'authority': 'adapt.libretexts.org',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class GetNonTechnologyIframeCall {
  static Future<ApiCallResponse> call({
    int? pageId,
    String? token = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getNonTechnologyIframe',
      apiUrl:
          'https://adapt.libretexts.org/api/get-locally-saved-page-contents/phys/$pageId',
      callType: ApiCallType.GET,
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

class GetTimezonesCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'getTimezones',
      apiUrl: 'https://adapt.libretexts.org/api/time-zones',
      callType: ApiCallType.GET,
      headers: {
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
    );
  }

  static dynamic timezones(dynamic response) => getJsonField(
        response,
        r'''$.time_zones''',
        true,
      );
}

class SendTokenCall {
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
      apiUrl: 'https://adapt.libretexts.org/api/fcm-tokens',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'authorization': '$token',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      cache: false,
    );
  }
}
