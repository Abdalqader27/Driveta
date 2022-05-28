import 'package:easy_localization/easy_localization.dart';
import 'package:either_dart/either.dart';
import 'package:network/network.dart';

Future<ApiResult<T>> onResult<T>(
  ApiResult result, {
  Function(T data)? onData,
  Function()? onError,
  bool popup = false,
}) async {
  return result.when(
    success: (dynamic data) {
      if (onData != null) {
        onData(data);
      }
      return ApiResult.success(data: data);
    },
    failure: (dynamic error) {
      if (onError != null) {
        onError();
      }
      return ApiResult.failure(error: error);
    },
  );
}

Future<ApiResult<T>> fetchApiResult<T>({
  required Future<bool> isConnected,
  required Future<Either<dynamic, T>> fetch,
  Function(T)? onData,
}) async {
  if (await isConnected) {
    final result = await fetch;
    return result.fold(
      (left) => ApiResult.failure(error: left),
      (right) async {
        if (onData != null) {
          try {
            await onData(right);
          } catch (_) {}
        }
        return ApiResult.success(data: right);
      },
    );
  } else {
    return ApiResult.failure(
        error: SResponseException(
      message: 'Please check your internet connection and try again'.tr(),
      error: 'No Internet'.tr(),
      exception: Exception(),
    ));
  }
}

Future<Either<SResponseException, T>> fetch<T>({
  required Future<T> Function() call,
}) async {
  try {
    final result = await call();
    return Right(result);
  } on SResponseException catch (e) {
    return Left(e);
  }
}
