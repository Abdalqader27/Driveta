import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../features/data/models/marker_config.dart';
import '../../features/data/models/polyline_config.dart';
import '../../features/data/models/trip_data.dart';

abstract class MapInterface {
  Future<void> setTripData(TripData tripData);

  Future<bool> setPolyline(
      TripData locationData, PolyLineConfig polylineConfig);

  Future<void> setMapFitToTour(Set<Polyline> p);

  Future<void> deleteMarker(MarkerId markerId);

  Future<void> clearMarkers();

  Future<void> setMarker(MarkerConfig markerConfig);

  Future<void> clearPolyline();
}
