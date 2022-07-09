import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

import '../../features/data/models/map_state.dart';
import '../../features/data/models/trip_data.dart';
import 'stream_sink_interface.dart';

class RxMap with RxMapSink, RxMapStream {
  late final BehaviorSubject<Map<MarkerId, Marker>> _markerList;
  late final BehaviorSubject<Map<PolylineId, Polyline>> _polylineList;
  late final BehaviorSubject<TripData> _tripData;
  late final BehaviorSubject<MapState> _mapState;

  RxMap() {
    _markerList = BehaviorSubject<Map<MarkerId, Marker>>();
    _polylineList = BehaviorSubject<Map<PolylineId, Polyline>>();
    _tripData = BehaviorSubject<TripData>();
    _mapState = BehaviorSubject<MapState>();
  }

  void dispose() {
    _markerList.close();
    _polylineList.close();
    _tripData.close();
    _mapState.close();
  }

  @override
  Stream<TripData> get streamTripData => _tripData.stream;

  @override
  Stream<Map<MarkerId, Marker>> get streamMarker => _markerList.stream;

  @override
  Stream<Map<PolylineId, Polyline>> get streamPolyline => _polylineList.stream;

  @override
  Stream<MapState> get rxMapState => _mapState.stream;

  @override
  // Section Set  -----------------------------------------------------------------------------------------------------------

  @override
  Function(TripData) get sinkSetLocationData => _tripData.sink.add;

  @override
  Function(MapState) get sinkSetMapState => _mapState.sink.add;

  @override
  Function(Map<MarkerId, Marker>) get sinkSetMarkerList => _markerList.sink.add;

  @override
  Function(Map<PolylineId, Polyline>) get sinkSetPolylineList =>
      _polylineList.sink.add;
}
