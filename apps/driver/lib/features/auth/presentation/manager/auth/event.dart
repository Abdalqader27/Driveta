import 'package:flutter/material.dart';

abstract class AuthEvent {}

class InitEvent extends AuthEvent {}

class LoadingEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final BuildContext context;
  final String email;
  final String password;
  final String deviceToken;
  final bool rememberMe;

  LoginEvent(
    this.context, {
    required this.email,
    required this.password,
    required this.deviceToken,
    required this.rememberMe,
  });
}

class SignUPEvent extends AuthEvent {}
