part of '../network.dart';

class SResponseException extends AppNetworkSResponseException {
  SResponseException({
    required this.message,
    required this.error,
    required Exception exception,
  }) : super(exception: exception);

  final String message;
  final String error;
}
