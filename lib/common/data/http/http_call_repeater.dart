part of 'http_client.dart';

typedef HttpCaller<T> = Future<T> Function();

class HttpCallRepeater<T> {
  int numberOfRetries = 0;
  HttpCaller<T> _httpCaller;
  int callStart;
  final Uri uri;

  HttpCallRepeater(this.uri);

  Future<T> call(HttpCaller<T> httpCaller) async {
    _httpCaller = httpCaller;
    await _beforeCall();
    try {
      callStart = DateTime.now().millisecondsSinceEpoch;
      return await _httpCaller();
    } on RetryHttpCallException {
      return _retryCall();
    }
  }

  Future<void> _beforeCall() {
    return Future.value();
  }

  Future<T> _retryCall() async {
    ++numberOfRetries;
    await _beforeRetryCall();
    try {
      callStart = DateTime.now().millisecondsSinceEpoch;
      return await _httpCaller();
    } on RetryHttpCallException {
      return _retryCall();
    }
  }

  Future<void> _beforeRetryCall() {
    return Future.value();
  }
}

class RetryHttpCallException {}
