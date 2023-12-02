
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger {
  static final LogServiceImpl _logService = LogServiceImpl.instance;

  static void verbose(dynamic message) {
    if (kDebugMode) {
      _logService.logger.t(message);
    }
  }

  static void debug(dynamic message) {
    if (kDebugMode) {
      _logService.logger.d(message);
    }
  }

  static void info(dynamic message) {
    if (kDebugMode) {
      _logService.logger.i(message);
    }
  }

  static void warning(dynamic message) {
    if (kDebugMode) {
      _logService.logger.w(message);
    }
  }

  static void error(dynamic message) {
    if (kDebugMode) {
      _logService.logger.e(message);
    }
  }

  static void fatal(dynamic message) {
    if (kDebugMode) {
      _logService.logger.f(message);
    }
  }
}

class LogServiceImpl {
  static final instance = LogServiceImpl._();
  LogServiceImpl._();

  final logger = Logger(
    printer: MyPrinter(),
  );
}

class MyPrinter extends LogPrinter {
  static final levelEmojis = {
    Level.trace: '🙂',
    Level.debug: '🐛',
    Level.info: '💡',
    Level.warning: '❓',
    Level.error: '⛔',
    Level.fatal: '🤬',
  };

  @override
  List<String> log(LogEvent event) {
    final icon = levelEmojis[event.level]!;
    final msg = event.message;
    final time = DateTime.now().toLocal().toString();
    return ['[$time] $icon $msg'];
  }
}
