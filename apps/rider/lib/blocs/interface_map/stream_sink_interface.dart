import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../features/data/models/trip_data.dart';

mixin RxMapStream {
  Stream<Map<MarkerId, Marker>> get streamMarker;

  Stream<Map<PolylineId, Polyline>> get streamPolyline;

  Stream<TripData> get streamTripData;
}

mixin RxMapSink {
  Function(Map<PolylineId, Polyline>) get sinkSetPolylineList;

  Function(Map<MarkerId, Marker>) get sinkSetMarkerList;

  Function(TripData) get sinkSetLocationData;
}
