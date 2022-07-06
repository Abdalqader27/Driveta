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

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        userName: json["userName"],
        lat: json["lat"],
        long: json["long"],
        isAvailable: json["isAvailable"],
      );

  Driver({this.id, this.name, this.userName, this.lat, this.long, this.isAvailable});

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "userName": userName,
        "lat": lat,
        "long": long,
        "isAvailable": isAvailable,
      };
}
