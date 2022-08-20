part of '../network.dart';

class AppException<OriginalException> implements Exception {
  AppException({required this.message, required this.exception});

  AppException.unknown({required this.exception}) : message = 'unknown';

  final OriginalException exception;
  final String message;

  AppException copyWith({
    OriginalException? exception,
    String? message,
  }) {
    return AppException(
      exception: exception ?? this.exception,
      message: message ?? this.message,
    );
  }
}

enum AppNetworkExceptionReason { canceled, timedOut, responseError, noInternet, serverError }

class AppNetworkException<OriginalException extends Exception> extends AppException<OriginalException> {
  /// Create a network exception.
  AppNetworkException({
    required this.reason,
    required OriginalException exception,
  }) : super(exception: exception, message: reason.name);

  /// The reason the network exception occurred.
  final AppNetworkExceptionReason reason;
}

class AppNetworkSResponseException<OriginalException extends Exception, DataType>
    extends AppNetworkException<OriginalException> {
  AppNetworkSResponseException({
    required OriginalException exception,
    this.statusCode,
    this.data,
  }) : super(
          reason: AppNetworkExceptionReason.responseError,
          exception: exception,
        );

  final DataType? data;
  final int? statusCode;

  bool get hasData => data != null;

  /// If the status code is null, returns false. Otherwise, allows the
  /// given closure [evaluator] to validate the given http integer status code.
  ///
  /// Usage:
  /// ```
  /// final isValid = SResponseException.validateStatusCode(
  ///   (statusCode) => statusCode >= 200 && statusCode < 300,
  /// );
  /// ```
  bool validateStatusCode(bool Function(int statusCode) evaluator) {
    final statusCode = this.statusCode;
    if (statusCode == null) return false;
    return evaluator(statusCode);
  }
}

Future<T> throwAppException<T>(FutureOr<T> Function() call) async {
  try {
    return call();
  } on AppException catch (_) {
    rethrow;
  } catch (e, s) {
    log(e.toString(), stackTrace: s);
    throw AppException.unknown(exception: e);
  }
}
