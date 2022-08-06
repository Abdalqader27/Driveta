part of '../network.dart';

/// A callback that returns a Dio response, presumably from a Dio method
/// it has called which performs an HTTP request, such as `dio.get()`,
/// `dio.post()`, etc.
typedef HttpLibraryMethod<T> = Future<Response<T>> Function();

/// Function which takes a Dio response object and an exception and returns
/// an optional [SHttpClientException], xoptionally mapping the response
/// to a custom exception.
typedef SResponseExceptionMapper = AppNetworkSResponseException? Function<T>(
  Response<T>,
  Exception,
);

/// Dio HTTP Wrapper with convenient, predictable exception handling.
class SHttpClient {
  /// Create a new App HTTP Client with the specified Dio instance [client]
  /// and an optional [exceptionMapper].
  SHttpClient({
    required Dio dio,
    required this.baseUrl,
    this.exceptionMapper,
    this.timeout = 35000,
    this.interceptors,
  }) : _dio = dio {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = timeout
      ..options.receiveTimeout = timeout
      ..transformer = SFlutterTransformer()
      ..httpClientAdapter
      ..options.headers = <String, dynamic>{
        'Content-Type': 'application/json; charset=UTF-8'
      };

    if (kDebugMode) {
      _dio.interceptors.add(sLogInterceptor);
      //_dio.interceptors.add(CustomInterceptors());
    }
    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
  }

  final String baseUrl;
  final int timeout;
  final List<Interceptor>? interceptors;

  final Dio _dio;

  /// If provided, this function which will be invoked when a response exception
  /// occurs, allowing the response exception to be mapped to a custom
  /// exception class which extends [SHttpClientException].
  final SResponseExceptionMapper? exceptionMapper;

  /// HTTP GET request.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _mapException(
      () => _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// HTTP POST request.
  Future<Response<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _mapException(
      () => _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// HTTP PUT request.
  Future<Response<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _mapException(
      () => _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  /// HTTP HEAD request.
  Future<Response<T>> head<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _mapException(
      () => _dio.head(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  /// HTTP DELETE request.
  Future<Response<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _mapException(
      () => _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  /// HTTP PATCH request.
  Future<Response<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _mapException(
      () => _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  // Map Dio exceptions (and any other exceptions) to an exception type
  // supported by our application.
  Future<Response<T>> _mapException<T>(
    HttpLibraryMethod<T> method, {
    SResponseExceptionMapper? mapper,
  }) async {
    try {
      return await method();
    } on DioError catch (exception) {
      if (exception.response?.statusCode.toString().matchAsPrefix('5') !=
          null) {
        throw AppNetworkException(
          reason: AppNetworkExceptionReason.serverError,
          exception: exception,
        );
      }
      switch (exception.type) {
        case DioErrorType.cancel:
          throw AppNetworkException(
            reason: AppNetworkExceptionReason.canceled,
            exception: exception,
          );
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          throw AppNetworkException(
            reason: AppNetworkExceptionReason.timedOut,
            exception: exception,
          );
        case DioErrorType.response:
          // For DioErrorType.response, we are guaranteed to have a
          // response object present on the exception.
          final response = exception.response;
          if (response == null || response is! Response<T>) {
            // This should never happen, judging by the current source code
            // for Dio.
            throw AppNetworkSResponseException(exception: exception);
          }
          throw response;
          throw mapper?.call(response, exception) ??
              exceptionMapper?.call(response, exception) ??
              '';
        case DioErrorType.other:
        default:
          if (exception.error is SocketException) {
            throw AppNetworkException(
                reason: AppNetworkExceptionReason.noInternet,
                exception: exception);
          }
          throw AppException.unknown(exception: exception);
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      throw AppException.unknown(
        exception: e is Exception ? e : Exception('Unknown exception occurred'),
      );
    }
  }
}
