import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class LoginCall {
  static Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'login',
      apiUrl: 'https://adapt.libretexts.org/api/login',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      params: {
        'email': email,
        'password': password,
      },
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
    return ApiManager.instance.makeApiCall(
      callName: 'createUser',
      apiUrl: 'https://adapt.libretexts.org/api/register',
      callType: ApiCallType.POST,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      params: {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'first_name': firstName,
        'last_name': lastName,
        'registration_type': registrationType,
        'student_id': studentId,
        'time_zone': timeZone,
      },
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class ForgotPasswordCall {
  static Future<ApiCallResponse> call({
    String? email = '',
  }) {
    final body = '''
{
  "email": "${email}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'forgotPassword',
      apiUrl: 'https://adapt.libretexts.org/api/password/email',
      callType: ApiCallType.POST,
      headers: {
        'accept': 'application/json',
      },
      params: {
        'email': email,
      },
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
        'authorization': '${token}',
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
        'authorization': '${token}',
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
        'authorization': '${token}',
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
