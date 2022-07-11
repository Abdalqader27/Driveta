import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../data/database/app_db.dart';
import '../../../../../../data/models/place.dart';
import '../../../../../../data/models/store.dart';

abstract class MapInterface {
  void updateMarkers(Set<Marker> markers);

  ClusterManager initClusterManager();

  Future<Marker> markerBuilder(Cluster<Place> cluster);

  Future<List<String>> getSuggestions(String query);

  void initMarkerMap();

  void filterMarkers(String text);

  void setDirections({
    required Shop? store,
    required LatLng originLocation,
    required TravelMode travelMode,
  });

  void filterMarkersByShop(List<Store> itemShop);

  void clearDirection();

  Future<bool> setPolyline(
      {required double originLat,
      required double originLng,
      required double shopLat,
      required double shopLng,
      required Color polylineColor,
      required TravelMode travelMode});
}
