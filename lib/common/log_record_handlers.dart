part of 'log.dart';

abstract class _LogAppender {
  void append(LogRecord logRecord, String concatenatedLog);
}

class _ConsoleLogAppender extends _LogAppender {
  static const int _charactersPerPrint = 800;

  @override
  void append(LogRecord logRecord, String concatenatedLog) {
    _printWrapped(concatenatedLog);
  }

  void _printWrapped(String text) {
    if (text.length <= _charactersPerPrint) {
      print(text);
    } else {
      _printLongString(text);
    }
  }

  void _printLongString(String text) {
    if (isEmpty(text)) return;
    int startIndex = 0;
    int endIndex = _charactersPerPrint;
    while (startIndex < text.length) {
      if (endIndex > text.length) endIndex = text.length;
      print(text.substring(startIndex, endIndex));
      startIndex += _charactersPerPrint;
      endIndex = startIndex + _charactersPerPrint;
    }
  }
}

class _ErrorReportLogAppender extends _LogAppender {
  @override
  void append(LogRecord logRecord, String concatenatedLog) {
    /// Checking for specific loggers that require data hiding
//    if (!logsExcludedFromLoggingToCrashLogger.containsValue(logRecord.loggerName)) {
//      Get.find.get<ErrorReportDataCollector>().log(concatenatedLog);
//    }
  }
}
