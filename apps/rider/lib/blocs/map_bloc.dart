import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/mainscreen.dart';

import '../../../../common/utils/google_api_key.dart';
import '../Models/location_data.dart';
import '../Models/marker_config.dart';
import '../Models/polyline_config.dart';
import 'interface_map/map_interface.dart';
import 'interface_map/rx_map_interface.dart';

class MapBloc extends RxMap with MapInterface, GoogleApiKey {
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  final Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};
  final List<LatLng> polylineCoordinates = [];
  final PolylinePoints polylinePoints = PolylinePoints();

  @override
  Future<void> setTripData(TripData tripData) async {
    await sinkSetLocationData(tripData);
  }

  @override
  Future<void> deleteMarker(MarkerId markerId) async {
    _markers.removeWhere((k, v) => k == markerId);
    await sinkSetMarkerList(_markers);
  }

  @override
  Future<void> setMarker(MarkerConfig markerConfig) async {
    final Marker marker = await _marker(
      markerId: markerConfig.markerId,
      pinPath: markerConfig.pinPath,
      point: markerConfig.point,
      title: markerConfig.title,
      snippet: markerConfig.snippet,
    );
    _markers[markerConfig.markerId] = marker;
    await sinkSetMarkerList(_markers);
  }

  @override
  Future<bool> setPolyline(TripData locationData, PolyLineConfig polylineConfig) async {
    BotToast.showLoading();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      getApiKey(),
      PointLatLng(
        locationData.currentPoint.latitude,
        locationData.currentPoint.longitude,
      ),
      PointLatLng(
        locationData.destinationPoint.latitude,
        locationData.destinationPoint.longitude,
      ),
      travelMode: polylineConfig.travelMode,
    );
    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    Polyline polyline = Polyline(
      polylineId: polylineConfig.polylineId,
      color: polylineConfig.color,
      points: polylineCoordinates,
      width: polylineConfig.width,
      endCap: polylineConfig.capEnd,
      startCap: polylineConfig.capStart,
    );
    _polyLines[polylineConfig.polylineId] = polyline;

    await sinkSetPolylineList(_polyLines);

    await setMapFitToTour(Set.of(_polyLines.values));
    BotToast.closeAllLoading();

    return true;
  }

  @override
  Future<void> clearPolyline() async {
    _polyLines.clear();
    await sinkSetPolylineList(_polyLines);
  }

  @override
  Future<void> setMapFitToTour(Set<Polyline> p, {GoogleMapController? controller}) async {
    double minLat = p.first.points.first.latitude;
    double minLong = p.first.points.first.longitude;
    double maxLat = p.first.points.first.latitude;
    double maxLong = p.first.points.first.longitude;

    for (Polyline poly in p) {
      for (var point in poly.points) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      }
    }
    if (controller == null) {
      newGoogleMapController.animateCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(southwest: LatLng(minLat, minLong), northeast: LatLng(maxLat, maxLong)),
          100));
    } else {
      controller.animateCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(southwest: LatLng(minLat, minLong), northeast: LatLng(maxLat, maxLong)),
          100));
    }
  }

  Future<Marker> _marker(
      {required MarkerId markerId,
      required LatLng point,
      String? pinPath,
      required String title,
      required String snippet}) async {
    return Marker(
      icon: pinPath == null
          ? BitmapDescriptor.defaultMarker
          : await BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(78, 78)),
              pinPath,
            ),
      markerId: markerId,
      position: point,
      infoWindow: InfoWindow(title: title, snippet: snippet),
    );
  }

  @override
  Future<void> clearMarkers() async {
    _markers.clear();
    await sinkSetMarkerList(_markers);
  }
}
