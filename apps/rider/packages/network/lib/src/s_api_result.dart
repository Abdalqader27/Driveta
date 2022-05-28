import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 's_api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;

  const factory ApiResult.failure({required dynamic error}) = Failure<T>;
}

extension ApiResultX<Object> on ApiResult<Object> {
  bool get isSuccess => this is Success;

  bool get isFailure => this is Failure;

  Object get data => (this as Success).data;

  String get message => (this as Failure).message;
}

extension ApiResultEx on Iterable<ApiResult> {
  ApiResult<T>? mayBeOnFailure<T>() {
    for (final r in this) {
      late String message;
      var maybeFailure = r.maybeWhen(
          orElse: () => false,
          failure: (_) {
            message = _;
            return true;
          });
      if (maybeFailure) {
        return ApiResult.failure(error: message);
      }
    }
    return null;
  }
}
