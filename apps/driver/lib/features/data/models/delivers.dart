import 'package:intl/intl.dart';

class Delivers {
  Delivers({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.startLat,
    required this.startLong,
    required this.endLat,
    required this.endLong,
    required this.distance,
    required this.expectedTime,
    required this.price,
    required this.pickUp,
    required this.dropOff,
    this.createdAt,
    this.details,
  });

  final String id;
  final String customerId;
  final String customerName;
  final String startLat;
  final String startLong;
  final String endLat;
  final String endLong;
  final String? expectedTime;
  final int distance;
  final int price;
  final String pickUp;
  final String dropOff;
  final List<DeliveryProductDetails>? details;
  final String? createdAt;

  factory Delivers.fromJson(Map<String, dynamic> json) => Delivers(
        details: json["details"] == null
            ? []
            : List<DeliveryProductDetails>.from(
                json["details"].map((x) => DeliveryProductDetails.fromJson(x))),
        id: json["id"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        startLat: json["startLat"],
        startLong: json["startLong"],
        endLat: json["endLat"],
        expectedTime: json["expectedTime"],
        endLong: json["endLong"],
        createdAt: json["startDate"],
        distance: json["distance"],
        price: json["price"],
        pickUp: json["pickUp"],
        dropOff: json["dropOff"],
      );

  String get date {
    return DateFormat.d().format(parseDate);
  }

  DateTime get parseDate {
    return DateTime.parse(createdAt!);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "customerName": customerName,
        "startLat": startLat,
        "startLong": startLong,
        "endLat": endLat,
        "createdAt": createdAt,
        "expectedTime": expectedTime,
        "endLong": endLong,
        "distance": distance,
        "price": price,
        "pickUp": pickUp,
        "dropOff": dropOff,
      };
}

class DeliveryProductDetails {
  final String? productId;
  final String? offerId;
  final num quantity;

  DeliveryProductDetails(
      {this.productId, this.offerId, required this.quantity});

  factory DeliveryProductDetails.fromJson(Map<String, dynamic> json) {
    return DeliveryProductDetails(
      productId: json['productId'] as String,
      offerId: json['offerId'] as String,
      quantity: json['quantity'] as num,
    );
  }

  toJson() {
    return {
      'productId': productId,
      'offerId': offerId,
      'quantity': quantity,
    };
  }
}
