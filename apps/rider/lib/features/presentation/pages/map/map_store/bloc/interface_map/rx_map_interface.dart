import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/features/presentation/pages/map/map_store/bloc/interface_map/stream_sink_interface.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../../../../../../data/database/app_db.dart';
import '../../../../../../data/models/route_data.dart';

abstract class RxMap with RxMapStream, RxMapSink {
  late final BehaviorSubject<bool> _isFilter;

  late final BehaviorSubject<bool> _isLoading;

  late final BehaviorSubject<Map<PolylineId, Polyline>> _allPolyLine;

  late final BehaviorSubject<RouteData> _routeData;

  late final BehaviorSubject<Set<Marker>> _allMarkers;

  late final BehaviorSubject<Tuple2<Shop?, int>> _direction;

  RxMap() {
    _isFilter = BehaviorSubject<bool>.seeded(false);
    _isLoading = BehaviorSubject<bool>.seeded(false);
    _allPolyLine = BehaviorSubject<Map<PolylineId, Polyline>>.seeded({});
    _routeData = BehaviorSubject<RouteData>();
    _allMarkers = BehaviorSubject<Set<Marker>>.seeded({});
    _direction = BehaviorSubject<Tuple2<Shop?, int>>();
  }

  @override
  Stream<Map<PolylineId, Polyline>> get allPolyLine => _allPolyLine.stream;

  @override
  Stream<bool> get isLoading => _isLoading.stream;

  @override
  Stream<Set<Marker>?> get allMarkers => _allMarkers.stream;

  @override
  Stream<bool> get isFilter => _isFilter.stream;

  @override
  Stream<RouteData> get routeData => _routeData.stream;

  @override
  Stream<Tuple2<Shop?, int>> get direction => _direction.stream;

  /// Sink Sections -------------------------------------------------------------------------------
  @override
  Function(Set<Marker>) get setAllMarkers {
    return _allMarkers.sink.add;
  }

  @override
  Function(Map<PolylineId, Polyline>) get setAllPolyLine {
    return _allPolyLine.sink.add;
  }

  @override
  Function(bool) get setFilter {
    return _isFilter.sink.add;
  }

  @override
  Function(bool) get setLoading {
    return _isLoading.sink.add;
  }

  @override
  Function(RouteData) get setRouteData {
    return _routeData.sink.add;
  }

  @override
  Function(Tuple2<Shop?, int>) get setDirection {
    return _direction.sink.add;
  }

  @override
  void dispose() {
    _allMarkers.close();
    _isFilter.close();
    _isLoading.close();
    _routeData.close();
    _allPolyLine.close();
    _direction.close();
  }
}
