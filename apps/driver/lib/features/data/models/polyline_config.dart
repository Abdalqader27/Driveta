import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLineConfig {
  final Cap capEnd;
  final Cap capStart;
  final int width;
  final Color color;
  final TravelMode travelMode;
  final PolylineId polylineId;

  PolyLineConfig({
    required this.polylineId,
    required this.capEnd,
    required this.travelMode,
    required this.capStart,
    required this.width,
    required this.color,
  });
}
