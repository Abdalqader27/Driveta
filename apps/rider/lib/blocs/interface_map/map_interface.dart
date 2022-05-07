import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Models/driver_data.dart';
import '../../Models/location_data.dart';
import '../../Models/marker_config.dart';
import '../../Models/polyline_config.dart';
import '../../Models/suggestion.dart';

abstract class MapInterface {
  Future<void> setLocationData(PinData locationData);

  Future<void> setDriverData(DriverData driverData);

  Future<bool> setPolyline(PinData locationData, PolyLineConfig polylineConfig);

  Future<void> setMapFitToTour(Set<Polyline> p);

  Future<void> deleteMarker(MarkerId markerId);
  Future<void> clearMarkers();

  Future<void> setMarker(MarkerConfig markerConfig);

  Future<void> clearPolyline();

  Future<bool> setQuerySuggestion(String suggestion);
  Stream<List<Suggestion>> getSuggestion();
}
