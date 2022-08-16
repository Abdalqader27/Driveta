// To parse this JSON data, do
//
//     final deliversProduct = deliversProductFromJson(jsonString);

import 'dart:convert';

List<DeliversProduct> deliversProductFromJson(String str) =>
    List<DeliversProduct>.from(
        json.decode(str).map((x) => DeliversProduct.fromJson(x)));

String deliversProductToJson(List<DeliversProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliversProduct {
  DeliversProduct({
    this.details,
    this.id,
    this.driverId,
    this.driverName,
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
  });

  final List<Detail>? details;
  final String? id;
  final String? driverId;
  final String? driverName;
  final String? vehicleId;
  final String? vehicleNumber;
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

  factory DeliversProduct.fromJson(Map<String, dynamic> json) =>
      DeliversProduct(
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        id: json["id"],
        driverId: json["driverId"],
        driverName: json["driverName"],
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
        endDate: DateTime.parse(json["endDate"]),
        distance: json["distance"],
        payingValue: json["payingValue"],
        price: json["price"],
        vehicleType: json["vehicleType"],
      );

  Map<String, dynamic> toJson() => {
        "details": List<dynamic>.from(details!.map((x) => x.toJson())),
        "id": id,
        "driverId": driverId,
        "driverName": driverName,
        "vehicleId": vehicleId,
        "vehicleNumber": vehicleNumber,
        "pickUp": pickUp,
        "dropOff": dropOff,
        "startLong": startLong,
        "endLong": endLong,
        "startLat": startLat,
        "endLat": endLat,
        "expectedTime": expectedTime,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "distance": distance,
        "payingValue": payingValue,
        "price": price,
        "vehicleType": vehicleType,
      };
}

class Detail {
  Detail({
    this.productId,
    this.offerId,
    this.productOrOfferName,
    this.quantity,
  });

  final String? productId;
  final String? offerId;
  final String? productOrOfferName;
  final num? quantity;

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
