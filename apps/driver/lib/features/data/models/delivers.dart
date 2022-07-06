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

  factory Delivers.fromJson(Map<String, dynamic> json) => Delivers(
        id: json["id"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        startLat: json["startLat"],
        startLong: json["startLong"],
        endLat: json["endLat"],
        expectedTime: json["expectedTime"],
        endLong: json["endLong"],
        distance: json["distance"],
        price: json["price"],
        pickUp: json["pickUp"],
        dropOff: json["dropOff"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "customerName": customerName,
        "startLat": startLat,
        "startLong": startLong,
        "endLat": endLat,
        "expectedTime": expectedTime,
        "endLong": endLong,
        "distance": distance,
        "price": price,
        "pickUp": pickUp,
        "dropOff": dropOff,
      };
}
