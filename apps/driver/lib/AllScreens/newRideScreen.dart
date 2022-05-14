import 'dart:async';

import 'package:dotted_line/dotted_line.dart';
import 'package:driver/AllWidgets/CollectFareDialog.dart';
import 'package:driver/Assistants/assistantMethods.dart';
import 'package:driver/Models/rideDetails.dart';
import 'package:driver/common/config/theme/colors.dart';
import 'package:driver/common/widgets/progress_dialog.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/libraries/el_widgets/widgets/material_text.dart';
import 'package:driver/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:driver/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../common/utils/config.dart';
import '../features/map_driver/presentation/pages/order_book/widgets/header_item.dart';
import '../generated/assets.dart';
import '../libraries/el_widgets/widgets/responsive_padding.dart';
import '../libraries/el_widgets/widgets/responsive_sized_box.dart';

class NewRideScreen extends StatefulWidget {
  final RideDetails rideDetails;

  const NewRideScreen({required this.rideDetails});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _NewRideScreenState createState() => _NewRideScreenState();
}

class _NewRideScreenState extends State<NewRideScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newRideGoogleMapController;
  final Map<MarkerId, Marker> _markers = {};
  Set<Circle> circleSet = Set<Circle>();
  Set<Polyline> polyLineSet = Set<Polyline>();
  List<LatLng> polylineCorOrdinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  double mapPaddingFromBottom = 0;
  var geoLocator = Geolocator();
  late BitmapDescriptor animatingMarkerIcon;
  late Position myPostion;
  String status = "accepted";
  String durationRide = "";
  bool isRequestingDirection = false;
  String btnTitle = "وصلت";
  Color btnColor = kPRIMARY;
  late Timer timer;
  int durationCounter = 0;

  @override
  void initState() {
    super.initState();
    acceptRideRequest();
  }

  void getRideLiveLocationUpdates() async {
    LatLng oldPos = const LatLng(0, 0);

    rideStreamSubscription = Geolocator.getPositionStream().listen((Position position) async {
      currentPosition = position;
      myPostion = position;
      LatLng mPostion = LatLng(position.latitude, position.longitude);

      // var rot =
      //     MapKitAssistant.getMarkerRotation(oldPos.latitude, oldPos.longitude, myPostion.latitude, myPostion.latitude);
      final markerConfig = kDriverMarker(oldPos);

      final Marker marker = await _marker(
        markerId: markerConfig.markerId,
        pinPath: markerConfig.pinPath,
        point: markerConfig.point,
        title: markerConfig.title,
        snippet: markerConfig.snippet,
      );
      setState(() {
        CameraPosition cameraPosition = CameraPosition(target: mPostion, zoom: 17, bearing: position.heading);

        _markers[markerConfig.markerId] = marker;
        newRideGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      });
      oldPos = mPostion;
      updateRideDetails();

      String? rideRequestId = widget.rideDetails.ride_request_id;
      Map locMap = {
        "latitude": currentPosition.latitude.toString(),
        "longitude": currentPosition.longitude.toString(),
      };
      newRequestsRef.child(rideRequestId!).child("driver_location").set(locMap);
    });
  }

  Future<Marker> _marker(
      {required MarkerId markerId,
      required LatLng point,
      required String pinPath,
      required String title,
      required String snippet}) async {
    return Marker(
      icon: await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(200, 200)), pinPath),
      // icon: BitmapDescriptor.defaultMarker,
      markerId: markerId,
      position: point,
      infoWindow: InfoWindow(title: title, snippet: snippet),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapPaddingFromBottom),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: NewRideScreen._kGooglePlex,
            myLocationEnabled: true,
            markers: Set.of(_markers.values),
            circles: circleSet,
            polylines: polyLineSet,
            onMapCreated: (GoogleMapController controller) async {
              _controllerGoogleMap.complete(controller);
              newRideGoogleMapController = controller;

              setState(() {
                mapPaddingFromBottom = 305.0;
              });

              var currentLatLng = LatLng(currentPosition.latitude, currentPosition.longitude);
              var pickUpLatLng = widget.rideDetails.pickup;

              await getPlaceDirection(currentLatLng, pickUpLatLng!, false);

              getRideLiveLocationUpdates();
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: buildRiderTripStatus(context),
          ),
        ],
      ),
    );
  }

  Widget buildRiderTripStatus(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      ),
      height: 310.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              durationRide,
              style: const TextStyle(fontSize: 14.0, fontFamily: "Brand Bold", color: Colors.deepPurple),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  Assets.iconsUser,
                  width: 50,
                ),
                Text(
                  widget.rideDetails.rider_name ?? '',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.phone_android),
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    RPadding.all16(
                      child: SvgPicture.asset(
                        Assets.iconsIcRoute,
                        height: 80.r,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HeaderItem(
                          context: context, title: 'المكان الحالي', subtitle: widget.rideDetails.rider_name ?? ''),
                      DottedLine(
                        dashColor: Colors.grey.withOpacity(.5),
                      ),
                      HeaderItem(
                        context: context,
                        title: ' الوجهة',
                        subtitle: widget.rideDetails.pickup_address ?? '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(30.r),
                onPressed: () async {
                  if (status == "accepted") {
                    status = "arrived";
                    String? rideRequestId = widget.rideDetails.ride_request_id;
                    newRequestsRef.child(rideRequestId!).child("status").set(status);

                    setState(() {
                      btnTitle = "بدء الرحلة";
                      btnColor = Colors.green;
                    });

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => const ProgressDialog(
                        message: "الرجاء الانتظار",
                      ),
                    );

                    await getPlaceDirection(widget.rideDetails.pickup!, widget.rideDetails.dropoff!, true);

                    Navigator.pop(context);
                  } else if (status == "arrived") {
                    status = "onride";
                    String? rideRequestId = widget.rideDetails.ride_request_id;
                    newRequestsRef.child(rideRequestId!).child("status").set(status);

                    setState(() {
                      btnTitle = "انهااء الرحلة";
                      btnColor = Colors.redAccent;
                    });

                    initTimer();
                  } else if (status == "onride") {
                    endTheTrip();
                  }
                },
                color: btnColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RSizedBox.h12(),
                      MaterialText.button(
                        btnTitle,
                        style: const TextStyle(color: Colors.white),
                      ),
                      RSizedBox.h12(),
                      const Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: 26.0,
                      ),
                      RSizedBox.h12(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getPlaceDirection(LatLng pickUpLatLng, LatLng dropOffLatLng, bool isArrived) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => const ProgressDialog(
              message: "Please wait...",
            ));

    var details = await AssistantMethods.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng);

    Navigator.pop(context);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult = polylinePoints.decodePolyline(details!.encodedPoints!);

    polylineCorOrdinates.clear();

    if (decodedPolyLinePointsResult.isNotEmpty) {
      for (var pointLatLng in decodedPolyLinePointsResult) {
        polylineCorOrdinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      }
    }

    polyLineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: kPRIMARY,
        polylineId: const PolylineId("PolylineID"),
        jointType: JointType.round,
        points: polylineCorOrdinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polyLineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if (pickUpLatLng.latitude > dropOffLatLng.latitude && pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds = LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    newRideGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
      position: pickUpLatLng,
      markerId: const MarkerId("pickUpId"),
    );

    Marker dropOffLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: dropOffLatLng,
      markerId: const MarkerId("dropOffId"),
    );

    setState(() {
      if (isArrived) {
        _markers[const MarkerId("pickUpId")] = pickUpLocMarker;
      }
      _markers[const MarkerId("dropOffId")] = dropOffLocMarker;
    });

    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: pickUpLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blueAccent,
      circleId: const CircleId("pickUpId"),
    );

    Circle dropOffLocCircle = Circle(
      fillColor: Colors.deepPurple,
      center: dropOffLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepPurple,
      circleId: const CircleId("dropOffId"),
    );

    setState(() {
      circleSet.add(pickUpLocCircle);
      circleSet.add(dropOffLocCircle);
    });
  }

  void acceptRideRequest() {
    String? rideRequestId = widget.rideDetails.ride_request_id;
    newRequestsRef.child(rideRequestId!).child("status").set("accepted");
    newRequestsRef.child(rideRequestId).child("driver_name").set(driversInformation.name);
    newRequestsRef.child(rideRequestId).child("driver_phone").set(driversInformation.phone);
    newRequestsRef.child(rideRequestId).child("driver_id").set(driversInformation.id);
    newRequestsRef
        .child(rideRequestId)
        .child("car_details")
        .set('${driversInformation.car_color} - ${driversInformation.car_model}');

    Map locMap = {
      "latitude": currentPosition.latitude.toString(),
      "longitude": currentPosition.longitude.toString(),
    };
    newRequestsRef.child(rideRequestId).child("driver_location").set(locMap);

    driversRef.child(currentfirebaseUser!.uid).child("history").child(rideRequestId).set(true);
  }

  void updateRideDetails() async {
    if (isRequestingDirection == false) {
      isRequestingDirection = true;

      if (myPostion == null) {
        return;
      }

      var posLatLng = LatLng(myPostion.latitude, myPostion.longitude);
      LatLng destinationLatLng;

      if (status == "accepted") {
        destinationLatLng = widget.rideDetails.pickup!;
      } else {
        destinationLatLng = widget.rideDetails.dropoff!;
      }

      var directionDetails = await AssistantMethods.obtainPlaceDirectionDetails(posLatLng, destinationLatLng);
      if (directionDetails != null) {
        setState(() {
          durationRide = directionDetails.durationText!;
        });
      }

      isRequestingDirection = false;
    }
  }

  void initTimer() {
    const interval = Duration(seconds: 1);
    timer = Timer.periodic(interval, (timer) {
      durationCounter = durationCounter + 1;
    });
  }

  endTheTrip() async {
    timer.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const ProgressDialog(
        message: "Please wait...",
      ),
    );

    var currentLatLng = LatLng(myPostion.latitude, myPostion.longitude);

    var directionalDetails =
        await AssistantMethods.obtainPlaceDirectionDetails(widget.rideDetails.pickup!, currentLatLng);

    Navigator.pop(context);

    int fareAmount = AssistantMethods.calculateFares(directionalDetails!);

    String? rideRequestId = widget.rideDetails.ride_request_id;
    newRequestsRef.child(rideRequestId!).child("fares").set(fareAmount.toString());
    newRequestsRef.child(rideRequestId).child("status").set("ended");
    rideStreamSubscription.cancel();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CollectFareDialog(
        paymentMethod: widget.rideDetails.payment_method!,
        fareAmount: fareAmount,
      ),
    );

    saveEarnings(fareAmount);
  }

  void saveEarnings(int fareAmount) {
    driversRef.child(currentfirebaseUser!.uid).child("earnings").once().then((s) {
      DataSnapshot dataSnapShot = s.snapshot;

      if (dataSnapShot.value != null) {
        double oldEarnings = double.parse(dataSnapShot.value.toString());
        double totalEarnings = fareAmount + oldEarnings;

        driversRef.child(currentfirebaseUser!.uid).child("earnings").set(totalEarnings.toStringAsFixed(2));
      } else {
        double totalEarnings = fareAmount.toDouble();
        driversRef.child(currentfirebaseUser!.uid).child("earnings").set(totalEarnings.toStringAsFixed(2));
      }
    });
  }
}
