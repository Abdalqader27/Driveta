import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String id;
  String email;
  String name;
  String phone;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
  });

  factory UserModel.fromSnapshot(DataSnapshot dataSnapshot) {
    return UserModel(
        id: dataSnapshot.key!,
        email: (dataSnapshot.value! as Map)["email"],
        name: (dataSnapshot.value! as Map)["name"],
        phone: (dataSnapshot.value! as Map)["phone"]);
  }
}
