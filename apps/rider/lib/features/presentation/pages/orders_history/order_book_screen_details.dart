import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rider/features/presentation/pages/orders_history/widget/chip_item.dart';
import 'package:rider/features/presentation/pages/orders_history/widget/header_item.dart';

import '../../../../common/config/theme/colors.dart';
import '../../../../common/widgets/round_app_bar.dart';
import '../../../../generated/assets.dart';
import '../../../data/models/delivers.dart';

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
  final List<LatLng> polylineCoordinates = [];

  @override
  Widget build(BuildContext context) {
    print("StartLat ${widget.delivers.startLat}");
    print("StartLong ${widget.delivers.startLong}");
    print("EndLat ${widget.delivers.endLat}");
    print("EndLong ${widget.delivers.endLat}");
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            RoundedAppBar(
              title: 'الرحلة رقم',
              subTitle: widget.delivers.id,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: RichText(
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        text: TextSpan(
                          text: 'تاريخ الرحلة :',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      subtitle: Text(DateFormat('yyyy-MM-dd – hh:mm')
                          .format(DateTime.parse(widget.delivers.startDate))),
                      leading: const CircleAvatar(
                          child: Center(child: const Icon(Icons.date_range))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SPadding.all16(
                            child: SvgPicture.asset(
                              Assets.iconsIcRoute,
                              height: 80,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                HeaderItem(
                                    context: context,
                                    title: 'المكان الانطلاق',
                                    subtitle: widget.delivers.pickUp),
                                DottedLine(
                                  dashColor: Colors.grey.withOpacity(.5),
                                ),
                                HeaderItem(
                                    context: context,
                                    title: ' الوجهة',
                                    subtitle: '${widget.delivers.dropOff} '),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      children: [
                        // TODO add time and distance and money
                        ChipItem(
                          iconData: Icons.access_time,
                          title: '${widget.delivers.expectedTime}',
                        ),
                        ChipItem(
                          iconData: Icons.add_road_rounded,
                          title: '${widget.delivers.distance}',
                        ),
                        ChipItem(
                          iconData: Icons.account_balance_wallet_outlined,
                          title: '${widget.delivers.price}',
                        ),
                      ],
                    ),
                    const SSizedBox.v12(),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: SizedBox(
                        height: 330,
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

    _markers[const MarkerId('1')] = Marker(
      markerId: const MarkerId('1'),
      position: LatLng(double.tryParse(widget.delivers.startLat) ?? 0,
          double.tryParse(widget.delivers.startLong) ?? 0),
      infoWindow: InfoWindow(
        title: widget.delivers.pickUp,
        snippet: widget.delivers.pickUp,
      ),
    );
    _markers[const MarkerId('2')] = Marker(
      markerId: const MarkerId('2'),
      position: LatLng(double.tryParse(widget.delivers.endLat) ?? 0,
          double.tryParse(widget.delivers.endLong) ?? 0),
      infoWindow: InfoWindow(
        title: widget.delivers.dropOff,
        snippet: widget.delivers.dropOff,
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
