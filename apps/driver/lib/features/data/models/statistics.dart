// To parse this JSON data, do
//
//     final driverProfile = driverProfileFromJson(jsonString);

import 'dart:convert';

class Statistics {
  Statistics({
    required this.totalDistance,
    required this.totalAmount,
    required this.deliveryCount,
    required this.rateAvg,
  });

  final num totalDistance;
  final num totalAmount;
  final num deliveryCount;
  final num rateAvg;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        totalDistance: json["totalDistance"],
        totalAmount: json["totalAmount"],
        deliveryCount: json["deliveryCount"],
        rateAvg: json["rateAvg"],
      );
}
