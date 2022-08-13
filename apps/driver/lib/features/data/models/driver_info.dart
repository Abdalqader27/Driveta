// To parse this JSON data, do
//
//     final driverInfo = driverInfoFromJson(jsonString);

import 'dart:convert';

DriverInfo driverInfoFromJson(String str) =>
    DriverInfo.fromJson(json.decode(str));

String driverInfoToJson(DriverInfo data) => json.encode(data.toJson());

class DriverInfo {
  DriverInfo({
    this.id,
    this.token,
    this.refreshToken,
    this.personalImage,
    this.idPhoto,
    this.drivingCertificate,
    this.balance,
    this.vehicleType,
    this.userName,
    this.name,
    this.phoneNumber,
    this.email,
    this.sexType,
    this.dob,
    required this.bloodType,
  });

  final String? id;
  final String? token;
  final String? refreshToken;
  final String? personalImage;
  final String? idPhoto;
  final String? drivingCertificate;
  final num? balance;
  final num? vehicleType;
  final String? userName;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final int? sexType;
  final dynamic dob;
  final num bloodType;

  factory DriverInfo.fromJson(Map<String, dynamic> json) => DriverInfo(
        id: json["id"],
        token: json["token"],
        refreshToken: json["refreshToken"],
        personalImage: json["personalImage"],
        idPhoto: json["idPhoto"],
        drivingCertificate: json["drivingCertificate"],
        balance: json["balance"],
        vehicleType: json["vehicleType"],
        userName: json["userName"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        sexType: json["sexType"],
        dob: json["dob"],
        bloodType: json["bloodType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "refreshToken": refreshToken,
        "personalImage": personalImage,
        "idPhoto": idPhoto,
        "drivingCertificate": drivingCertificate,
        "balance": balance,
        "vehicleType": vehicleType,
        "userName": userName,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "sexType": sexType,
        "dob": dob,
        "bloodType": bloodType,
      };
}
