class Delivers {
  Delivers({
    required this.id,
    required this.startLat,
    required this.startLong,
    required this.endLat,
    required this.endLong,
    required this.distance,
    required this.startDate,
    required this.expectedTime,
    required this.price,
    required this.pickUp,
    required this.vehicleType,
    required this.dropOff,
  });

  final String id;
  final String startLat;
  final String startLong;
  final dynamic startDate;
  final String endLat;
  final String endLong;
  final String? expectedTime;
  final int distance;
  final int vehicleType;
  final int price;
  final String pickUp;
  final String dropOff;

  factory Delivers.fromJson(Map<String, dynamic> json) => Delivers(
        id: json["id"],
        startLat: json["startLat"],
        startLong: json["startLong"],
        endLat: json["endLat"],
        startDate: json["startDate"],
        vehicleType: json["vehicleType"],
        expectedTime: json["expectedTime"],
        endLong: json["endLong"],
        distance: json["distance"],
        price: json["price"],
        pickUp: json["pickUp"],
        dropOff: json["dropOff"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startLat": startLat,
        "startLong": startLong,
        "endLat": endLat,
        "startDate": startDate,
        "vehicleType": vehicleType,
        "expectedTime": expectedTime,
        "endLong": endLong,
        "distance": distance,
        "price": price,
        "pickUp": pickUp,
        "dropOff": dropOff,
      };

  // give me copy with
  Delivers copyWith({
    String? id,
    String? startLat,
    String? startLong,
    dynamic startDate,
    String? endLat,
    String? endLong,
    String? expectedTime,
    int? distance,
    int? vehicleType,
    int? price,
    String? pickUp,
    String? dropOff,
  }) =>
      Delivers(
        id: id ?? this.id,
        startLat: startLat ?? this.startLat,
        startLong: startLong ?? this.startLong,
        startDate: startDate ?? this.startDate,
        endLat: endLat ?? this.endLat,
        endLong: endLong ?? this.endLong,
        expectedTime: expectedTime ?? this.expectedTime,
        distance: distance ?? this.distance,
        vehicleType: vehicleType ?? this.vehicleType,
        price: price ?? this.price,
        pickUp: pickUp ?? this.pickUp,
        dropOff: dropOff ?? this.dropOff,
      );
}
