import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drop_here_mobile/common/log.dart';
import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:meta/meta.dart';

part 'http_call_repeater.dart';

class DhHttpClient {
  static final String loggerName = "SecureHttpClient";
  static final Log _log = Log(loggerName);
  static final Log _nonReportingLog = Log.nonReporting(loggerName);

  HttpClient _baseClient;
  Future<dynamic> initialized;
  final _Session session;
  String _baseUrl = "https://drop-here.herokuapp.com";
  final Map<String, String> _httpHeaders = {HttpHeaders.contentTypeHeader: "application/json"};

  DhHttpClient({bool useSession = true, bool withTrustedRoots = false})
      : session = useSession ? _Session() : _DummySession(),
        _baseClient = HttpClient();

  @mustCallSuper
  Future<void> init(String baseUrl) async {
    _baseUrl = baseUrl;
  }

  void setHttpHeader(String name, String value) {
    _httpHeaders[name] = value;
  }

  void clearHttpHeader(String name) {
    _httpHeaders.remove(name);
  }

  String get token => _httpHeaders[HttpHeaders.authorizationHeader];

  @visibleForTesting
  Future initForTests() async {
    _baseClient = HttpClient();
  }

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
    await initialized;
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
    await initialized;
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
    await initialized;
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
    await initialized;
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
    await initialized;
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
    _addHeaders(request.headers, headers);
    request.write(body);
    return request.close();
  }

  Future<HttpClientResponse> _prepareRequest(
      HttpClientRequest request, Map<String, String> headers) {
    _addHeaders(request.headers, headers);
    return request.close();
  }

  void _addHeaders(HttpHeaders httpHeaders, Map<String, String> headersMap) {
    Map<String, String> allHeaders = {
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
    };
    allHeaders.addAll(_httpHeaders);
    if (headersMap != null) {
      allHeaders.addAll(headersMap);
    }
    allHeaders[HttpHeaders.cookieHeader] = session.cookies;
    allHeaders.forEach((key, value) => httpHeaders.add(key, value));
  }

  Future<T> _onResponseHandler<T>(HttpClientResponse response, T Function(dynamic response) out,
      HttpCallRepeater httpCallRepeater,
      {bool parseRawToJson = true}) async {
    try {
      checkStatusCode(response, httpCallRepeater);

      if (!parseRawToJson) {
        return out(response);
      }
      var data = await response.transform(utf8.decoder).join();

      /// It uses different logger in order to not show this data in crashlytics
      _nonReportingLog.debug("received data: $data");

      return isNotEmpty(data) ? out(json.decode(data)) : null;
    } finally {
      session.update(response.headers);
    }
  }

  void checkStatusCode(HttpClientResponse response, HttpCallRepeater httpCallRepeater) {
    if (!_isHttpResponse2xx(response)) {
      throw HttpStatusException(httpCallRepeater.uri, response.statusCode,
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
}

class _ErrorHandler {
  static const bool _repeatAfterConnectionClosedError = true;
  static const int _maximumNumberOfRetriesAfterConnectionClosedError = 1;

  static void handleError({
    @required Log log,
    @required dynamic error,
    @required HttpCallRepeater httpCallRepeater,
    @required bool canRepeatRequest,
  }) {
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
    }
    throw error;
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
  const HttpStatusException(Uri uri, this.statusCode, {String message = ''})
      : super(message, uri: uri);

  final int statusCode;

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

class _Session {
  final Map<String, String> _cookies = {};

  DateTime lastSessionUpdate;

  String get cookies {
    if (_cookies.isEmpty) {
      return '';
    }
    return _cookies.values?.reduce((cookie, v) => cookie += v + ';');
  }

  void addCookie(String name, String value) {
    _cookies[name] = value;
  }

  String getCookie(String name) {
    return _cookies[name];
  }

  void update(HttpHeaders headers) {
    _updateCookie(headers);
    lastSessionUpdate = DateTime.now();
  }

  void _updateCookie(HttpHeaders headers) {
    var cookiesList = headers[HttpHeaders.setCookieHeader];

    cookiesList?.forEach((rawCookie) {
      rawCookie.split(';').forEach((cookie) {
        int index = cookie.indexOf('=');
        if (index == -1) {
          _cookies[cookie] = cookie;
        } else {
          _cookies[cookie.substring(0, index)] = cookie;
        }
      });
    });
  }
}

class _DummySession extends _Session {
  @override
  void update(HttpHeaders headers) {}
}
