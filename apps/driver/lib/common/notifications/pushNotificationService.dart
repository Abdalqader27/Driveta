import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

import '../../Models/rideDetails.dart';
import '../../configMaps.dart';
import '../../main.dart';
import '../utils/logs.dart';
import 'notificationDialog.dart';

class PushNotificationService {
  Future initialize(context) async {
    FirebaseMessaging.onMessage.listen((event) {
      Logs.logger.i(event.data);
      retrieveRideRequestInfo(getRideRequestId(event.data), context);
    });
  }

  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("This is token :: ");
    print(token);
    driversRef.child(currentfirebaseUser!.uid).child("token").set(token);

    FirebaseMessaging.instance.subscribeToTopic("alldrivers");
    FirebaseMessaging.instance.subscribeToTopic("allusers");
  }

  String getRideRequestId(Map<String, dynamic> message) {
    String rideRequestId = "";
    if (Platform.isAndroid) {
      rideRequestId = message['data']['ride_request_id'];
    } else {
      rideRequestId = message['ride_request_id'];
    }

    return rideRequestId;
  }

  void retrieveRideRequestInfo(String rideRequestId, BuildContext context) {
    newRequestsRef.child(rideRequestId).once().then((db) {
      final dataSnapShot = db.snapshot;
      if (dataSnapShot.value != null) {
        // assetsAudioPlayer.open(Audio("sounds/alert.mp3"));
        // assetsAudioPlayer.play();

        double pickUpLocationLat =
            double.parse((dataSnapShot.value as Map<String, dynamic>)['pickup']['latitude'].toString());
        double pickUpLocationLng =
            double.parse((dataSnapShot.value as Map<String, dynamic>)['pickup']['longitude'].toString());
        String pickUpAddress = (dataSnapShot.value as Map<String, dynamic>)['pickup_address'].toString();

        double dropOffLocationLat =
            double.parse((dataSnapShot.value as Map<String, dynamic>)['dropoff']['latitude'].toString());
        double dropOffLocationLng =
            double.parse((dataSnapShot.value as Map<String, dynamic>)['dropoff']['longitude'].toString());
        String dropOffAddress = (dataSnapShot.value as Map<String, dynamic>)['dropoff_address'].toString();

        String paymentMethod = (dataSnapShot.value as Map<String, dynamic>)['payment_method'].toString();

        String rider_name = (dataSnapShot.value as Map<String, dynamic>)["rider_name"];
        String rider_phone = (dataSnapShot.value as Map<String, dynamic>)["rider_phone"];

        RideDetails rideDetails = RideDetails();
        rideDetails.ride_request_id = rideRequestId;
        rideDetails.pickup_address = pickUpAddress;
        rideDetails.dropoff_address = dropOffAddress;
        rideDetails.pickup = LatLng(pickUpLocationLat, pickUpLocationLng);
        rideDetails.dropoff = LatLng(dropOffLocationLat, dropOffLocationLng);
        rideDetails.payment_method = paymentMethod;
        rideDetails.rider_name = rider_name;
        rideDetails.rider_phone = rider_phone;

        print("Information :: ");
        print(rideDetails.pickup_address);
        print(rideDetails.dropoff_address);

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => NotificationDialog(
            rideDetails: rideDetails,
          ),
        );
      }
    });
  }
}
