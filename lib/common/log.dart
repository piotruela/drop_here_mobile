import 'package:drop_here_mobile/common/ui/utils/string_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

part 'log_record_handlers.dart';

class Log {
  static final List<_LogAppender> _logAppenders = [];

  static void config({@required bool loggingEnabled}) {
    Logger.root.clearListeners();
    Logger.root.level = Level.ALL;
    recordStackTraceAtLevel = Level.SHOUT;
    _configureLogAppenders(loggingEnabled);
    Logger.root.onRecord.listen((LogRecord rec) {
      _logAppenders.forEach((_LogAppender appender) {
        final String msg =
            '${rec.time}: ${_levelName(rec.level).padRight(5)}: ${rec.loggerName}: ${rec.message} ${rec.error ?? ""} ${rec.stackTrace ?? ""}';
        appender.append(rec, msg);
      });
    });
  }

  static void _configureLogAppenders(loggingEnabled) {
    _logAppenders.clear();
    _logAppenders.add(_ErrorReportLogAppender());

    if (loggingEnabled) {
      _logAppenders.add(_ConsoleLogAppender());
    }
  }

  final Logger _logger;

  Log._(this._logger);

  factory Log(String name) {
    return Log._(Logger(name));
  }

  factory Log.nonReporting(String name) {
    final String exclusionName = "NonReporting" + name;
    return Log._(Logger(exclusionName));
  }

  void debug(String message) {
    _logger.fine(message);
  }

  void warn(String message, [Object error, StackTrace stackTrace]) {
    _logger.warning(message, error, stackTrace);
  }

  void error(String message, [Object error, StackTrace stackTrace]) {
    _logger.shout(message, error, stackTrace);
  }

  void info(String message) {
    _logger.info(message);
  }

  static String _levelName(Level level) {
    if (level > Level.WARNING) {
      return "ERROR";
    }
    if (level > Level.INFO) {
      return "WARN";
    }
    if (level > Level.FINE) {
      return "INFO";
    }
    return "DEBUG";
  }
}
