import 'dart:developer';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/common/config/theme/colors.dart';
import 'package:rider/features/presentation/pages/map/map_store/bloc/interface_map/map_interface.dart';
import 'package:rider/features/presentation/pages/map/map_store/bloc/interface_map/rx_map_interface.dart';
import 'package:tuple/tuple.dart';

import '../../../../../../common/utils/google_api_key.dart';
import '../../../../../../main.dart';
import '../../../../../data/database/app_db.dart';
import '../../../../../data/models/place.dart';
import '../../../../../data/models/store.dart';
import '../map_store_implement.dart';
import 'components/custom_info_window.dart';
import 'components/marker_bitmap.dart';

class MapBloc extends RxMap with MapInterface, GoogleApiKey {
  GlobalKey<ScaffoldState>? key;
  late final List<Place> items;
  late ClusterManager manager;
  late Set<Marker> markers;
  late Map<PolylineId, Polyline> polyLines;
  late CustomInfoWindowController windowController;
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  MapBloc({this.key}) {
    items = [];
    markers = <Marker>{};
    polyLines = <PolylineId, Polyline>{};
    windowController = CustomInfoWindowController();
    setLoading(true);
    initMarkerMap();
    manager = initClusterManager();
    setLoading(false);
  }

  @override
  void initMarkerMap() {
    Timeline.startSync('mapBloc');

    appDatabase.shopsDAO.getAllWithLatLong().then((itemShop) {
      items.clear();
      List.generate(itemShop.length, (index) {
        return items.add(Place(
            shopId: itemShop[index].id.toString(),
            name: itemShop[index].name,
            latLng: LatLng(
              double.tryParse(itemShop[index].lat!)!,
              double.tryParse(itemShop[index].long!)!,
            )));
      });
    }).onError((error, stackTrace) {});
    Timeline.finishSync();
  }

  @override
  ClusterManager initClusterManager() {
    return ClusterManager<Place>(
      items,
      updateMarkers,
      markerBuilder: markerBuilder,
      stopClusteringZoom: 20.0,
    );
  }

  @override
  void updateMarkers(Set<Marker> markers) {
    setLoading(true);
    this.markers = markers;
    setAllMarkers(this.markers);
    setLoading(false);
  }

  @override
  Future<Marker> markerBuilder(Cluster<Place> cluster) async {
    return Marker(
      markerId: MarkerId(cluster.getId()),
      position: cluster.location,
      onTap: !cluster.isMultiple
          ? () => markerTap(cluster)
          : () => clusterTap(cluster),
      icon: cluster.isMultiple
          ? await MarkerBitmap().getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null)
          // : await BitmapDescriptor.fromAssetImage(
          //     const ImageConfiguration(size: Size(78, 78)),
          //     'assets/images/store.png',
          //   ),
          : await MarkerIcon.pictureAsset(
              assetPath: 'assets/images/store.png', height: 106, width: 106),
    );
  }

  void clusterTap(cluster) {
    setDirection(const Tuple2(null, 0));
    windowController.addInfoWindow!(
      Container(),
      cluster.location,
    );
  }

  Future<Shop?> getShop(cluster) async {
    return await appDatabase.shopsDAO
        .getWithLatLongById(cluster.items.first!.shopId);
  }

  void markerTap(cluster) async {
    final myShop = await getShop(cluster);

    if (polyLines.isEmpty) {
      setDirection(Tuple2(myShop!, 1));
    }
    windowController.addInfoWindow!(
      CustomInfoWidget(shop: myShop!),
      cluster.location,
    );
  }

  @override
  Future<List<String>> getSuggestions(String query) async {
    List<String> temp = await appDatabase.shopsDAO.getMapSuggestion(query);
    return temp;
  }

  @override
  void filterMarkers(String text) async {
    setLoading(true);
    clearDirection();
    if (text.isNotEmpty) {
      List<Shop> result = await appDatabase.shopsDAO.getShopByName(text);
      manager.setItems(<Place>[
        for (int i = 0; i < result.length; ++i)
          Place(
              latLng: LatLng(double.tryParse(result[i].lat!)!,
                  double.tryParse(result[i].long!)!),
              shopId: result[i].id.toString(),
              name: result[i].name ?? '')
      ]);

      if (mapStoreController != null) {
        await mapStoreController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(double.tryParse(result.first.lat!)!,
                  double.tryParse(result.first.long!)!),
              zoom: 17),
        ));
      }
    } else {
      manager.setItems(items);
    }
    setLoading(false);
  }

  @override
  void setDirections(
      {required Shop? store,
      required LatLng originLocation,
      required travelMode}) {
    setLoading(true);
    if (store != null) {
      double lat = double.tryParse(store.lat!)!;
      double lng = double.tryParse(store.long!)!;
      LatLng shopPoint = LatLng(lat, lng);
      manager.setItems(<Place>[
        Place(
            latLng: shopPoint,
            shopId: store.id.toString(),
            name: store.name ?? '')
      ]);
      setPolyline(
          originLat: originLocation.latitude,
          originLng: originLocation.longitude,
          shopLat: lat,
          shopLng: lng,
          polylineColor: kPRIMARY,
          travelMode: travelMode);
    }
    setLoading(false);
  }

  @override
  clearDirection() {
    setLoading(true);
    setDirection(const Tuple2(null, 0));
    polyLines.clear();
    setAllPolyLine(polyLines);
    windowController.hideInfoWindow!();
    manager.setItems(items);
    setLoading(false);
  }

  @override
  filterMarkersByShop(List<Store> itemShop) {
    clearDirection();
    setLoading(true);
    manager.setItems(List<Place>.generate(itemShop.length, (index) {
      final shop = itemShop[index];
      return Place(
          name: shop.name ?? '',
          shopId: shop.id ?? '',
          latLng: LatLng(
            double.tryParse(shop.lat!)!,
            double.tryParse(shop.long!)!,
          ));
    }));
    setLoading(false);
  }

  @override
  Future<bool> setPolyline(
      {required double originLat,
      required double originLng,
      required double shopLat,
      required double shopLng,
      required Color polylineColor,
      required TravelMode travelMode}) async {
    _getPolyline(
      originLatitude: originLat,
      originLongitude: originLng,
      destLatitude: shopLat,
      destLongitude: shopLng,
      travelMode: travelMode,
    );
    return true;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: kPrimaryColor,
      points: polylineCoordinates,
      width: 5,
      endCap: Cap.roundCap,
      startCap: Cap.roundCap,
    );
    polyLines[id] = polyline;

    setAllPolyLine(polyLines);
    setMapFitToTour(Set.of(polyLines.values));
  }

  Future<void> _getPolyline(
      {originLatitude,
      originLongitude,
      destLatitude,
      destLongitude,
      travelMode}) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      getApiKey(),
      PointLatLng(originLatitude, originLongitude),
      PointLatLng(destLatitude, destLongitude),
      travelMode: travelMode ?? TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  setMapFitToTour(Set<Polyline> p) async {
    double minLat = p.first.points.first.latitude;
    double minLong = p.first.points.first.longitude;
    double maxLat = p.first.points.first.latitude;
    double maxLong = p.first.points.first.longitude;

    for (var poly in p) {
      for (var point in poly.points) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      }
    }
    mapStoreController!.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong)),
        100));
  }

  @override
  void dispose() => {windowController.dispose()};

  addSinkDirection({required int idx, required Shop? result}) {
    setDirection(Tuple2(result, idx));
  }
}
