import 'package:driver/common/assistants/requestAssistant.dart';
import 'package:driver/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:driver/features/data/models/address.dart';
import 'package:driver/features/data/models/allUsers.dart';
import 'package:driver/features/data/models/directDetails.dart';
import 'package:driver/configMaps.dart';

class AssistantMethods {
  static Future<DirectionDetails?> obtainPlaceDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res = await RequestAssistant.getRequest(directionUrl);

    print(res);
    if (res == "failed") {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints =
        res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText =
        res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue =
        res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText =
        res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue =
        res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }

  static int calculateFares(DirectionDetails directionDetails) {
    //in terms USD
    double timeTraveledFare = (directionDetails.durationValue ?? 0 / 60) * 0.20;
    double distancTraveledFare =
        (directionDetails.distanceValue ?? 0 / 1000) * 0.20;
    double totalFareAmount = timeTraveledFare + distancTraveledFare;

    //Local Currency
    //1$ = 160 RS
    //double totalLocalAmount = totalFareAmount * 160;
    if (rideType == "uber-x") {
      double result = (totalFareAmount.truncate()) * 2.0;
      return result.truncate();
    } else if (rideType == "uber-go") {
      return totalFareAmount.truncate();
    } else if (rideType == "bike") {
      double result = (totalFareAmount.truncate()) / 2.0;
      return result.truncate();
    } else {
      return totalFareAmount.truncate();
    }
  }

  static void disableHomeTabLiveLocationUpdates() {
    homeTabPageStreamSubscription.pause();
    //Geofire.removeLocation(currentfirebaseUser!.uid);
  }

  static void enableHomeTabLiveLocationUpdates() {
    homeTabPageStreamSubscription.resume();
    //Geofire.setLocation(currentfirebaseUser!.uid, currentPosition.latitude, currentPosition.longitude);
  }

  static String formatTripDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";

    return formattedDate;
  }
}
