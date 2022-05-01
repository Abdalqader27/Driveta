import 'package:firebase_database/firebase_database.dart';

class History {
  String paymentMethod;
  String createdAt;
  String status;
  String fares;
  String dropOff;
  String pickup;

  History({this.paymentMethod, this.createdAt, this.status, this.fares, this.dropOff, this.pickup});

  History.fromSnapshot(DataSnapshot snapshot) {
    paymentMethod = (snapshot.value as Map)["payment_method"];
    createdAt = (snapshot.value as Map)["created_at"];
    status = (snapshot.value as Map)["status"];
    fares = (snapshot.value as Map)["fares"];
    dropOff = (snapshot.value as Map)["dropoff_address"];
    pickup = (snapshot.value as Map)["pickup_address"];
  }
}
