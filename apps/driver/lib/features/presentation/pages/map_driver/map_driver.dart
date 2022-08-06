import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:driver/common/assistants/assistantMethods.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/features/data/models/drivers.dart';
import 'package:driver/features/presentation/pages/map_driver/available_deliver.dart';
import 'package:driver/features/presentation/pages/map_driver/widgets/map_drawer.dart';
import 'package:driver/features/presentation/pages/map_driver/widgets/map_panel_widget.dart';
import 'package:driver/features/presentation/widgets/location_granted_widget.dart';
import 'package:driver/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils/config.dart';
import '../../../../../common/utils/signal_r_config.dart';
import '../../../../../features/presentation/pages/sgin_up/registeration_screen.dart';
import '../../../../common/config/theme/colors.dart';
import 'widgets/map_app_bar.dart';

late BuildContext context;

class MapDriverScreen extends StatefulWidget {
  static const String idScreen = "mapDelivery";

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  const MapDriverScreen({Key? key}) : super(key: key);

  @override
  State<MapDriverScreen> createState() => _MapDriverScreenState();
}

class _MapDriverScreenState extends State<MapDriverScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  dispose() {
    super.dispose();
    newGoogleMapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: MapDrawer(
          onClose: () {
            Navigator.of(_key.currentState!.context).pop();
          },
        ),
        body: Column(
          children: [
            MapAppBarWidget(
              title: 'تطبيق السائق ',
              onChanged: (value) async {
                if (value) {
                  BotToast.showLoading();
                  await SignalRDriver().openConnection();
                  await makeDriverOnlineNow();
                  BotToast.closeAllLoading();
                  getLocationLiveUpdates();
                  displayToastMessage("تم الاتصال ", context);
                } else {
                  await SignalRDriver().stopConnection();
                  displayToastMessage("تم قطع الاتصال", context);
                }
              },
              onPressed: () {
                _key.currentState!.openDrawer();
              },
            ),

            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    padding: const EdgeInsets.only(top: 30),
                    buildingsEnabled: true,
                    myLocationEnabled: false,
                    markers: _markers.values.toSet(),
                    initialCameraPosition: MapDriverScreen._kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controllerGoogleMap.complete(controller);
                      newGoogleMapController = controller;
                      locatePosition();
                    },
                  ),
                  // Animarker(
                  //     curve: Curves.linear,
                  //     useRotation: true,
                  //     shouldAnimateCamera: false,
                  //     angleThreshold: 0,
                  //     zoom: 20,
                  //     rippleColor: kPRIMARY,
                  //     rippleRadius: 0.8,
                  //     markers: _markers.values.toSet(),
                  //     mapId: _controllerGoogleMap.future
                  //         .then<int>((value) => value.mapId),
                  //     child: GoogleMap(
                  //       mapType: MapType.normal,
                  //       padding: const EdgeInsets.only(top: 30),
                  //       buildingsEnabled: true,
                  //       myLocationEnabled: false,
                  //       // markers: _markers.values.toSet(),
                  //       initialCameraPosition: MapDriverScreen._kGooglePlex,
                  //       onMapCreated: (GoogleMapController controller) {
                  //         _controllerGoogleMap.complete(controller);
                  //         newGoogleMapController = controller;
                  //         locatePosition();
                  //       },
                  //  )),
                  const MapPanelWidget(),
                ],
              ),
            ),
            // online offline driver Container
          ],
        ));
  }

  // void getRideType() {
  //   driversRef
  //       .child(currentfirebaseUser!.uid)
  //       .child("car_details")
  //       .child("type")
  //       .once()
  //       .then((s) {
  //     DataSnapshot snapshot = s.snapshot;
  //     if (snapshot.value != null) {
  //       setState(() => rideType = snapshot.value.toString());
  //     }
  //   });
  // }

  // void getRatings() {
  //   //update ratings
  //   driversRef
  //       .child(currentfirebaseUser!.uid)
  //       .child("ratings")
  //       .once()
  //       .then((s) {
  //     DataSnapshot dataSnapshot = s.snapshot;

  //     if (dataSnapshot.value != null) {
  //       double ratings = double.parse(dataSnapshot.value.toString());
  //       setState(() => starCounter = ratings);

  //       if (starCounter <= 1.5) {
  //         setState(() => title = "Very Bad");
  //         return;
  //       }
  //       if (starCounter <= 2.5) {
  //         setState(() => title = "Bad");

  //         return;
  //       }
  //       if (starCounter <= 3.5) {
  //         setState(() => title = "Good");

  //         return;
  //       }
  //       if (starCounter <= 4.5) {
  //         setState(() => title = "Very Good");
  //         return;
  //       }
  //       if (starCounter <= 5.0) {
  //         setState(() => title = "Excellent");

  //         return;
  //       }
  //     }
  //   });
  // }

  void locatePosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // currentPosition = position;

    // final permission = await Location.instance. serviceEnabled();
    // LocationData position = await Location.instance.getLocation();

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(
      target: latLatPosition,
      zoom: 19,
      bearing: position.heading,
    );
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(
      cameraPosition,
    ));
    final markerConfig = kDriverMarker(latLatPosition);
    final Marker marker = await _marker(
      markerId: markerConfig.markerId,
      pinPath: markerConfig.pinPath,
      point: markerConfig.point,
      title: markerConfig.title,
      snippet: markerConfig.snippet,
    );
    setState(() {
      _markers[markerConfig.markerId] = marker;
    });
  }

  Future<void> makeDriverOnlineNow() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await SignalRDriver().sendLocation(
      point: LatLng(position.latitude, position.longitude),
      angel: position.heading,
    );
    await SignalRDriver().sendLocationProduct(
      point: LatLng(position.latitude, position.longitude),
      angel: position.heading,
    );
  }

  Future<void> getLocationLiveUpdates() async {
    Geolocator.getPositionStream().listen((Position currentLocation) async {
      if (SignalRDriver.connectionIsOpen == true) {
        print(
            "latlang:${LatLng(currentLocation.latitude, currentLocation.longitude)}");

        await SignalRDriver().sendLocation(
            point: LatLng(currentLocation.latitude, currentLocation.longitude),
            angel: currentLocation.heading);

        await SignalRDriver().sendLocationProduct(
            point: LatLng(
              currentLocation.latitude,
              currentLocation.longitude,
            ),
            angel: currentLocation.heading);
        LatLng latLng =
            LatLng(currentLocation.latitude, currentLocation.longitude);
        CameraPosition cameraPosition = CameraPosition(
          target: latLng,
          bearing: currentLocation.heading,
          zoom: 18,
        );
        newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(
          cameraPosition,
        ));
        final markerConfig = kDriverMarker(latLng);
        final Marker marker = await _marker(
          markerId: markerConfig.markerId,
          pinPath: markerConfig.pinPath,
          point: markerConfig.point,
          title: markerConfig.title,
          snippet: markerConfig.snippet,
        );
        setState(() {
          _markers[markerConfig.markerId] = marker;
        });
      }
    });
  }

  Future<Marker> _marker(
      {required MarkerId markerId,
      required LatLng point,
      required String pinPath,
      required String title,
      required String snippet}) async {
    return RippleMarker(
      ripple: true,
      //Ripple state

      icon: await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        pinPath,
      ),
      // icon: BitmapDescriptor.defaultMarker,
      markerId: markerId,
      position: point,
      infoWindow: InfoWindow(title: title, snippet: snippet),
    );
  }
}
