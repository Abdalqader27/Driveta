import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerConfig {
  final MarkerId markerId;
  final String? pinPath;
  final LatLng point;
  final String title;
  final String snippet;

  MarkerConfig({required this.markerId, this.pinPath, required this.point, required this.title, required this.snippet});
}
