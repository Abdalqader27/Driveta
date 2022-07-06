import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Models/location_data.dart';
import '../../Models/marker_config.dart';
import '../../Models/polyline_config.dart';

abstract class MapInterface {
  Future<void> setTripData(TripData locationData);

  Future<bool> setPolyline(TripData locationData, PolyLineConfig polylineConfig);

  Future<void> setMapFitToTour(Set<Polyline> p);

  Future<void> deleteMarker(MarkerId markerId);

  Future<void> clearMarkers();

  Future<void> setMarker(MarkerConfig markerConfig);

  Future<void> clearPolyline();
}
