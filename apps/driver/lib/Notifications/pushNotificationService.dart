// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driver/Models/rideDetails.dart';
import 'package:driver/Notifications/notificationDialog.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PushNotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future initialize(context) async {
    await FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("msss " + message.data.toString());
      retrieveRideRequestInfo(getRideRequestId(message.data), context);
    });

    // firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     retrieveRideRequestInfo(getRideRequestId(message), context);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     retrieveRideRequestInfo(getRideRequestId(message), context);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     retrieveRideRequestInfo(getRideRequestId(message), context);
    //   },
    // );
  }

  Future<String?> getToken() async {
    String? token = await firebaseMessaging.getToken();
    print("This is token :: ");
    print(token);
    driversRef.child(currentfirebaseUser!.uid).child("token").set(token);

    firebaseMessaging.subscribeToTopic("alldrivers");
    firebaseMessaging.subscribeToTopic("allusers");
  }

  String getRideRequestId(Map<String, dynamic> message) {
    String rideRequestId = "";
    if (Platform.isAndroid) {
      rideRequestId = message['ride_request_id'];
    } else {
      rideRequestId = message['ride_request_id'];
    }

    return rideRequestId;
  }

  void retrieveRideRequestInfo(String rideRequestId, BuildContext context) {
    newRequestsRef.child(rideRequestId).once().then((s) {
      DataSnapshot dataSnapShot = s.snapshot;
      if (dataSnapShot.value != null) {
        // assetsAudioPlayer.open(Audio("sounds/alert.mp3"));
        // assetsAudioPlayer.play();

        double pickUpLocationLat = double.parse((dataSnapShot.value as Map)['pickup']['latitude'].toString());
        double pickUpLocationLng = double.parse((dataSnapShot.value as Map)['pickup']['longitude'].toString());
        String pickUpAddress = (dataSnapShot.value as Map)['pickup_address'].toString();

        double dropOffLocationLat = double.parse((dataSnapShot.value as Map)['dropoff']['latitude'].toString());
        double dropOffLocationLng = double.parse((dataSnapShot.value as Map)['dropoff']['longitude'].toString());
        String dropOffAddress = (dataSnapShot.value as Map)['dropoff_address'].toString();

        String paymentMethod = (dataSnapShot.value as Map)['payment_method'].toString();

        String rider_name = (dataSnapShot.value as Map)["rider_name"];
        String rider_phone = (dataSnapShot.value as Map)["rider_phone"];

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
