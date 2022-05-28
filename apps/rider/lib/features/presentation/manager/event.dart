import 'package:flutter/material.dart';

abstract class RiderEvent {}

class InitEvent extends RiderEvent {}

class PostSupportEvent extends InitEvent {
  final String text;

  PostSupportEvent(this.text);
}

class EndDeliveryEvent extends InitEvent {
  final String text;

  EndDeliveryEvent(this.text);
}

class RemoveDeliveryEvent extends InitEvent {}

class GetVehicleTypesEvent extends InitEvent {}

class GetProfileEvent extends InitEvent {}

class GetDeliveriesEvent extends InitEvent {}

class LoginEvent extends RiderEvent {
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

class SignUPEvent extends RiderEvent {}
