/// File created by
/// Abed <Abed-supy-io>
/// on 28 /Apr/2022
part of '../utils.dart';

Logger _logger = Logger(
  printer: PrettyPrinter(printTime: true, lineLength: 5000),
);

/// learnt from vandad Nahavan
extension Log on Object {
  void log() => devtools.log(toString());
}

extension Loggers on Object {
  /// Log a message at level [Level.verbose].
  void logV() => _logger.v(this);

  /// Log a message at level [Level.debug].
  void logD() => _logger.d(this);

  /// Log a message at level [Level.info].
  void logI() => _logger.i(this);

  /// Log a message at level [Level.warning].
  void logW() => _logger.w(this);

  /// Log a message at level [Level.error].
  void logE() => _logger.e(this);

  /// Log a message at level [Level.wtf].
  void logWTF() => _logger.wtf(this);
}

/// Log a message at level [Level.verbose].
void logV(String message) {
  _logger.v(message);
}

/// Log a message at level [Level.debug].
void logD(String message) {
  _logger.d(message);
}

/// Log a message at level [Level.info].
void logI(String message) {
  _logger.i(message);
}

/// Log a message at level [Level.warning].
void logW(String message) {
  _logger.w(message);
}

/// Log a message at level [Level.error].
void logE(String message) {
  _logger.e(message);
}

/// Log a message at level [Level.wtf].
void logWTF(String message) {
  _logger.wtf(message);
}
