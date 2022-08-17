// To parse this JSON data, do
//
//     final deliversProduct = deliversProductFromJson(jsonString);

import 'dart:convert';

DeliversProduct deliversProductFromJson(String str) =>
    DeliversProduct.fromJson(json.decode(str));

class DeliversProduct {
  DeliversProduct({
    this.details,
    this.id,
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
    this.driverId,
    this.driverName,
  });

  final List<Detail>? details;
  final dynamic id;
  final dynamic customerId;
  final dynamic customerName;
  final dynamic vehicleId;
  final dynamic vehicleNumber;
  final dynamic pickUp;
  final dynamic dropOff;
  final dynamic startLong;
  final dynamic endLong;
  final dynamic startLat;
  final dynamic endLat;
  final dynamic expectedTime;
  final dynamic startDate;
  final dynamic endDate;
  final dynamic distance;
  final dynamic payingValue;
  final dynamic price;
  final dynamic vehicleType;
  final dynamic driverId;
  final dynamic driverName;

  factory DeliversProduct.fromJson(Map<String, dynamic> json) =>
      DeliversProduct(
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        id: json["id"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        vehicleId: json["vehicleId"],
        vehicleNumber: json["vehicleNumber"],
        pickUp: json["pickUp"],
        dropOff: json["dropOff"],
        startLong: json["startLong"],
        endLong: json["endLong"],
        startLat: json["startLat"],
        endLat: json["endLat"],
        expectedTime: json["expectedTime"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: json["endDate"],
        distance: json["distance"],
        payingValue: json["payingValue"],
        price: json["price"],
        vehicleType: json["vehicleType"],
        driverId: json["driverId"],
        driverName: json["driverName"],
      );
}

class Detail {
  Detail({
    this.productId,
    this.offerId,
    this.productOrOfferName,
    this.quantity,
  });

  final dynamic productId;
  final dynamic offerId;
  final dynamic productOrOfferName;
  final dynamic quantity;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        productId: json["productId"],
        offerId: json["offerId"],
        productOrOfferName: json["productOrOfferName"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "offerId": offerId,
        "productOrOfferName": productOrOfferName,
        "quantity": quantity,
      };
}
