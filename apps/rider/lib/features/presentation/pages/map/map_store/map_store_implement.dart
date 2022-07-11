import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rider/features/presentation/pages/map/map_store/widgets/button_map.dart';
import 'package:rider/features/presentation/pages/map/map_store/widgets/search_bar.dart';

import '../../../../../common/widgets/progress-Indicator.dart';
import 'bloc/map_source/map_source.dart';

GoogleMapController? mapStoreController;

class MapImplement {
  late String darkMapStyle, lightMapStyle;
  late CameraPosition cameraPosition;
  dynamic originLat, originLag;
  double currentZoom = 12.0;
  double previousZoom = 11.0;

  var mapType;

  Future loadMapStyles() async {
    darkMapStyle = await rootBundle.loadString('assets/dark.json');
    lightMapStyle = await rootBundle.loadString('assets/light.json');
  }

  Future setMapStyle(context) async {
    if (mapStoreController != null) {
      try {
        final theme = Theme.of(context).brightness;
        if (theme == Brightness.dark) {
          mapStoreController!.setMapStyle(darkMapStyle);
        } else {
          mapStoreController!.setMapStyle(lightMapStyle);
        }
      } catch (_) {}
    }
  }

  void onTapPosition(position) {
    MapSource.mapBloc!.windowController.hideInfoWindow!();
    MapSource.mapBloc!.allPolyLine.forEach((element) {
      if (element.isEmpty) {
        MapSource.mapBloc!.addSinkDirection(idx: 0, result: null);
      }
    });
  }

  void onCameraMove(CameraPosition cameraPosition) {
    MapSource.mapBloc!.windowController.onCameraMove!();
    MapSource.mapBloc!.manager.onCameraMove(cameraPosition);
    if (currentZoom != previousZoom) {
      previousZoom = currentZoom;
      MapSource.mapBloc!.setLoading(true);
    } else {
      currentZoom = cameraPosition.zoom;
    }
  }

  void onCameraIdle() {
    MapSource.mapBloc!.manager.updateMap();
    if (currentZoom != previousZoom) MapSource.mapBloc!.setLoading(false);
  }

  void goToMyLocation(location) async {
    mapStoreController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(location?.latitude, location?.longitude), zoom: 17),
    ));
  }

  Widget showClosedFilterButton() => StreamBuilder<bool>(
      stream: MapSource.mapBloc!.isFilter,
      builder: (context, snapshot) {
        if (snapshot.data == null || snapshot.data == false) return Container();
        return circleCloseButton(context, onPressed: () {
          MapSource.mapBloc!.filterMarkers("");
          // Provider.of<ShopFilterProvider>(context, listen: false).reset();
          MapSource.mapBloc!.setFilter(false);
        });
      });

  initCameraPosition(LocationData? myLocation) {
    cameraPosition = CameraPosition(
        target: (myLocation != null &&
                myLocation.latitude != null &&
                myLocation.longitude != null)
            ? LatLng(myLocation.latitude!, myLocation.longitude!)
            : const LatLng(36.217224577189995, 37.14486960321665),
        zoom: 12.0);
  }

  Widget getMapLoading() => StreamBuilder<bool>(
      stream: MapSource.mapBloc!.isLoading,
      builder: (context, snapshot) {
        if (snapshot.data == null || snapshot.data == false) return Container();
        return const Positioned(
          left: 20,
          top: 100,
          child: SizedBox(
            width: 25,
            height: 25,
            child: ProgressIndicatorLoading(),
          ),
        );
      });

  LinearGradient linearGradient(context) => LinearGradient(
          colors: [
            Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).scaffoldBackgroundColor
                : const Color(0xfffbfbfb),
            Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).scaffoldBackgroundColor
                : const Color(0xfffbfbfb).withOpacity(.2),
          ],
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          tileMode: TileMode.clamp);

  Widget appBarGradients({required context, required LatLng location}) =>
      Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(gradient: linearGradient(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SearchBarMap(),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 15),
                //   padding: EdgeInsets.all(5),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       border: Border.all(color: AppColors.ACCENT, width: 2)),
                //   child: Text(
                //     "العدد ",
                //     style: TextStyle(color: AppColors.ACCENT),
                //   ),
                // ),
              ],
            ),
          ));
}
