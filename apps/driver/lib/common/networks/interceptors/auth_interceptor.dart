import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final user = _getUser();
    // if (user != null) {
    //   options.headers["Authorization"] = "Bearer " + user.token;
    // }
    // handler.next(options);
  }
}
