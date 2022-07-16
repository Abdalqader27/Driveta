import 'package:connectivity/connectivity.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tuple/tuple.dart';

import '../../../../../../common/config/theme/colors.dart';
import '../../../../../../common/utils/storage/shared_preferences.dart';
import '../../../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../../../../data/database/app_db.dart';
import '../bloc/map_source/map_source.dart';
import '../map_store_implement.dart';
import 'button_map.dart';

class GoogleMapsScreen extends StatefulWidget {
  final LocationData? myLocation;
  final isMapSatellite;

  const GoogleMapsScreen({
    Key? key,
    this.myLocation,
    this.isMapSatellite,
  }) : super(key: key);

  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin, MapImplement {
  @override
  bool get wantKeepAlive => true;

  @override
  void didChangePlatformBrightness() => setMapStyle(context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadMapStyles();
    if (widget.isMapSatellite == null) {
      mapType = MapType.normal;
    } else {
      mapType = (!widget.isMapSatellite) ? MapType.normal : MapType.satellite;
    }
    initCameraPosition(widget.myLocation);
  }

  @override
  void dispose() => {
        WidgetsBinding.instance.removeObserver(this),
        super.dispose(),
      };

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Stack(
        children: [
          StreamBuilder(
              stream: MapSource.mapBloc!.allMarkers,
              builder: (context, marker) {
                return SizedBox(
                  key: Key(Theme.of(context).brightness.toString()),
                  child: StreamBuilder<Map<PolylineId, Polyline>>(
                      stream: MapSource.mapBloc!.allPolyLine,
                      builder: (context, polyline) {
                        if (polyline.data == null) return Container();
                        return googleMapView(marker, polyline.data);
                      }),
                );
              }),
          appBarGradients(
              context: context,
              location: LatLng(
                widget.myLocation!.latitude ?? 0,
                widget.myLocation!.longitude ?? 0,
              )),
          Positioned(
            right: 0,
            top: 70,
            child: mapButtons(
                context: context,
                location: LatLng(
                  widget.myLocation!.latitude ?? 0,
                  widget.myLocation!.longitude ?? 0,
                )),
          ),
          showClosedFilterButton(),
          getMapLoading(),
          CustomInfoWindow(
            controller: MapSource.mapBloc!.windowController,
            height: 75,
            width: 150,
            offset: 30,
          ),
        ],
      ),
    );
  }

  Widget googleMapView(marker, Map<PolylineId, Polyline>? polyline) {
    return GoogleMap(
      mapType: mapType,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController controller) {
        onMapCreated(controller);
      },
      onCameraMove: onCameraMove,
      onTap: onTapPosition,
      onCameraIdle: onCameraIdle,
      compassEnabled: true,
      myLocationEnabled: true,
      rotateGesturesEnabled: true,
      tiltGesturesEnabled: false,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      myLocationButtonEnabled: false,
      padding: const EdgeInsets.only(top: 260),
      mapToolbarEnabled: false,
      markers: (marker.data != null) ? marker.data : {},
      polylines: (polyline != null) ? Set.of(polyline.values) : {},
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapStoreController = controller;
    MapSource.mapBloc!.manager.setMapId(controller.mapId);
    MapSource.mapBloc!.windowController.googleMapController = controller;
    setMapStyle(context);
  }

  changeMapSatellite() => setState(() {
        if (mapType == MapType.satellite) {
          SharedPreferencesHandler.setSharedPreference(
              key: "mapType", value: false);
          mapType = MapType.normal;
        } else {
          SharedPreferencesHandler.setSharedPreference(
              key: "mapType", value: true);
          mapType = MapType.satellite;
        }
      });

  Widget mapButtons({location, context}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: RPadding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => changeMapSatellite(),
              child: const Card(
                color: kPRIMARY,
                child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: kPRIMARY,
                  mini: true,
                  heroTag: 'satalate',
                  tooltip: ' تغير عرض الخريطة ',
                  onPressed: null,
                  child: Icon(
                    Icons.map_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => changeMapSatellite(),
              child: const Card(
                color: kPRIMARY,
                child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: kPRIMARY,
                  mini: true,
                  heroTag: 'gps',
                  tooltip: 'موقعك ',
                  onPressed: null,
                  child: Icon(
                    Icons.gps_fixed,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            StreamBuilder<ConnectivityResult>(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, internetRes) {
                if (internetRes.data == null ||
                    ConnectivityResult.none == internetRes.data) {
                  return Container();
                }
                return StreamBuilder<Tuple2<Shop?, int>>(
                    stream: MapSource.mapBloc!.direction,
                    builder: (_, result) {
                      if (result.data == null || (result.data!.item2 == 0)) {
                        return Container();
                      } else if (result.data!.item2 == 1) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 1300),
                          curve: Curves.bounceInOut,
                          child: Column(
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  MapSource.mapBloc!.addSinkDirection(
                                      idx: 2, result: result.data!.item1);
                                  MapSource.mapBloc!.setDirections(
                                      store: result.data!.item1,
                                      originLocation: location,
                                      travelMode: TravelMode.walking);
                                },
                                child: const Card(
                                  color: kPRIMARY,
                                  child: FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: kPRIMARY,
                                    mini: true,
                                    heroTag: 'walk',
                                    tooltip: 'مسار المشاة ',
                                    onPressed: null,
                                    child: Icon(
                                      Icons.directions_walk,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  MapSource.mapBloc!.addSinkDirection(
                                      idx: 2, result: result.data!.item1);
                                  MapSource.mapBloc!.setDirections(
                                      store: result.data!.item1,
                                      originLocation: location,
                                      travelMode: TravelMode.driving);
                                },
                                child: const Card(
                                  color: kPRIMARY,
                                  child: FloatingActionButton(
                                    elevation: 0,
                                    backgroundColor: kPRIMARY,
                                    mini: true,
                                    heroTag: 'drivers',
                                    tooltip: 'مسار المركبات',
                                    onPressed: null,
                                    child: Icon(
                                      Icons.local_taxi_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: [
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Shop? shop = result.data!.item1;
                              double shopLat = double.parse(shop!.lat ?? "0");
                              double shopLng = double.parse(shop.long ?? "0");

                              LatLng shopLatLng = LatLng(shopLat, shopLng);
                              goToMyLocation(shopLatLng);
                            },
                            child: const Card(
                              color: kPRIMARY,
                              child: FloatingActionButton(
                                elevation: 0,
                                backgroundColor: kPRIMARY,
                                mini: true,
                                heroTag: 'shop',
                                tooltip: ' المتجر ',
                                onPressed: null,
                                child: Icon(
                                  Icons.directions,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          circleButton(context,
                              icon:
                                  const Icon(Icons.close, color: Colors.white),
                              heroTag: "close",
                              tooltip: "إغلاق  ", onPressed: () {
                            MapSource.mapBloc!
                                .addSinkDirection(idx: 0, result: null);
                            MapSource.mapBloc!.clearDirection();
                          }),
                        ],
                      );
                    });
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
