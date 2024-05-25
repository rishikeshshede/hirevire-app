import 'package:logger/logger.dart';

// Singleton Logging Utility class
// Ensures that we always use the same instance of the logger throughout the app.
class LogHandler {
  static final Logger _logger =
      Logger(printer: PrettyPrinter(lineLength: 5000));

  static LogHandler? _instance;

  LogHandler._();

  factory LogHandler() {
    _instance ??= LogHandler._();
    return _instance!;
  }

  static void debug(dynamic log) {
    _logger.d(log);
  }

  static void info(dynamic log) {
    _logger.i(log);
  }

  static void error(dynamic log) {
    _logger.e(log);
  }
}

// Log Levels

// log.d('Debug message');   // Debug
// log.i('Information message');  // Info
// log.w('Warning message');  // Warning
// log.e('Error message');   // Error
// log.v('Verbose message');  // Verbose
