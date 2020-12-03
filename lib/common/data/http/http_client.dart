import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drop_here_mobile/app_storage/app_storage_service.dart';
import 'package:drop_here_mobile/common/log.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'http_call_repeater.dart';

class DhHttpClient {
  static final String loggerName = "DhHttpClient";
  static final Log _log = Log(loggerName);
  static final Log _nonReportingLog = Log.nonReporting(loggerName);

  final HttpClient _baseClient = HttpClient();
  final AppStorageService _appStorageService = Get.find<AppStorageService>();
  final String _baseUrl = "https://drop-here.herokuapp.com";

  final Map<String, String> _httpHeaders = {
    HttpHeaders.contentTypeHeader: "application/json;charset=UTF-8"
  };

  String get baseUrl => _baseUrl;

  void _logRequestInfo(String httpMethod, Uri uri, String body) {
    _log.info('$httpMethod $uri');
    _nonReportingLog.info('$httpMethod $uri $body');
  }

  Future<T> post<T>(
      {String path,
      Map<String, String> headers,
      String body,
      T Function(dynamic json) out,
      @required bool canRepeatRequest}) async {
    final uri = Uri.parse(_baseUrl + path);
    _logRequestInfo('POST', uri, body);
    final HttpCallRepeater<T> httpCallRepeater = _createCallRepeater(uri);
    final HttpCaller<T> httpCaller = () => _baseClient
        .postUrl(uri)
        .then((HttpClientRequest request) => _prepareRequestWithBody(request, body, headers))
        .then((HttpClientResponse response) => _onResponseHandler(response, out, httpCallRepeater))
        .catchError((error) =>
            _onErrorResponseHandler(error, httpCallRepeater, canRepeatRequest: canRepeatRequest));
    return httpCallRepeater.call(httpCaller);
  }

  Future<T> get<T>({
    String path,
    Map<String, String> headers,
    bool parseRawToJson = true,
    T Function(dynamic json) out,
    bool canRepeatRequest = true,
  }) async {
    final uri = Uri.parse(_baseUrl + path);
    _log.info('GET $uri');
    final HttpCallRepeater<T> httpCallRepeater = _createCallRepeater(uri);
    final HttpCaller<T> httpCaller = () => _baseClient
        .getUrl(uri)
        .then((HttpClientRequest request) => _prepareRequest(request, headers))
        .then((HttpClientResponse response) =>
            _onResponseHandler(response, out, httpCallRepeater, parseRawToJson: parseRawToJson))
        .catchError((error) =>
            _onErrorResponseHandler(error, httpCallRepeater, canRepeatRequest: canRepeatRequest));
    return httpCallRepeater.call(httpCaller);
  }

  Future<T> put<T>({
    String path,
    Map<String, String> headers,
    String body,
    T Function(dynamic json) out,
    bool canRepeatRequest = false,
  }) async {
    final uri = Uri.parse(_baseUrl + path);
    _logRequestInfo('PUT', uri, body);
    HttpCallRepeater<T> httpCallRepeater = _createCallRepeater(uri);
    HttpCaller<T> httpCaller = () => _baseClient
        .putUrl(uri)
        .then((HttpClientRequest request) => _prepareRequestWithBody(request, body, headers))
        .then((HttpClientResponse response) => _onResponseHandler(response, out, httpCallRepeater))
        .catchError((error) =>
            _onErrorResponseHandler(error, httpCallRepeater, canRepeatRequest: canRepeatRequest));
    return httpCallRepeater.call(httpCaller);
  }

  Future<T> patch<T>({
    String path,
    Map<String, String> headers,
    String body,
    T Function(dynamic json) out,
    bool canRepeatRequest = false,
  }) async {
    final uri = Uri.parse(_baseUrl + path);
    _logRequestInfo('PATCH', uri, body);
    final HttpCallRepeater<T> httpCallRepeater = _createCallRepeater(uri);
    HttpCaller<T> httpCaller = () => _baseClient
        .patchUrl(uri)
        .then((HttpClientRequest request) => _prepareRequestWithBody(request, body, headers))
        .then((HttpClientResponse response) => _onResponseHandler(response, out, httpCallRepeater))
        .catchError((error) =>
            _onErrorResponseHandler(error, httpCallRepeater, canRepeatRequest: canRepeatRequest));
    return httpCallRepeater.call(httpCaller);
  }

  Future<T> delete<T>({
    String path,
    Map<String, String> headers,
    String body,
    T Function(dynamic json) out,
    bool canRepeatRequest = false,
  }) async {
    final uri = Uri.parse(_baseUrl + path);
    _logRequestInfo('DELETE', uri, body);
    final HttpCallRepeater<T> httpCallRepeater = _createCallRepeater(uri);
    HttpCaller<T> httpCaller = () => _baseClient
        .deleteUrl(uri)
        .then((HttpClientRequest request) => _prepareRequestWithBody(request, body, headers))
        .then((HttpClientResponse response) => _onResponseHandler(response, out, httpCallRepeater))
        .catchError((error) =>
            _onErrorResponseHandler(error, httpCallRepeater, canRepeatRequest: canRepeatRequest));
    return httpCallRepeater.call(httpCaller);
  }

  Future<HttpClientResponse> _prepareRequestWithBody(
      HttpClientRequest request, String body, Map<String, String> headers) {
    _prepareBaseRequest(request, headers);
    request.write(body);
    return request.close();
  }

  Future<HttpClientResponse> _prepareRequest(
      HttpClientRequest request, Map<String, String> headers) {
    _prepareBaseRequest(request, headers);
    return request.close();
  }

  void _prepareBaseRequest(HttpClientRequest request, Map<String, String> headers) {
    _addHeaders(request.headers, headers);
    _prepareAuthorization(request);
  }

  void _addHeaders(HttpHeaders httpHeaders, Map<String, String> headersMap) {
    Map<String, String> allHeaders = {
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
    };
    allHeaders.addAll(_httpHeaders);
    if (headersMap != null) {
      allHeaders.addAll(headersMap);
    }
    allHeaders.forEach((key, value) => httpHeaders.add(key, value));
  }

  Future<T> _onResponseHandler<T>(HttpClientResponse response, T Function(dynamic response) out,
      HttpCallRepeater httpCallRepeater,
      {bool parseRawToJson = true}) async {
    checkStatusCode(response, httpCallRepeater);

    if (!parseRawToJson) {
      return out(response);
    }
    var data = await response.transform(utf8.decoder).join();

    /// It uses different logger in order to not show this data in crashlytics
    _nonReportingLog.debug("received data: $data");

    return isNotEmpty(data) ? out(json.decode(data)) : null;
  }

  void checkStatusCode(HttpClientResponse response, HttpCallRepeater httpCallRepeater) {
    if (!_isHttpResponse2xx(response)) {
      throw HttpStatusException(httpCallRepeater.uri, response.statusCode, response,
          message: response.reasonPhrase);
    }
  }

  bool _isHttpResponse2xx(HttpClientResponse response) => response.statusCode ~/ 100 == 2;

  void _onErrorResponseHandler(dynamic error, HttpCallRepeater httpCallRepeater,
      {@required bool canRepeatRequest}) {
    _ErrorHandler.handleError(
      log: _log,
      error: error,
      httpCallRepeater: httpCallRepeater,
      canRepeatRequest: canRepeatRequest,
    );
  }

  HttpCallRepeater<T> _createCallRepeater<T>(Uri uri) {
    return HttpCallRepeater(uri);
  }

  void _prepareAuthorization(HttpClientRequest request) {
    if (_appStorageService.authenticated) {
      request.headers
          .add(HttpHeaders.authorizationHeader, 'Bearer ${_appStorageService.authenticationToken}');
    }
  }
}

class _ErrorHandler {
  static const bool _repeatAfterConnectionClosedError = true;
  static const int _maximumNumberOfRetriesAfterConnectionClosedError = 1;
  static const bool _logHttpStatusException = true;

  static Future<void> handleError({
    @required Log log,
    @required dynamic error,
    @required HttpCallRepeater httpCallRepeater,
    @required bool canRepeatRequest,
  }) async {
    if (canRepeatRequest &&
        _shouldRepeatOnConnectionClosedError(error, httpCallRepeater.numberOfRetries)) {
      log.warn('"Connection closed before full header was received" error thrown '
          '- trying to repeat the request with uri\n ${httpCallRepeater.uri}');
      throw RetryHttpCallException();
    } else if (canRepeatRequest &&
        _shouldLogNotRepeatedConnectionClosedError(error, httpCallRepeater.numberOfRetries)) {
      log.warn(
          '"Connection closed before full header was received" error thrown - limits of retries '
          '($_maximumNumberOfRetriesAfterConnectionClosedError) exceeded '
          '- request with uri\n ${httpCallRepeater.uri}');
    } else if (_logHttpStatusException && error is HttpStatusException) {
      await _logApiHttpStatusException(error);
    } else {
      throw error;
    }
  }

  static Future _logApiHttpStatusException(HttpStatusException error) async {
    var errorJsonResponse = "";
    try {
      errorJsonResponse = await error.httpClientResponse.transform(utf8.decoder).join();
    } catch (e) {}
    print(error.toString() + " \nResponse: " + errorJsonResponse);
  }

  static bool _shouldRepeatOnConnectionClosedError(dynamic error, int numberOfRetriesSoFar) =>
      _isConnectionClosedError(error) &&
      _repeatAfterConnectionClosedError &&
      numberOfRetriesSoFar < _maximumNumberOfRetriesAfterConnectionClosedError;

  static bool _shouldLogNotRepeatedConnectionClosedError(dynamic error, int numberOfRetriesSoFar) =>
      _isConnectionClosedError(error) &&
      _repeatAfterConnectionClosedError &&
      numberOfRetriesSoFar >= _maximumNumberOfRetriesAfterConnectionClosedError;

  static bool _isConnectionClosedError(dynamic error) =>
      error is HttpException &&
      error.message.contains('Connection closed before full header was received');
}

class HttpStatusException extends HttpException {
  const HttpStatusException(Uri uri, this.statusCode, this.httpClientResponse,
      {String message = ''})
      : super(message, uri: uri);

  final int statusCode;
  final HttpClientResponse httpClientResponse;

  @override
  String toString() => 'HttpStatusException $statusCode: $message ${super.uri}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HttpStatusException &&
          runtimeType == other.runtimeType &&
          statusCode == other.statusCode;

  @override
  int get hashCode => statusCode.hashCode;
}
