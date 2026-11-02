import 'dart:developer' as developer;

class AppLogger {
  static void info(String message, {String? tag}) {
    developer.log(message, name: tag ?? 'Pulso');
  }

  static void error(String message, {Object? error, StackTrace? stack, String? tag}) {
    developer.log(message, name: tag ?? 'Pulso', error: error, stackTrace: stack);
  }
}
