import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/features/presentation/pages/map/main_screen/mainscreen.dart';

void goToLocation(LatLng point) {
  newGoogleMapController.animateCamera(
    CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 18, bearing: 0, tilt: 0)),
  );
}
