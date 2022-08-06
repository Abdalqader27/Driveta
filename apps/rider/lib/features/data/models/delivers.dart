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
}
