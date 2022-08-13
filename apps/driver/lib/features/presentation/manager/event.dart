import 'package:design/design.dart';
import 'package:image_picker/image_picker.dart';

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
  GetAvailableDeliveries();
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

class SignUPEvent extends DriverEvent {
  final BuildContext context;

  final String? userName;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? password;
  final int? sexType;
  final int? bloodType;
  final String? dob;
  final XFile? personalImageFile;
  final XFile? idPhotoFile;
  final XFile? drivingCertificateFile;

  SignUPEvent(
    this.context, {
    this.userName,
    this.name,
    this.phoneNumber,
    this.email,
    this.password,
    this.sexType,
    this.bloodType,
    this.dob,
    this.personalImageFile,
    this.idPhotoFile,
    this.drivingCertificateFile,
  });
}
