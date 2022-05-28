import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rider/common/assistants/requestAssistant.dart';
import 'package:rider/DataHandler/appData.dart';
import 'package:rider/Models/address.dart';
import 'package:rider/Models/allUsers.dart';
import 'package:rider/Models/directDetails.dart';
import 'package:rider/Models/history.dart';
import 'package:rider/Models/map_state.dart';
import 'package:rider/configMaps.dart';
import 'package:rider/main.dart';

import '../../libraries/init_app/run_app.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(LatLng position, context) async {
    String placeAddress = "";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";

    var response = await RequestAssistant.getRequest(url);

    if (response != 'failed') {
      placeAddress = response["results"][0]["formatted_address"];
      Address userPickUpAddress = Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;
    }

    return placeAddress;
  }

  static Future<DirectionDetails?> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res = await RequestAssistant.getRequest(directionUrl);

    if (res == "failed") {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints = res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText = res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText = res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue = res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }

  static int calculateFares(DirectionDetails directionDetails) {
    //in terms USD
    double timeTraveledFare = (directionDetails.durationValue ?? 0 / 60) * 0.20;
    double distancTraveledFare = (directionDetails.distanceValue ?? 0 / 1000) * 0.20;
    double totalFareAmount = timeTraveledFare + distancTraveledFare;

    //Local Currency
    //1$ = 160 RS
    double totalLocalAmount = totalFareAmount * 30;

    return totalLocalAmount.truncate();
  }

  static void getCurrentOnlineUserInfo() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    String userId = firebaseUser!.uid;
    DatabaseReference reference = FirebaseDatabase.instance.reference().child("users").child(userId);

    reference.once().then((s) {
      DataSnapshot dataSnapShot = s.snapshot;
      if (dataSnapShot.value != null) {
        userCurrentInfo = Users.fromSnapshot(dataSnapShot);
      }
    });
  }

  static double createRandomNumber(int num) {
    var random = Random();
    int radNumber = random.nextInt(num);
    return radNumber.toDouble();
  }

  static sendNotificationToDriver(String token, context, String ride_request_id) async {
    //var destionation = Provider.of<AppData>(context, listen: false).dropOffLocation;
    var destionation = si<MapState>().pinData.destinationPoint;
    var placeName = si<MapState>().pinData.destinationAddress;
    Map<String, String> headerMap = {
      'Content-Type': 'application/json',
      'Authorization': serverToken,
    };

    Map notificationMap = {'body': 'DropOff Address, $placeName', 'title': 'New Ride Request'};

    Map dataMap = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'ride_request_id': ride_request_id,
    };

    Map sendNotificationMap = {
      "notification": notificationMap,
      "data": dataMap,
      "priority": "high",
      "to": token,
    };

    var res = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headerMap,
      body: jsonEncode(sendNotificationMap),
    );
    print("--?>" + res.body);
  }

  //history

  static void retrieveHistoryInfo(context) {
    //retrieve and display Trip History
    rideRequestRef.orderByChild("rider_name").once().then((s) {
      DataSnapshot dataSnapShot = s.snapshot;

      if (dataSnapShot.value != null) {
        //update total number of trip counts to provider
        Map<dynamic, dynamic> keys = dataSnapShot.value as Map<String, dynamic>;
        int tripCounter = keys.length;
        Provider.of<AppData>(context, listen: false).updateTripsCounter(tripCounter);

        //update trip keys to provider
        List<String> tripHistoryKeys = [];
        keys.forEach((key, value) {
          tripHistoryKeys.add(key);
        });
        Provider.of<AppData>(context, listen: false).updateTripKeys(tripHistoryKeys);
        obtainTripRequestsHistoryData(context);
      }
    });
  }

  static void obtainTripRequestsHistoryData(context) {
    var keys = Provider.of<AppData>(context, listen: false).tripHistoryKeys;

    for (String key in keys) {
      rideRequestRef.child(key).once().then((s) {
        DataSnapshot snapshot = s.snapshot;
        if (snapshot.value != null) {
          rideRequestRef.child(key).child("rider_name").once().then((s2) {
            DataSnapshot snap = s2.snapshot;
            String name = snap.value.toString();
            if (name == userCurrentInfo?.name) {
              var history = History.fromSnapshot(snapshot);
              Provider.of<AppData>(context, listen: false).updateTripHistoryData(history);
            }
          });
        }
      });
    }
  }

  static String formatTripDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDate;
  }
}
