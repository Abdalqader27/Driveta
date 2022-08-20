import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../features/data/models/marker_config.dart';
import '../../features/data/models/polyline_config.dart';
import '../../generated/assets.dart';
import '../config/theme/colors.dart';

final kPolylineConfigWalk = PolyLineConfig(
  polylineId: const PolylineId("poly"),
  travelMode: TravelMode.walking,
  capEnd: Cap.roundCap,
  capStart: Cap.roundCap,
  width: 5,
  color: kPRIMARY,
);
final kPolylineConfigDriver = PolyLineConfig(
  polylineId: const PolylineId("poly"),
  travelMode: TravelMode.driving,
  capEnd: Cap.roundCap,
  capStart: Cap.roundCap,
  width: 5,
  color: kPRIMARY,
);
const kDriverMarkerId = MarkerId('Driver');
const kCurrentMarkerId = MarkerId('Current');
const kDestinationMarkerId = MarkerId('Destination');

MarkerConfig kCurrentMarker(LatLng point) => MarkerConfig(
      point: point,
      pinPath: 'assets/images/pin_user.png',
      markerId: kCurrentMarkerId,
      snippet: 'المكان الحالي',
      title: 'أنا',
    );

MarkerConfig kDestinationMarker(LatLng point) => MarkerConfig(
      point: point,
      pinPath: Assets.pinsDestinationMapMarker,
      markerId: kDestinationMarkerId,
      snippet: 'الوجهة',
      title: 'المكان المستهدف',
    );

MarkerConfig kDriverMarker(LatLng point) => MarkerConfig(
      point: point,
      pinPath: Assets.pinsDrivingPin,
      markerId: kDriverMarkerId,
      snippet: 'السائق ',
      title: 'مكان السائق',
    );
MarkerConfig kDriverMarker2(LatLng point) => MarkerConfig(
      point: point,
      pinPath: Assets.iconsCarTop,
      markerId: kDriverMarkerId,
      snippet: 'السائق ',
      title: 'مكان السائق',
    );
MarkerConfig kDriverMarkerBike(LatLng point) => MarkerConfig(
      point: point,
      pinPath: 'assets/images/moto_top.png',
      markerId: kDriverMarkerId,
      snippet: 'السائق ',
      title: 'مكان السائق',
    );
