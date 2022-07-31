import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/features/data/models/direct_details.dart';

import '../../../../../../common/assistants/assistantMethods.dart';
import '../../../../../../common/utils/google_api_key.dart';
import '../../../../../data/models/marker_config.dart';
import '../../../../../data/models/polyline_config.dart';
import '../../../../../domain/entities/state_trip_product.dart';

class MapTripProvider extends ChangeNotifier with GoogleApiKey {
  final Map<MarkerId, Marker> _markers = {};
  final Map<PolylineId, Polyline> _polyLines = {};
  final List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  StateTripProduct _stateTripProduct = StateTripProduct();
  DirectionDetails? _directionDetails = DirectionDetails();

  GoogleMapController? _mapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController? get mapController => _mapController;

  Map<MarkerId, Marker> get markers => _markers;

  Map<PolylineId, Polyline> get polyLines => _polyLines;

  StateTripProduct get state => _stateTripProduct;

  DirectionDetails? get details => _directionDetails;

  Future<void> prepareMap({
    required MarkerConfig startMarker,
    required MarkerConfig endMarker,
    required MarkerConfig driverMarker,
    required PointLatLng startPoint,
    required PointLatLng endPoint,
    required PolyLineConfig polyLineConfig,
  }) async {
    await addMarker(startMarker);
    await addMarker(endMarker);
    await addMarker(driverMarker);
    await setPolyline(startPoint, endPoint, polyLineConfig);
  }

  Future<void> addMarker(MarkerConfig markerConfig) async {
    final Marker marker = await _marker(
      markerId: markerConfig.markerId,
      pinPath: markerConfig.pinPath,
      point: markerConfig.point,
      title: markerConfig.title,
      snippet: markerConfig.snippet,
    );
    _markers[markerConfig.markerId] = marker;
    notifyListeners();
  }

  void removeMarker(MarkerId id) {
    _markers.removeWhere((k, v) => k == id);
    notifyListeners();
  }

  Future<bool> setPolyline(PointLatLng startPoint, PointLatLng endPoint,
      PolyLineConfig polylineConfig) async {
    BotToast.showLoading();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      getApiKey(),
      startPoint,
      endPoint,
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
    await setMapFitToTour(Set.of(_polyLines.values));
    BotToast.closeAllLoading();
    notifyListeners();
    return true;
  }

  void clearPolyline() {
    _polyLines.clear();
    notifyListeners();
  }

  Future<void> setMapFitToTour(Set<Polyline> p) async {
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
    _mapController!.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong)),
        100));
  }

  void removePolyline(PolylineId id) {
    _polyLines.remove(id);
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _controllerGoogleMap.complete(controller);
    notifyListeners();
  }

  void reset() {
    _markers.clear();
    _polyLines.clear();
    polylineCoordinates.clear();
    polylinePoints = PolylinePoints();
    _stateTripProduct = StateTripProduct();
    _directionDetails = DirectionDetails();
    notifyListeners();
  }

  void animateCameraTarget(LatLng target) {
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 18)));
  }

  void animateCameraPosition(Position position) {
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 18)));
  }

  void getDirectDetails(LatLng origin, LatLng destination) async {
    _directionDetails =
        await AssistantMethods.obtainPlaceDirectionDetails(origin, destination);
    notifyListeners();
  }

  Future<int> mapId() async {
    return _controllerGoogleMap.future.then<int>((value) => value.mapId);
  }

  Future<Marker> _marker(
      {required MarkerId markerId,
      required LatLng point,
      String? pinPath,
      required String title,
      required String snippet}) async {
    return RippleMarker(
      ripple: true,
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
}
