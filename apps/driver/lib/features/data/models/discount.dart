import 'dart:convert';

Discount discountFromJson(String str) => Discount.fromJson(json.decode(str));

String discountToJson(Discount data) => json.encode(data.toJson());

class Discount {
  int? id;
  String? value;
  String? code;

  Discount({
    this.id,
    this.value,
    this.code,
  });

  Discount copyWith({
    int? id,
    String? value,
    String? code,
  }) =>
      Discount(
        id: id ?? this.id,
        value: value ?? this.value,
        code: code ?? this.code,
      );

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["id"],
        value: json["value"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "code": code ?? null,
      };
}
