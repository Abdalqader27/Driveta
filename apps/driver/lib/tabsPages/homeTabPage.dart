import 'dart:async';
import 'package:driver/AllScreens/registeration_screen.dart';
import 'package:driver/Assistants/assistantMethods.dart';
import 'package:driver/Models/drivers.dart';
import 'package:driver/Notifications/pushNotificationService.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeTabPage extends StatefulWidget {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  var geoLocator = Geolocator();

  String driverStatusText = "Offline Now - Go Online ";

  Color driverStatusColor = Colors.black;

  bool isDriverAvailable = false;

  @override
  void initState() {
    super.initState();

    getCurrentDriverInfo();
  }

  getRideType() {
    driversRef.child(currentfirebaseUser!.uid).child("car_details").child("type").once().then((s) {
      DataSnapshot snapshot = s.snapshot;
      if (snapshot.value != null) {
        setState(() {
          rideType = snapshot.value.toString();
        });
      }
    });
  }

  getRatings() {
    //update ratings
    driversRef.child(currentfirebaseUser!.uid).child("ratings").once().then((s) {
      DataSnapshot dataSnapshot = s.snapshot;

      if (dataSnapshot.value != null) {
        double ratings = double.parse(dataSnapshot.value.toString());
        setState(() {
          starCounter = ratings;
        });

        if (starCounter <= 1.5) {
          setState(() {
            title = "Very Bad";
          });
          return;
        }
        if (starCounter <= 2.5) {
          setState(() {
            title = "Bad";
          });

          return;
        }
        if (starCounter <= 3.5) {
          setState(() {
            title = "Good";
          });

          return;
        }
        if (starCounter <= 4.5) {
          setState(() {
            title = "Very Good";
          });
          return;
        }
        if (starCounter <= 5.0) {
          setState(() {
            title = "Excellent";
          });

          return;
        }
      }
    });
  }

  void locatePosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLatPosition, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void getCurrentDriverInfo() async {
    currentfirebaseUser =  FirebaseAuth.instance.currentUser;

    driversRef.child(currentfirebaseUser!.uid).once().then((s) {
      DataSnapshot dataSnapShot = s.snapshot;

      if (dataSnapShot.value != null) {
        driversInformation = Drivers.fromSnapshot(dataSnapShot);
      }
    });

    PushNotificationService pushNotificationService = PushNotificationService();

    pushNotificationService.initialize(context);
    pushNotificationService.getToken();

    AssistantMethods.retrieveHistoryInfo(context);
    getRatings();
    getRideType();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: HomeTabPage._kGooglePlex,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;

            locatePosition();
          },
        ),

        //online offline driver Container
        Container(
          height: 140.0,
          width: double.infinity,
          color: Colors.black87,
        ),

        Positioned(
          top: 60.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(24.0),
                  ),
                  onPressed: () {
                    if (isDriverAvailable != true) {
                      makeDriverOnlineNow();
                      getLocationLiveUpdates();

                      setState(() {
                        driverStatusColor = Colors.green;
                        driverStatusText = "Online Now ";
                        isDriverAvailable = true;
                      });

                      displayToastMessage("you are Online Now.", context);
                    } else {
                      makeDriverOfflineNow();

                      setState(() {
                        driverStatusColor = Colors.black;
                        driverStatusText = "Offline Now - Go Online ";
                        isDriverAvailable = false;
                      });

                      displayToastMessage("you are Offline Now.", context);
                    }
                  },
                  color: driverStatusColor,
                  child: Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          driverStatusText,
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Icon(
                          Icons.phone_android,
                          color: Colors.white,
                          size: 26.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void makeDriverOnlineNow() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    Geofire.initialize("availableDrivers");
    Geofire.setLocation(currentfirebaseUser!.uid, currentPosition.latitude, currentPosition.longitude);

    rideRequestRef?.set("searching");
    rideRequestRef?.onValue.listen((event) {});
  }

  void getLocationLiveUpdates() {
    homeTabPageStreamSubscription = Geolocator.getPositionStream().listen((Position position) {
      currentPosition = position;
      if (isDriverAvailable == true) {
        Geofire.setLocation(currentfirebaseUser!.uid, position.latitude, position.longitude);
      }
      LatLng latLng = LatLng(position.latitude, position.longitude);
      newGoogleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  void makeDriverOfflineNow() {
    Geofire.removeLocation(currentfirebaseUser!.uid);
    rideRequestRef?.onDisconnect();
    rideRequestRef?.remove();
    rideRequestRef = null;
  }
}
