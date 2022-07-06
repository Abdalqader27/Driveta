import 'package:design/design.dart';
import 'package:driver/features/data/models/delivers.dart';

abstract class DriverEvent {}

class InitEvent extends DriverEvent {}

class PostSupportEvent extends DriverEvent {
  final String text;

  PostSupportEvent(this.text);
}

class GetProfileEvent extends DriverEvent {}

class GetInvoicesEvent extends DriverEvent {}

class GetStatisticsEvent extends DriverEvent {}

class GetHistoriesEvent extends DriverEvent {}

class GetAvailableDeliveries extends DriverEvent {
  final List<Delivers> list;

  GetAvailableDeliveries(this.list);
}

class LoadingEvent extends DriverEvent {}

class LoginEvent extends DriverEvent {
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

class SignUPEvent extends DriverEvent {}
