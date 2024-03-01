import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger();

  static void printInfo(String message) {
    _logger.i(message);
  }

  static void printWarning(dynamic error) {
    _logger.w(error);
  }

  static void printError(dynamic error) {
    _logger.e(error);
  }
}
