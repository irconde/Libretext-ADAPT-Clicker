// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;
import 'package:equatable/equatable.dart';

/// Enumeration of API call types.
enum ApiCallType {
  get,
  post,
  delete,
  put,
  patch,
}

/// Enumeration of body types for API requests.
enum BodyType {
  none,
  json,
  text,
  xwwwFormURLEncoded,
}

/// Represents a record of an API call.
///
/// An [ApiCallRecord] contains information about the API call, including the call name,
/// API URL, headers, parameters, request body, and body type.
class ApiCallRecord extends Equatable {
  /// Creates an [ApiCallRecord] with the provided parameters.
  const ApiCallRecord(
    this.callName,
    this.apiUrl,
    this.headers,
    this.params,
    this.body,
    this.bodyType,
  );

  /// The name of the API call.
  final String callName;

  /// The URL of the API endpoint.
  final String apiUrl;

  /// The headers for the API call.
  final Map<String, dynamic> headers;

  /// The parameters for the API call.
  final Map<String, dynamic> params;

  /// The body of the API request.
  final String? body;

  /// The type of the request body.
  final BodyType? bodyType;

  @override
  List<Object?> get props =>
      [callName, apiUrl, headers, params, body, bodyType];
}

/// Represents the response of an API call.
class ApiCallResponse {
  /// Creates an [ApiCallResponse] with the provided parameters.
  const ApiCallResponse(
    this.jsonBody,
    this.headers,
    this.elements,
    this.statusCode,
  );

  /// The JSON body of the response.
  final dynamic jsonBody;

  /// The HTML elements of the response.
  final dom.Document elements;

  /// The headers of the response.
  final Map<String, String> headers;

  /// The status code of the response.
  final int statusCode;

  /// Whether the API call succeeded (status code 2xx).
  bool get succeeded => statusCode >= 200 && statusCode < 300;

  /// Returns the value of the specified header.
  ///
  /// Returns an empty string if the header is not found.
  String getHeader(String headerName) => headers[headerName] ?? '';

  /// Creates an [ApiCallResponse] from an HTTP response.
  ///
  /// The [response] parameter is the HTTP response received from the API call.
  /// The [returnBody] parameter indicates whether to parse the response body.
  /// The [html] parameter indicates whether the response is HTML.
  static ApiCallResponse fromHttpResponse(
    http.Response response,
    bool returnBody,
    bool html,
  ) {
    dynamic jsonBody;
    var document = dom.Document();
    try {
      if (!html) {
        jsonBody = returnBody ? json.decode(response.body) : null;
      } else {
        document = returnBody ? parse(response.body) : dom.Document();
      }
    } catch (_) {}
    return ApiCallResponse(
      jsonBody,
      response.headers,
      document,
      response.statusCode,
    );
  }

  /// Creates an [ApiCallResponse] from a cloud call response.
  ///
  /// The [response] parameter is the cloud call response received from the API call.
  /// The [html] parameter indicates whether the response is HTML.
  static ApiCallResponse fromCloudCallResponse(
    Map<String, dynamic> response,
    bool html,
  ) =>
      ApiCallResponse(
        response['body'],
        ApiManager.toStringMap(response['headers'] ?? {}),
        dom.Document(),
        response['statusCode'] ?? 400,
      );
}

/// The API manager responsible for making API calls.
class ApiManager {
  ApiManager._();

  /// Cache that will ensure identical calls are not repeatedly made.
  static final Map<ApiCallRecord, ApiCallResponse> _apiCache = {};
  static ApiManager? _instance;
  static ApiManager get instance => _instance ??= ApiManager._();

  // If your API calls need authentication, populate this field once
  // the user has authenticated. Alter this as needed.
  static String? _accessToken;

  /// Clears the cache for a specific API call.
  static void clearCache(String callName) => _apiCache.keys
      .toSet()
      .forEach((k) => k.callName == callName ? _apiCache.remove(k) : null);

  /// Converts a generic map to a map with string keys and string values.
  static Map<String, String> toStringMap(Map map) =>
      map.map((key, value) => MapEntry(key.toString(), value.toString()));

  /// Converts a map to query parameters.
  static String asQueryParams(Map<String, dynamic> map) =>
      map.entries.map((e) => '${e.key}=${e.value}').join('&');

  /// Makes an API call without a request body.
  static Future<ApiCallResponse> urlRequest(
    ApiCallType callType,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    bool html,
    bool returnBody,
  ) async {
    if (params.isNotEmpty) {
      final lastUriPart = apiUrl.split('/').last;
      final needsParamSpecifier = !lastUriPart.contains('?');
      apiUrl =
          '$apiUrl${needsParamSpecifier ? '?' : ''}${asQueryParams(params)}';
    }
    final makeRequest = callType == ApiCallType.get ? http.get : http.delete;
    final response =
        await makeRequest(Uri.parse(apiUrl), headers: toStringMap(headers));
    return ApiCallResponse.fromHttpResponse(response, returnBody, html);
  }

  /// Makes an API call with a request body.
  static Future<ApiCallResponse> requestWithBody(
    ApiCallType type,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    String? body,
    BodyType? bodyType,
    bool html,
    bool returnBody,
  ) async {
    assert(
      {ApiCallType.post, ApiCallType.put, ApiCallType.patch}.contains(type),
      'Invalid ApiCallType $type for request with body',
    );
    final postBody = createBody(headers, params, body, bodyType);
    final requestFn = {
      ApiCallType.post: http.post,
      ApiCallType.put: http.put,
      ApiCallType.patch: http.patch,
    }[type]!;
    final response = await requestFn(Uri.parse(apiUrl),
        headers: toStringMap(headers), body: postBody);
    return ApiCallResponse.fromHttpResponse(response, returnBody, html);
  }

  /// Creates the request body based on the provided parameters.
  static dynamic createBody(
    Map<String, dynamic> headers,
    Map<String, dynamic>? params,
    String? body,
    BodyType? bodyType,
  ) {
    String? contentType;
    dynamic postBody;
    switch (bodyType) {
      case BodyType.json:
        contentType = 'application/json';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.text:
        contentType = 'text/plain';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.xwwwFormURLEncoded:
        contentType = 'application/x-www-form-urlencoded';
        postBody = toStringMap(params ?? {});
        break;
      case BodyType.none:
      case null:
        break;
    }
    if (contentType != null) {
      headers['Content-Type'] = contentType;
    }
    return postBody;
  }

  /// Makes an API call.
  Future<ApiCallResponse> makeApiCall({
    required String callName,
    required String apiUrl,
    required ApiCallType callType,
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> params = const {},
    String? body,
    BodyType? bodyType,
    bool returnBody = true,
    bool html = false,
    bool cache = false,
  }) async {
    final callRecord =
        ApiCallRecord(callName, apiUrl, headers, params, body, bodyType);
    // Modify for your specific needs if this differs from your API.
    if (_accessToken != null) {
      headers[HttpHeaders.authorizationHeader] = 'Token $_accessToken';
    }
    if (!apiUrl.startsWith('http')) {
      apiUrl = 'https://$apiUrl';
    }

    // If we've already made this exact call before and caching is on,
    // return the cached result.
    if (cache && _apiCache.containsKey(callRecord)) {
      return _apiCache[callRecord]!;
    }
    ApiCallResponse result;
    switch (callType) {
      case ApiCallType.get:
      case ApiCallType.delete:
        result = await urlRequest(
            callType, apiUrl, headers, params, html, returnBody);
        break;
      case ApiCallType.post:
      case ApiCallType.put:
      case ApiCallType.patch:
        result = await requestWithBody(callType, apiUrl, headers, params, body,
            bodyType, html, returnBody);
        break;
    }
    // If caching is on, cache the result (if present).
    if (cache) {
      _apiCache[callRecord] = result;
    }
    return result;
  }
}
