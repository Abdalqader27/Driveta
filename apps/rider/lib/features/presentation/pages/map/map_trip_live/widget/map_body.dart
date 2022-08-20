import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBody extends StatelessWidget {
  final bool indoorViewEnabled;
  final bool compassEnabled;
  final bool trafficEnabled;
  final bool myLocationEnabled;
  final bool rotateGesturesEnabled;
  final bool tiltGesturesEnabled;
  final bool zoomControlsEnabled;
  final bool zoomGesturesEnabled;
  final bool myLocationButtonEnabled;
  final bool mapToolbarEnabled;
  final EdgeInsets? padding;
  final Set<Marker> markers;
  final Set<Polyline> polyLines;
  final CameraPositionCallback? onCameraMove;
  final VoidCallback? onCameraIdle;
  final CameraPosition initialCameraPosition;
  final MapCreatedCallback? onMapCreated;
  final ArgumentCallback<LatLng>? onTap;

  const MapBody(
      {Key? key,
      this.indoorViewEnabled = false,
      this.compassEnabled = true,
      this.trafficEnabled = false,
      this.myLocationEnabled = true,
      this.rotateGesturesEnabled = true,
      this.tiltGesturesEnabled = false,
      this.zoomControlsEnabled = true,
      this.zoomGesturesEnabled = true,
      this.myLocationButtonEnabled = false,
      this.mapToolbarEnabled = false,
      this.padding,
      required this.markers,
      required this.polyLines,
      this.onCameraMove,
      this.onCameraIdle,
      required this.initialCameraPosition,
      required this.onMapCreated,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: onMapCreated,
      onCameraMove: onCameraMove,
      onCameraIdle: onCameraIdle,
      initialCameraPosition: initialCameraPosition,
      indoorViewEnabled: indoorViewEnabled,
      compassEnabled: compassEnabled,
      trafficEnabled: trafficEnabled,
      myLocationEnabled: myLocationEnabled,
      rotateGesturesEnabled: rotateGesturesEnabled,
      tiltGesturesEnabled: tiltGesturesEnabled,
      zoomControlsEnabled: zoomControlsEnabled,
      zoomGesturesEnabled: zoomGesturesEnabled,
      myLocationButtonEnabled: myLocationButtonEnabled,
      mapToolbarEnabled: mapToolbarEnabled,
      onTap: onTap,
      markers: markers,
      polylines: polyLines,
      padding: padding ?? EdgeInsets.zero,
    );
  }
}
