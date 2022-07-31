import 'delivery_product_details.dart';

class DeliversProduct {
  DeliversProduct({
    required this.details,
    this.id,
    this.driverId,
    this.driverName,
    this.vehicleId,
    this.vehicleNumber,
    required this.pickUp,
    required this.dropOff,
    required this.startLong,
    required this.endLong,
    required this.startLat,
    required this.endLat,
    required this.expectedTime,
    this.startDate,
    this.endDate,
    required this.distance,
    required this.vehicleType,
    this.payingValue,
    required this.price,
  });

  final List<DeliveryProductDetails> details;
  final String? id;
  final String? driverId;
  final String? driverName;
  final String? vehicleId;
  final dynamic vehicleNumber;
  final String pickUp;
  final String dropOff;
  final String startLong;
  final String endLong;
  final String startLat;
  final String endLat;
  final String expectedTime;
  final DateTime? startDate;
  final DateTime? endDate;
  final int distance;
  final int? payingValue;
  final int? vehicleType;
  final int price;

  factory DeliversProduct.fromJson(Map<String, dynamic> json) =>
      DeliversProduct(
        details: List<DeliveryProductDetails>.from(
            json["details"].map((x) => DeliveryProductDetails.fromJson(x))),
        id: json["id"],
        driverId: json["driverId"],
        driverName: json["driverName"],
        vehicleId: json["vehicleId"],
        vehicleNumber: json["vehicleNumber"],
        pickUp: json["pickUp"],
        dropOff: json["dropOff"],
        vehicleType: json["vehicleType"],
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
        "details": List<dynamic>.from(details.map((x) => x)),
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
        "vehicleType": vehicleType,
        "expectedTime": expectedTime,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "distance": distance,
        "payingValue": payingValue,
        "price": price,
      };
}
