import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:driver/common/assistants/assistantMethods.dart';
import 'package:driver/common/config/theme/colors.dart';
import 'package:driver/features/data/models/delivers.dart';
import 'package:driver/features/presentation/widgets/CollectFareDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../common/utils/config.dart';
import '../common/utils/signal_r_config.dart';
import '../features/presentation/pages/history/widgets/header_item.dart';
import '../generated/assets.dart';

class NewRideScreen extends StatefulWidget {
  final Delivers rideDetails;
  final int type;
  const NewRideScreen({required this.rideDetails, this.type = 1});

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  _NewRideScreenState createState() => _NewRideScreenState();
}

class _NewRideScreenState extends State<NewRideScreen> {
  late GoogleMapController newRideGoogleMapController;
  final Map<MarkerId, Marker> _markers = {};
  Set<Circle> circleSet = <Circle>{};
  Set<Polyline> polyLineSet = <Polyline>{};
  double mapPaddingFromBottom = 0;
  var geoLocator = Geolocator();
  late BitmapDescriptor animatingMarkerIcon;
  late LocationData myPostion;
  String status = "accepted";
  String durationRide = "";
  bool isRequestingDirection = false;
  String btnTitle = "وصلت";
  Color btnColor = kPRIMARY;
  late Timer timer;
  int durationCounter = 0;
  final PolylinePoints polylinePoints = PolylinePoints();
  final Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};
  final List<LatLng> polylineCoordinates = [];

  void getRideLiveLocationUpdates() async {
    LatLng oldPos = const LatLng(0, 0);
    Stream<LocationData> stream = Location.instance.onLocationChanged;
    stream.listen((position) async {
      myPostion = position;
      LatLng mPostion = LatLng(position.latitude!, position.longitude!);
      final markerConfig = kDriverMarker(oldPos);
      final Marker marker = await _marker(
        markerId: markerConfig.markerId,
        pinPath: markerConfig.pinPath,
        point: markerConfig.point,
        title: markerConfig.title,
        snippet: markerConfig.snippet,
      );
      CameraPosition cameraPosition = CameraPosition(
          target: mPostion, zoom: 17, bearing: position.heading!);
      _markers[markerConfig.markerId] = marker;

      newRideGoogleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      oldPos = mPostion;
      updateRideDetails();
    });
  }

  Future<Marker> _marker(
      {required MarkerId markerId,
      required LatLng point,
      required String pinPath,
      required String title,
      required String snippet}) async {
    return Marker(
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(200, 200)), pinPath),
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
              newRideGoogleMapController = controller;
              setState(() => mapPaddingFromBottom = 305.0);

              var location = await Location.instance.getLocation();
              var currentLatLng =
                  LatLng((location).latitude!, (location).longitude!);
              print("currentLatLng: $currentLatLng");
              var pickUpLatLng = LatLng(
                double.parse(widget.rideDetails.startLat??'0'),
                double.parse(widget.rideDetails.startLong??'0'),
              );
              print("pickUpLatLng: $pickUpLatLng");

              await getPlaceDirection(currentLatLng, pickUpLatLng, false);

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
    ;
  }

  Widget buildRiderTripStatus(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      ),
      height: 310.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              durationRide,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: "Brand Bold",
                  color: Colors.deepPurple),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  Assets.iconsUser,
                  width: 50,
                ),
                Text(
                  widget.rideDetails.customerName??'',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
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
                    SPadding.all16(
                      child: SvgPicture.asset(
                        Assets.iconsIcRoute,
                        height: 80,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HeaderItem(
                          context: context,
                          title: 'المكان الحالي',
                          subtitle: widget.rideDetails.pickUp??''),
                      DottedLine(
                        dashColor: Colors.grey.withOpacity(.5),
                      ),
                      HeaderItem(
                        context: context,
                        title: ' الوجهة',
                        subtitle: widget.rideDetails.dropOff??'',
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
                borderRadius: BorderRadius.circular(30),
                onPressed: () async {
                  if (status == "accepted") {
                    BotToast.showLoading();
                    status = "ArrivedToUser";
                    setState(() {
                      btnTitle = "بدء الرحلة";
                      btnColor = Colors.green;
                    });

                    var pickup = LatLng(
                        double.parse(widget.rideDetails.startLat??'0'),
                        double.parse(widget.rideDetails.startLong??'0'));
                    var dropoff = LatLng(
                        double.parse(widget.rideDetails.endLat??'0'),
                        double.parse(widget.rideDetails.endLong??'0'));

                    await getPlaceDirection(pickup, dropoff, true);
                    if (widget.type == 1) {
                      await SignalRDriver()
                          .arrivedToLocation(id: widget.rideDetails.id??'');
                    } else if (widget.type == 2) {
                      await SignalRDriver()
                          .arrivedToLocationProduct(id: widget.rideDetails.id??'');
                    }

                    BotToast.closeAllLoading();
                  } else if (status == "ArrivedToUser") {
                    BotToast.showLoading();
                    if (widget.type == 1) {
                      await SignalRDriver()
                          .startDelivery(id: widget.rideDetails.id??'');
                    } else if (widget.type == 2) {
                      await SignalRDriver()
                          .startDeliveryProduct(id: widget.rideDetails.id??'');
                    }

                    // await si<DriverUseCase>().changeDeliveryStatue(
                    //     id: widget.rideDetails.id, statue: 'ArrivedToUser');
                    BotToast.closeAllLoading();
                    status = "StartTrip";
                    setState(() {
                      btnTitle = "انهااء الرحلة";
                      btnColor = Colors.redAccent;
                      flagOpenPage = false;
                    });
                  } else if (status == "StartTrip") {
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
                      const SSizedBox.h12(),
                      SText.titleMedium(
                        btnTitle,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SSizedBox.h12(),
                      const Icon(
                        Icons.directions_car,
                        color: Colors.white,
                        size: 26.0,
                      ),
                      const SSizedBox.h12(),
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

  Future<void> setMapFitToTour(
      Set<Polyline> p, GoogleMapController controller) async {
    double minLat = p.first.points.first.latitude;
    double minLong = p.first.points.first.longitude;
    double maxLat = p.first.points.first.latitude;
    double maxLong = p.first.points.first.longitude;

    for (Polyline poly in p) {
      for (var point in poly.points) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      }
    }

    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong)),
        100));
  }

  Future<void> getPlaceDirection(
      LatLng pickUpLatLng, LatLng dropOffLatLng, bool isArrived) async {
    BotToast.showLoading();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCeL6NXSWQJcyl0SjF3CZ0-3vN3q90aGc8",
      PointLatLng(
        pickUpLatLng.latitude,
        pickUpLatLng.longitude,
      ),
      PointLatLng(
        dropOffLatLng.latitude,
        dropOffLatLng.longitude,
      ),
      travelMode: TravelMode.driving,
    );

    BotToast.closeAllLoading();

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    polyLineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: kPRIMARY,
        polylineId: const PolylineId("PolylineID"),
        jointType: JointType.round,
        points: polylineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polyLineSet.add(polyline);
    });

    await setMapFitToTour(polyLineSet, newRideGoogleMapController);

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

  void updateRideDetails() async {
    if (isRequestingDirection == false) {
      isRequestingDirection = true;

      if (myPostion == null) {
        return;
      }

      var posLatLng = LatLng(myPostion.latitude!, myPostion.longitude!);
      LatLng destinationLatLng;

      if (status == "accepted") {
        destinationLatLng = LatLng(double.parse(widget.rideDetails.startLat??'0'),
            double.parse(widget.rideDetails.startLong??'0'));
      } else {
        destinationLatLng = LatLng(double.parse(widget.rideDetails.endLat??'0'),
            double.parse(widget.rideDetails.endLong??'0'));
      }

      var directionDetails = await AssistantMethods.obtainPlaceDirectionDetails(
          posLatLng, destinationLatLng);
      if (directionDetails != null) {
        setState(() {
          durationRide = directionDetails.durationText!;
        });
      }

      isRequestingDirection = false;
    }
  }

  endTheTrip() async {
    BotToast.showLoading();

    var currentLatLng = LatLng(myPostion.latitude!, myPostion.longitude!);

    var directionalDetails = await AssistantMethods.obtainPlaceDirectionDetails(
        LatLng(double.parse(widget.rideDetails.startLat??'0'),
            double.parse(widget.rideDetails.startLong??'0')),
        currentLatLng);

    int fareAmount = AssistantMethods.calculateFares(directionalDetails!);
    if (widget.type == 1) {
      await SignalRDriver().endDeliveryDriver(
        id: widget.rideDetails.id??'',
        price: fareAmount,
        endLat: currentLatLng.latitude.toString(),
        endLong: currentLatLng.longitude.toString(),
        dropOff: widget.rideDetails.dropOff??'',
        expectedTime: directionalDetails.durationValue.toString(),
        distance: directionalDetails.distanceValue ?? 0,
      );
    } else if (widget.type == 2) {
      await SignalRDriver().endDeliveryDriverProduct(
        id: widget.rideDetails.id??'',
        price: fareAmount,
        endLat: currentLatLng.latitude.toString(),
        endLong: currentLatLng.longitude.toString(),
        dropOff: widget.rideDetails.dropOff??'',
        expectedTime: directionalDetails.durationValue.toString(),
        distance: directionalDetails.distanceValue ?? 0,
      );
    }

    BotToast.closeAllLoading();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CollectFareDialog(
        paymentMethod: 'Cash',
        fareAmount: fareAmount,
      ),
    );
  }
}
