import 'package:logger/logger.dart';

class Logs {
  static Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  static Logger loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );
}
