import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Users {
  String id;
  String email;
  String name;
  String phone;

  Users({
    this.id,
    this.email,
    this.name,
    this.phone,
  });

  Users.fromSnapshot(DataSnapshot dataSnapshot) {
    id = dataSnapshot.key;
    email = (dataSnapshot.value as Map)["email"];
    name = (dataSnapshot.value as Map)["name"];
    phone = (dataSnapshot.value as Map)["phone"];
  }
}
