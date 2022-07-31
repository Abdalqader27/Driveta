import 'package:flutter/material.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../../common/config/theme/colors.dart';

class MapProductContainer extends StatelessWidget {
  const MapProductContainer({
    Key? key,
    required this.markers,
    required this.polyLines,
    required this.locationData,
    this.padding,
    this.onMapCreated,
    required this.mapId,
  }) : super(key: key);
  final Set<Marker> markers;
  final Set<Polyline> polyLines;
  final LocationData locationData;
  final EdgeInsets? padding;
  final MapCreatedCallback? onMapCreated;
  final Future<int> mapId;

  @override
  @override
  Widget build(BuildContext context) {
    return Animarker(
        curve: Curves.linear,
        useRotation: true,
        shouldAnimateCamera: false,
        angleThreshold: 90,
        zoom: 20,
        rippleColor: kPRIMARY,
        rippleRadius: 0.8,
        markers: markers,
        mapId: mapId,
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          // markers: markers,
          polylines: polyLines,
          zoomGesturesEnabled: true,
          padding: padding ?? const EdgeInsets.all(0),
          onTap: (LatLng argument) {},
          onMapCreated: onMapCreated,
        ));
  }

  get initialCameraPosition => CameraPosition(
      target: LatLng(
        locationData.latitude ?? 0,
        locationData.longitude ?? 0,
      ),
      zoom: 20);
}
