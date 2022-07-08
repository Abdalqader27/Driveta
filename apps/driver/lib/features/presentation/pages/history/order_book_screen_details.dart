import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';
import 'package:driver/features/data/models/delivers.dart';
import 'package:driver/features/presentation/pages/history/widgets/order_book_item.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../common/config/theme/colors.dart';
import '../../widgets/round_app_bar.dart';

late GoogleMapController controllerdetails;

class OrderBookScreenDetails extends StatefulWidget {
  final Delivers delivers;
  const OrderBookScreenDetails({Key? key, required this.delivers})
      : super(key: key);

  @override
  State<OrderBookScreenDetails> createState() => _OrderBookScreenDetailsState();
}

class _OrderBookScreenDetailsState extends State<OrderBookScreenDetails> {
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Circle> circleSet = <Circle>{};
  Set<Polyline> polyLineSet = <Polyline>{};
  final PolylinePoints polylinePoints = PolylinePoints();
  final Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};
  final List<LatLng> polylineCoordinates = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            RoundedAppBar(
              title: 'الرحلة رقم',
              subTitle: '${widget.delivers.id}',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    OrderBookItem(
                      index: 0,
                      history: widget.delivers,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        text: ' معلومات حول :',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                            text: 'الخريطة',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: SizedBox(
                        height: 380,
                        child: Stack(
                          children: [
                            GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              circles: circleSet,
                              polylines: polyLineSet,
                              padding: const EdgeInsets.only(top: 30),
                              markers: _markers.values.toSet(),
                              onMapCreated: (GoogleMapController controller) {
                                controllerdetails = controller;
                                getPlaceDirection(
                                    LatLng(
                                      double.tryParse(
                                              widget.delivers.startLat) ??
                                          0,
                                      double.tryParse(
                                              widget.delivers.startLong) ??
                                          0,
                                    ),
                                    LatLng(
                                        double.tryParse(
                                                widget.delivers.endLat) ??
                                            0,
                                        double.tryParse(
                                                widget.delivers.endLong) ??
                                            0),
                                    false);
                              },
                            ),
                            Container(
                              color: kPRIMARY.withOpacity(.2),
                              height: 380,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
        60));
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

    await setMapFitToTour(polyLineSet, controllerdetails);

    _markers[MarkerId('1')] = Marker(
      markerId: MarkerId('1'),
      position: LatLng(double.tryParse(widget.delivers.startLat) ?? 0,
          double.tryParse(widget.delivers.startLong) ?? 0),
      infoWindow: InfoWindow(
        title: '${widget.delivers.pickUp}',
        snippet: '${widget.delivers.pickUp}',
      ),
    );
    _markers[MarkerId('2')] = Marker(
      markerId: MarkerId('2'),
      position: LatLng(double.tryParse(widget.delivers.endLat) ?? 0,
          double.tryParse(widget.delivers.endLong) ?? 0),
      infoWindow: InfoWindow(
        title: '${widget.delivers.dropOff}',
        snippet: '${widget.delivers.dropOff}',
      ),
    );

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
}
