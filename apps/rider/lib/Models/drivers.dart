import 'package:firebase_database/firebase_database.dart';

class Drivers {
  String ?name;
  String ?phone;
  String ?email;
  String ?id;
  String ?car_color;
  String ?car_model;
  String ?car_number;

  Drivers({
    this.name,
    this.phone,
    this.email,
    this.id,
    this.car_color,
    this.car_model,
    this.car_number,
  });

  Drivers.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;
    phone = (dataSnapshot.value as Map)["phone"];
    email = (dataSnapshot.value as Map)["email"];
    name = (dataSnapshot.value as Map)["name"];
    car_color = (dataSnapshot.value as Map)["car_details"]["car_color"];
    car_model = (dataSnapshot.value as Map)["car_details"]["car_model"];
    car_number = (dataSnapshot.value as Map)["car_details"]["car_number"];
  }
}
