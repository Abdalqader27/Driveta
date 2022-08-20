// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.token,
    required this.refreshToken,
    this.personalImage,
    this.balance,
    this.userName,
    this.name,
    this.phoneNumber,
    this.email,
    this.sexType,
  });

  final String id;
  final String? token;
  final String? refreshToken;
  final String? personalImage;
  final int? balance;
  final String? userName;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final int? sexType;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        token: json["token"],
        refreshToken: json["refreshToken"],
        personalImage: json["personalImage"],
        balance: json["balance"],
        userName: json["userName"],
        name: json["name"],
        phoneNumber: jsonDecode(json["phoneNumber"])['phoneNumber'],
        email: json["email"],
        sexType: json["sexType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "refreshToken": refreshToken,
        "personalImage": personalImage,
        "balance": balance,
        "userName": userName,
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "sexType": sexType,
      };
}
