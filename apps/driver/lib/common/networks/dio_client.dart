import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const _defaultConnectTimeout = 45000;
const _defaultReceiveTimeout = 45000;
// const String _kRefreshTokenRoute = '';
const String kBaseUrl = 'http://driveta-001-site1.btempurl.com/';

class DioClient {
  String baseUrl;
  final Dio _dio;

  //Create a new instance to request the token.
  final _tokenDio = Dio();

  final List<Interceptor>? interceptors;

  DioClient({
    required Dio dio,
    this.baseUrl = kBaseUrl,
    this.interceptors,
  }) : _dio = dio {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    _tokenDio.options = _dio.options;

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
    final logInterceptor = LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: false,
      request: false,
      requestBody: true,
    );
    if (kDebugMode) {
      _dio.interceptors.add(logInterceptor);
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e, s) {
      debugPrint(s.toString());
      throw SocketException(e.toString());
    } on FormatException catch (_, s) {
      debugPrint("$s");
      throw const FormatException("Unable to process the data");
    } catch (e, s) {
      debugPrint("$s");
      rethrow;
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool auth = false,
  }) async {
    Response? response;
    try {
      response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e, s) {
      debugPrint("$s");
      throw SocketException(e.toString());
    } on FormatException catch (_, s) {
      debugPrint("$s");
      throw const FormatException("Unable to process the data");
    } catch (e, s) {
      debugPrint("$s");
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e, s) {
      debugPrint("$s");
      throw SocketException(e.toString());
    } on FormatException catch (_, s) {
      debugPrint("$s");
      throw const FormatException("Unable to process the data");
    } catch (e, s) {
      debugPrint("$s");
      rethrow;
    }
  }
}
