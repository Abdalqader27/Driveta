import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

import '../../Models/driver_data.dart';
import '../../Models/location_data.dart';
import '../../Models/map_state.dart';
import '../../Models/payment.dart';
import '../../Models/route_data.dart';
import '../../Models/suggestion.dart';
import 'stream_sink_interface.dart';

class RxMap with RxMapSink, RxMapStream {
  late final BehaviorSubject<Map<MarkerId, Marker>> _markerList;

  late final BehaviorSubject<Map<PolylineId, Polyline>> _polylineList;

  late final BehaviorSubject<RouteData> _routeData;

  late final BehaviorSubject<PinData> _locationData;

  late final BehaviorSubject<String> _totalValue;

  late final BehaviorSubject<PaymentTotal> _totalValues;

  late final BehaviorSubject<DriverData> _driverData;

  late final BehaviorSubject<String> _isSendingOrder;

  late final BehaviorSubject<MapState> _mapState;

  // late final BehaviorSubject<String> _mapMode;

  late final BehaviorSubject<List<Suggestion>> _suggestionAutoComplete;

  RxMap() {
    _markerList = BehaviorSubject<Map<MarkerId, Marker>>();
    _polylineList = BehaviorSubject<Map<PolylineId, Polyline>>();
    _suggestionAutoComplete = BehaviorSubject<List<Suggestion>>();
    _routeData = BehaviorSubject<RouteData>();
    _totalValues = BehaviorSubject<PaymentTotal>();
    _driverData = BehaviorSubject<DriverData>();
    _locationData = BehaviorSubject<PinData>();
    _mapState = BehaviorSubject<MapState>();
    _isSendingOrder = BehaviorSubject<String>();
    // _mapMode = BehaviorSubject<String>();
  }

  @override
  void dispose() {
    _suggestionAutoComplete.close();
    _markerList.close();
    _polylineList.close();
    _routeData.close();
    _locationData.close();
    _totalValue.close();
    _totalValues.close();
    _driverData.close();
    _isSendingOrder.close();
    _mapState.close();
    // _mapMode.close();
  }

  @override
  Stream<DriverData> get rxDriverData => _driverData.stream;

  @override
  Stream<PinData> get rxLocationData => _locationData.stream;

  @override
  Stream<Map<MarkerId, Marker>> get rxMarkerList => _markerList.stream;

  @override
  Stream<Map<PolylineId, Polyline>> get rxPolylineList => _polylineList.stream;

  @override
  Stream<RouteData> get rxRouteData => _routeData.stream;

  @override
  Stream<String> get rxTotalValue => _totalValue.stream;

  @override
  Stream<PaymentTotal> get rxTotalValues => _totalValues.stream;

  @override
  Stream<String> get rxIsSendingOrder => _isSendingOrder.stream;

  @override
  Stream<MapState> get rxMapState => _mapState.stream;

  // @override
  // Stream<String> get rxMapMode => _mapMode.stream;

  @override
  Stream<List<Suggestion>> get rxSuggestion => _suggestionAutoComplete.stream;

  // Section Set  -----------------------------------------------------------------------------------------------------------

  @override
  Function(DriverData) get rxSetDriverData => _driverData.sink.add;

  @override
  Function(String) get rxSetIsSendingOrder => _isSendingOrder.sink.add;

  @override
  Function(PinData) get rxSetLocationData => _locationData.sink.add;

  @override
  Function(MapState) get rxSetMapState => _mapState.sink.add;

  @override
  Function(Map<MarkerId, Marker>) get rxSetMarkerList => _markerList.sink.add;

  @override
  Function(Map<PolylineId, Polyline>) get rxSetPolylineList => _polylineList.sink.add;

  @override
  Function(String) get rxSetTotal => _totalValue.sink.add;

  @override
  Function(PaymentTotal) get rxSetTotalValues => _totalValues.sink.add;

  // @override
  // Function(String) get rxSetMapMode => _mapMode.sink.add;

  @override
  Function(List<Suggestion>) get rxSetSuggestion => _suggestionAutoComplete.sink.add;
}
