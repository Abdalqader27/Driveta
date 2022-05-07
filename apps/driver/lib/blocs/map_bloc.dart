import 'dart:async';

import 'package:bot_toast/bot_toast.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../common/utils/google_api_key.dart';

import '../Models/driver_data.dart';
import '../Models/location_data.dart';
import '../Models/marker_config.dart';
import '../Models/polyline_config.dart';
import '../Models/suggestion.dart';
import 'interface_map/map_interface.dart';
import 'interface_map/rx_map_interface.dart';

class MapBloc extends RxMap with MapInterface, GoogleApiKey {
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  final Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};
  final List<LatLng> polylineCoordinates = [];
  final PolylinePoints polylinePoints = PolylinePoints();

  @override
  Future<void> setDriverData(DriverData driverData) async {
    await rxSetDriverData(driverData);
  }

  @override
  Future<void> setLocationData(PinData locationData) async {
    await rxSetLocationData(locationData);
  }

  @override
  Future<void> deleteMarker(MarkerId markerId) async {
    _markers.removeWhere((k, v) => k == markerId);
    await rxSetMarkerList(_markers);
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
    await rxSetMarkerList(_markers);
  }

  @override
  Future<bool> setPolyline(PinData locationData, PolyLineConfig polylineConfig) async {
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

    await rxSetPolylineList(_polyLines);

    await setMapFitToTour(Set.of(_polyLines.values));
    BotToast.closeAllLoading();

    return true;
  }

  @override
  Future<void> clearPolyline() async {
    _polyLines.clear();
    await rxSetPolylineList(_polyLines);
  }

  @override
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

    // mapController.animateCamera(CameraUpdate.newLatLngBounds(
    //     LatLngBounds(
    //         southwest: LatLng(minLat, minLong),
    //         northeast: LatLng(maxLat, maxLong)),
    //     100));
  }

// Future<bool> setPolyline(double originLat, double originLng,
//     double destinationLat, double destinationLng, Color polylineColor) async {
//   final ws.GoogleMapsDirections directions = ws.GoogleMapsDirections(apiKey: getApiKey());
//
//   final ws.DirectionsResponse response =
//       await directions.directionsWithLocation(
//     ws.Location(originLat, originLng),
//     ws.Location(destinationLat, destinationLng),
//     travelMode: ws.TravelMode.driving,
//     trafficModel: ws.TrafficModel.pessimistic,
//     departureTime: DateTime.now(),
//   );
//
//   final List<ws.Step> steps = response.routes[0].legs[0].steps;
//
//   MyObjects.myDataSendReservation.exTimeText =
//       response.routes[0].legs[0].duration.text.toString();
//   MyObjects.myDataSendReservation.exTimeValue =
//       response.routes[0].legs[0].duration.value.toString();
//   MyObjects.myDataSendReservation.exDistanceText =
//       response.routes[0].legs[0].distance.text.toString();
//   MyObjects.myDataSendReservation.exDistanceValue =
//       response.routes[0].legs[0].distance.value.toString();
//
//   print("map_bloc /The Duration :" +
//       response.routes[0].legs[0].duration.value.toString());
//   print("map_bloc /The  Distatance  :" +
//       response.routes[0].legs[0].distance.value.toString());
//
//   final String eta = response.routes[0].legs[0].duration.text;
//   final String km = response.routes[0].legs[0].distance.text;
//   final ws.Bounds bounds = response.routes[0].bounds;
//
//   final List<LatLng> pointList = List<LatLng>();
//
//   steps.forEach((ws.Step step) {
//     final ws.Polyline polyline = step.polyline;
//     final String points = polyline.points;
//
//     final List<LatLng> singlePolyLine = _decodePolyLine(points);
//     singlePolyLine.forEach(pointList.add);
//   });
//
//   final PolylineId polyId = PolylineId('polyline');
//   _polyLines[polyId] = Polyline(
//       polylineId: polyId,
//       points: pointList,
//       color: polylineColor,
//       width: 5,
//       startCap: Cap.roundCap,
//       endCap: Cap.roundCap);
//
//   print('ETA: $eta');
//   print('Km: $km');
//   _totalValues.sink.add(PaymentTotal(pay: "حدد السيارة", discount: ""));
//
//   _polylineList.sink.add(_polyLines);
//   _routeData.sink.add(RouteData(bounds, km, eta));
//   return true;
// }
  Future<Marker> _marker(
      {required MarkerId markerId,
      required LatLng point,
      required String pinPath,
      required String title,
      required String snippet}) async {
    return Marker(
      // icon: await BitmapDescriptor.fromAssetImage(
      //   const ImageConfiguration(size: Size(200, 200)),
      //   pinPath,
      // ),
      icon: BitmapDescriptor.defaultMarker,
      markerId: markerId,
      position: point,
      infoWindow: InfoWindow(title: title, snippet: snippet),
    );
  }

  @override
  Stream<List<Suggestion>> getSuggestion() {
    return rxSuggestion;
  }

  @override
  Future<bool> setQuerySuggestion(String suggestion) async {
    //final result = await MapApi().fetchSuggestions(suggestion);
    // rxSetSuggestion(result);
    return true;
  }

  @override
  Future<void> clearMarkers() async {
    _markers.clear();
    await rxSetMarkerList(_markers);
  }
}
