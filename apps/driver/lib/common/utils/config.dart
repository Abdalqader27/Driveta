import 'package:driver/generated/assets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../features/data/models/marker_config.dart';

// final kPolylineConfig = PolyLineConfig(
//   polylineId: const PolylineId("poly"),
//   travelMode: TravelMode.driving,
//   capEnd: Cap.roundCap,
//   capStart: Cap.roundCap,
//   width: 5,
//   color: kPRIMARY,
// );

const kDriverMarkerId = MarkerId('Driver');
const kCurrentMarkerId = MarkerId('Current');
const kDestinationMarkerId = MarkerId('Destination');

MarkerConfig kCurrentMarker(LatLng point) => MarkerConfig(
      point: point,
      pinPath: Assets.pinsPinUser,
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
      pinPath: Assets.iconsCarTop,
      markerId: kDriverMarkerId,
      snippet: 'السائق ',
      title: 'مكان السائق',
    );
MarkerConfig kDriverMotorMarker(LatLng point) => MarkerConfig(
      point: point,
      pinPath: Assets.imagesMotoTop,
      markerId: kDriverMarkerId,
      snippet: 'السائق ',
      title: 'مكان السائق',
    );
