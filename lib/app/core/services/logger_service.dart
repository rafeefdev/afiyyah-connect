import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:intl/intl.dart';

/// Service to set up and manage logging across the application.
class LoggerService {
  static final _dateFormat = DateFormat('Hms.S');

  /// Sets up the root logger to print messages to the console.
  ///
  /// In debug mode, it logs all levels. In release mode, it only logs
  /// messages with a level of `Level.INFO` or higher to reduce noise.
  static void setupLogger() {
    // Set the logging level based on the environment.
    Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;

    // Listen for new log records and print them to the console.
    Logger.root.onRecord.listen((record) {
      // Only print logs in debug mode for cleaner release output.
      if (kDebugMode) {
        final formattedTime = _dateFormat.format(record.time);
        debugPrint(
          '[${record.level.name}] $formattedTime ${record.loggerName}: ${record.message}',
        );

        // If there's an error object, print it.
        if (record.error != null) {
          debugPrint('  ERROR: ${record.error}');
        }
        // If there's a stack trace, print it.
        if (record.stackTrace != null) {
          debugPrint('  STACKTRACE: ${record.stackTrace}');
        }
      }
    });
  }

  /// Returns a logger instance for the given [name].
  ///
  /// This is a convenience method to easily get a logger for a specific class
  /// or component.
  static Logger getLogger(String name) {
    return Logger(name);
  }
}
