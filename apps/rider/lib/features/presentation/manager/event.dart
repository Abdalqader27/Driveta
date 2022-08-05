import 'package:flutter/material.dart';

abstract class RiderEvent {}

class InitEvent extends RiderEvent {}

class PostSupportEvent extends InitEvent {
  final String text;

  PostSupportEvent(this.text);
}

class EndDeliveryEvent extends InitEvent {
  final String rate;
  final String id;

  EndDeliveryEvent({required this.rate, required this.id});
}

class RemoveDeliveryEvent extends InitEvent {}

class GetStoresEvent extends InitEvent {}

class GetStoreDetailsEvent extends InitEvent {
  final String id;

  GetStoreDetailsEvent(this.id);
}

class GetVehicleTypesEvent extends InitEvent {}

class GetProfileEvent extends InitEvent {}

class GetDeliveriesEvent extends InitEvent {}

class GetDeliveriesProductEvent extends InitEvent {}

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

class SignUPEvent extends RiderEvent {
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  final String userName;
  final int sexType;
  final String dob;
  final String bloodType;

  SignUPEvent(
      {required this.email,
      required this.password,
      required this.name,
      required this.phoneNumber,
      required this.userName,
      required this.sexType,
      required this.dob,
      required this.bloodType});
}
