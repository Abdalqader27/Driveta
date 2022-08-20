// To parse this JSON data, do
//
//     final driver = driverFromJson(jsonString);

import 'dart:convert';

List<Driver> driverFromJson(String str) =>
    List<Driver>.from(json.decode(str).map((x) => Driver.fromJson(x)));

String driverToJson(List<Driver> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Driver {
  Driver({
    this.id,
    this.name,
    this.userName,
    this.lat,
    this.long,
    this.angle,
    this.personalImage,
    this.isAvailable,
    this.phoneNumber,
    this.rate,
    this.vehicleId,
    this.vehicleColor,
    this.vehicleName,
    this.vehicleModelId,
    this.vehicleModelName,
    this.vehicleNumber,
    this.vehicleType,
  });

  final dynamic id;
  final dynamic name;
  final dynamic userName;
  final dynamic lat;
  final dynamic long;
  final dynamic angle;
  final PersonalImage? personalImage;
  final dynamic isAvailable;
  final dynamic phoneNumber;
  final dynamic rate;
  final dynamic vehicleId;
  final dynamic vehicleColor;
  final dynamic vehicleName;
  final dynamic vehicleModelId;
  final dynamic vehicleModelName;
  final dynamic vehicleNumber;
  final dynamic vehicleType;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        userName: json["userName"],
        lat: json["lat"],
        long: json["long"],
        angle: json["angle"],
        personalImage: PersonalImage.fromJson(json["personalImage"]),
        isAvailable: json["isAvailable"],
        phoneNumber: json["phoneNumber"],
        rate: json["rate"],
        vehicleId: json["vehicleId"],
        vehicleColor: json["vehicleColor"],
        vehicleName: json["vehicleName"],
        vehicleModelId: json["vehicleModelId"],
        vehicleModelName: json["vehicleModelName"],
        vehicleNumber: json["vehicleNumber"],
        vehicleType: json["vehicleType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "userName": userName,
        "lat": lat,
        "long": long,
        "angle": angle,
        "personalImage": personalImage?.toJson(),
        "isAvailable": isAvailable,
        "phoneNumber": phoneNumber,
        "rate": rate,
        "vehicleId": vehicleId,
        "vehicleColor": vehicleColor,
        "vehicleName": vehicleName,
        "vehicleModelId": vehicleModelId,
        "vehicleModelName": vehicleModelName,
        "vehicleNumber": vehicleNumber,
        "vehicleType": vehicleType,
      };
}

class PersonalImage {
  PersonalImage({
    this.id,
    this.src,
    this.name,
    this.length,
    this.type,
  });

  final dynamic id;
  final dynamic src;
  final dynamic name;
  final dynamic length;
  final dynamic type;

  factory PersonalImage.fromJson(Map<String, dynamic> json) => PersonalImage(
        id: json["id"],
        src: json["src"],
        name: json["name"],
        length: json["length"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
        "name": name,
        "length": length,
        "type": type,
      };
}
