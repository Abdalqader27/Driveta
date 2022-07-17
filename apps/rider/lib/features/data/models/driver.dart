// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

Driver driverFromJson(String str) => Driver.fromJson(json.decode(str));

String driverToJson(Driver data) => json.encode(data.toJson());

class Driver {
  final String? id;
  final String? name;
  final String? userName;
  final String? lat;
  final String? long;
  final bool? isAvailable;

  final String? phoneNumber;
  final int? rate;
  final String? vehicleId;
  final String? vehicleColor;
  final String? vehicleName;
  final String? vehicleModelId;
  final String? vehicleModelName;
  final String? vehicleNumber;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        userName: json["userName"],
        lat: json["lat"],
        long: json["long"],
        isAvailable: json["isAvailable"],
        phoneNumber: json["phoneNumber"],
        rate: json["rate"],
        vehicleId: json["vehicleId"],
        vehicleColor: json["vehicleColor"],
        vehicleName: json["vehicleName"],
        vehicleModelId: json["vehicleModelId"],
        vehicleModelName: json["vehicleModelName"],
        vehicleNumber: json["vehicleNumber"],
      );

  Driver(
      {this.phoneNumber,
      this.rate,
      this.vehicleId,
      this.vehicleColor,
      this.vehicleName,
      this.vehicleModelId,
      this.vehicleModelName,
      this.vehicleNumber,
      this.id,
      this.name,
      this.userName,
      this.lat,
      this.long,
      this.isAvailable});

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "userName": userName,
        "lat": lat,
        "long": long,
        "isAvailable": isAvailable,
      };
}
