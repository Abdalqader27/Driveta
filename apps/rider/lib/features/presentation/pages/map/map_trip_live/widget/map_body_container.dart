import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rider/features/presentation/pages/map/map_trip_live.dart';

import 'map_body.dart';

class MapBodyContainer extends StatelessWidget {
  MapBodyContainer({
    Key? key,
    required this.markers,
    required this.polyLines,
    required this.locationData,
    this.padding,
  }) : super(key: key);
  final Set<Marker> markers;
  final Set<Polyline> polyLines;
  final LocationData locationData;
  final EdgeInsets? padding;

  @override
  @override
  Widget build(BuildContext context) {
    return MapBody(
      initialCameraPosition: initialCameraPosition,
      markers: markers,
      polyLines: polyLines,
      zoomGesturesEnabled: true,
      padding: padding,
      onTap: (LatLng argument) {},
      onMapCreated: (GoogleMapController controller) {
        tripLiveMapController = controller;
      },
    );
  }

  get initialCameraPosition => CameraPosition(
      target: LatLng(
        locationData.latitude ?? 0,
        locationData.longitude ?? 0,
      ),
      zoom: 20);
}
