import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Models/driver_data.dart';
import '../../Models/location_data.dart';
import '../../Models/map_state.dart';
import '../../Models/payment.dart';
import '../../Models/route_data.dart';
import '../../Models/suggestion.dart';

mixin RxMapStream {
  Stream<Map<MarkerId, Marker>> get rxMarkerList;

  Stream<Map<PolylineId, Polyline>> get rxPolylineList;

  Stream<RouteData> get rxRouteData;

  Stream<PinData> get rxLocationData;

  Stream<String> get rxTotalValue;

  Stream<PaymentTotal> get rxTotalValues;

  Stream<DriverData> get rxDriverData;

  Stream<String> get rxIsSendingOrder;

  Stream<MapState> get rxMapState;

  // Stream<String> get rxMapMode;

  Stream<List<Suggestion>> get rxSuggestion;
}

mixin RxMapSink {
  Function(Map<PolylineId, Polyline>) get rxSetPolylineList;

  Function(Map<MarkerId, Marker>) get rxSetMarkerList;

  Function(PinData) get rxSetLocationData;

  Function(String) get rxSetTotal;

  Function(PaymentTotal) get rxSetTotalValues;

  Function(DriverData) get rxSetDriverData;

  Function(String) get rxSetIsSendingOrder;

  Function(MapState) get rxSetMapState;

  // Function(String) get rxSetMapMode;

  Function(List<Suggestion>) get rxSetSuggestion;
}
