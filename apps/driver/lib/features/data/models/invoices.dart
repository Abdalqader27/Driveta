// To parse this JSON data, do
//
//     final invoices = invoicesFromJson(jsonString);

import 'dart:convert';

Invoices invoicesFromJson(String str) => Invoices.fromJson(json.decode(str));

String invoicesToJson(Invoices data) => json.encode(data.toJson());

class Invoices {
  Invoices({
    this.totalAmount,
    this.monthAmount,
    this.totalTripsCount,
    this.monthTripsCount,
    this.invoices,
  });

  final int? totalAmount;
  final int? monthAmount;
  final int? totalTripsCount;
  final int? monthTripsCount;
  final List<Invoice>? invoices;

  factory Invoices.fromJson(Map<String, dynamic> json) => Invoices(
        totalAmount: json["totalAmount"],
        monthAmount: json["monthAmount"],
        totalTripsCount: json["totalTripsCount"],
        monthTripsCount: json["monthTripsCount"],
        invoices: List<Invoice>.from(
            json["invoices"].map((x) => Invoice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount,
        "monthAmount": monthAmount,
        "totalTripsCount": totalTripsCount,
        "monthTripsCount": monthTripsCount,
        "invoices": invoices == null
            ? []
            : List<dynamic>.from(invoices!.map((x) => x.toJson())),
      };
}

class Invoice {
  Invoice({
    this.id,
    this.invoiceNumber,
    this.total,
    this.note,
    this.deliveries,
  });

  final String? id;
  final String? invoiceNumber;
  final int? total;
  final String? note;
  final List<Delivery>? deliveries;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json["id"],
        invoiceNumber: json["invoiceNumber"],
        total: json["total"],
        note: json["note"],
        deliveries: List<Delivery>.from(
            json["deliveries"].map((x) => Delivery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoiceNumber": invoiceNumber,
        "total": total,
        "note": note,
        "deliveries": deliveries == null
            ? []
            : List<dynamic>.from(deliveries!.map((x) => x.toJson())),
      };
}

class Delivery {
  Delivery({
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
  });

  final String? id;
  final String? customerId;
  final String? customerName;
  final String? vehicleId;
  final String? vehicleNumber;
  final String? pickUp;
  final String? dropOff;
  final String? startLong;
  final String? endLong;
  final String? startLat;
  final String? endLat;
  final dynamic? expectedTime;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? distance;
  final int? payingValue;
  final int? price;

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
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
        endDate: DateTime.parse(json["endDate"]),
        distance: json["distance"],
        payingValue: json["payingValue"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "customerName": customerName,
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
      };
}
