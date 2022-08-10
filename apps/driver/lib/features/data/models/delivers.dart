// To parse this JSON data, do
//
//     final delivers = deliversFromJson(jsonString);

import 'dart:convert';

List<Delivers> deliversFromJson(String str) => List<Delivers>.from(json.decode(str).map((x) => Delivers.fromJson(x)));

String deliversToJson(List<Delivers> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Delivers {
    Delivers({
        this.details,
        this.id,
        this.customerId,
        this.customerName,
        this.expectedTime,
        this.riderPhone,
        this.dateCreated,
        this.startLat,
        this.startLong,
        this.endLat,
        this.endLong,
        this.distance,
        this.price,
        this.pickUp,
        this.dropOff,
    });

    final List<Detail>? details;
    final String ?id;
    final String ?customerId;
    final String ?customerName;
    final String ?expectedTime;
    final String ?riderPhone;
    final DateTime? dateCreated;
    final String ?startLat;
    final String ?startLong;
    final String ?endLat;
    final String ?endLong;
    final int ?distance;
    final int? price;
    final String ?pickUp;
    final String ?dropOff;

    factory Delivers.fromJson(Map<String, dynamic> json) => Delivers(
        details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        id: json["id"],
        customerId: json["customerId"],
        customerName: json["customerName"],
        expectedTime: json["expectedTime"],
        riderPhone: json["riderPhone"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        startLat: json["startLat"],
        startLong: json["startLong"],
        endLat: json["endLat"],
        endLong: json["endLong"],
        distance: json["distance"],
        price: json["price"],
        pickUp: json["pickUp"],
        dropOff: json["dropOff"],
    );

    Map<String, dynamic> toJson() => {
        "details":details==null?[]: List<dynamic>.from(details!.map((x) => x.toJson())),
        "id": id,
        "customerId": customerId,
        "customerName": customerName,
        "expectedTime": expectedTime,
        "riderPhone": riderPhone,
        "dateCreated": dateCreated?.toIso8601String(),
        "startLat": startLat,
        "startLong": startLong,
        "endLat": endLat,
        "endLong": endLong,
        "distance": distance,
        "price": price,
        "pickUp": pickUp,
        "dropOff": dropOff,
    };
}

class Detail {
    Detail({
        this.productId,
        this.offerId,
        this.name,
        this.quantity,
    });

    final String ?productId;
    final dynamic ?offerId;
    final String ?name;
    final int ?quantity;

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
