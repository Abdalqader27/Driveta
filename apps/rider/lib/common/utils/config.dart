import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Models/marker_config.dart';
import '../../Models/polyline_config.dart';
import '../../generated/assets.dart';
import '../../libraries/el_theme/colors.dart';

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
      // pinPath: Assets.iconsCarTop,
      markerId: kCurrentMarkerId,
      snippet: 'المكان الحالي',
      title: 'أنا',
    );

MarkerConfig kDestinationMarker(LatLng point) => MarkerConfig(
      point: point,
      // pinPath: Assets.pinsDestinationMapMarker,
      markerId: kDestinationMarkerId,
      snippet: 'الوجهة',
      title: 'المكان المستهدف',
    );

MarkerConfig kDriverMarker(LatLng point) => MarkerConfig(
      point: point,
      pinPath: Assets.iconsCarTop,
      markerId: kDriverMarkerId,
      snippet: 'السائق ',
      title: 'مكان السائق',
    );
