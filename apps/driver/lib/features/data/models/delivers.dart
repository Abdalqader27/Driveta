// To parse this JSON data, do
//
//     final delivers = deliversFromJson(jsonString);

import 'dart:convert';

List<Delivers> deliversFromJson(String str) =>
    List<Delivers>.from(json.decode(str).map((x) => Delivers.fromJson(x)));

class Delivers {
  final String? id;
  final String? customerId;
  final String? customerName;
  final String? vehicleId;
  final dynamic vehicleNumber;
  final String? pickUp;
  final String? dropOff;
  final String? startLong;
  final String? endLong;
  final String? startLat;
  final String? endLat;
  final String? expectedTime;
  final DateTime? startDate;
  final DateTime? endDate;
  final num? distance;
  final num? payingValue;
  final num? price;
  final num? vehicleType;
  final List<Detail?>? details;
  final String? riderPhone;
  final DateTime? dateCreated;

  factory Delivers.fromJson(Map<String, dynamic> json) => Delivers(
        details: json["details"] == null
            ? null
            : List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        id: json["id"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        expectedTime: json["expectedTime"],
        riderPhone: json["riderPhone"],
        dateCreated: json["dateCreated"] == null
            ? null
            : DateTime.parse(json["dateCreated"]),
        startLat: json["startLat"],
        startLong: json["startLong"],
        endLat: json["endLat"],
        endLong: json["endLong"],
        distance: json["distance"],
        price: json["price"],
        pickUp: json["pickUp"],
        dropOff: json["dropOff"],
        vehicleId: json["vehicleId"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        payingValue: json["payingValue"],
        vehicleType: json["vehicleType"],
      );

  Delivers(
      {this.id,
      this.customerId,
      this.customerName,
      this.vehicleId,
      this.vehicleNumber,
      this.pickUp,
      this.dropOff,
      this.startLong,
      this.endLong,
      this.startLat,
      this.endLat,
      this.expectedTime,
      this.startDate,
      this.endDate,
      this.distance,
      this.payingValue,
      this.price,
      this.vehicleType,
      this.details,
      this.riderPhone,
      this.dateCreated});
}

class Detail {
  Detail({
    this.productId,
    this.offerId,
    this.name,
    this.quantity,
  });

  final String? productId;
  final dynamic? offerId;
  final String? name;
  final num? quantity;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        productId: json["productId"],
        offerId: json["offerId"],
        name: json["name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "offerId": offerId,
        "name": name,
        "quantity": quantity,
      };
}
