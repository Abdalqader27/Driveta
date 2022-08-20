import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tuple/tuple.dart';

import '../../../../../../data/database/app_db.dart';
import '../../../../../../data/models/route_data.dart';

mixin RxMapStream {
  Stream<Set<Marker>?> get allMarkers;

  Stream<Map<PolylineId, Polyline>> get allPolyLine;

  Stream<bool> get isFilter;

  Stream<bool> get isLoading;

  Stream<RouteData> get routeData;

  Stream<Tuple2<Shop?, int>> get direction;
}

mixin RxMapSink {
  Function(Set<Marker>) get setAllMarkers;

  Function(Map<PolylineId, Polyline>) get setAllPolyLine;

  Function(bool) get setFilter;

  Function(bool) get setLoading;

  Function(RouteData) get setRouteData;

  Function(Tuple2<Shop?, int>) get setDirection;
}
