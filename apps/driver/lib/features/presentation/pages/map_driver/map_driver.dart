import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:driver/app_injection.dart';
import 'package:driver/features/data/models/marker_config.dart';
import 'package:driver/features/presentation/manager/bloc.dart';
import 'package:driver/features/presentation/pages/map_driver/available_deliver.dart';
import 'package:driver/features/presentation/pages/map_driver/widgets/map_drawer.dart';
import 'package:driver/features/presentation/pages/map_driver/widgets/map_panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animarker/core/ripple_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils/config.dart';
import '../../../../../common/utils/signal_r_config.dart';
import '../../../../../features/presentation/pages/sgin_up/registeration_screen.dart';
import '../../manager/event.dart';
import 'widgets/map_app_bar.dart';

late BuildContext context;
late GoogleMapController newGoogleMapController;

class MapDriverScreen extends StatefulWidget {
  static const String idScreen = "mapDelivery";

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  const MapDriverScreen({Key? key}) : super(key: key);

  @override
  State<MapDriverScreen> createState() => _MapDriverScreenState();
}

class _MapDriverScreenState extends State<MapDriverScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  StreamSubscription<Position>? stream;

  @override
  dispose() {
    super.dispose();
    newGoogleMapController.dispose();
    stream?.cancel();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: MapDrawer(
          onClose: () {
            Navigator.of(_key.currentState!.context).pop();
          },
        ),
        body: Column(
          children: [
            MapAppBarWidget(
              title: 'تطبيق السائق ',
              onChanged: (value) async {
                if (value) {
                  BotToast.showLoading();
                  si<DriverBloc>().add(GetAvailableDeliveries());
                  await SignalRDriver().openConnection();
                  await makeDriverOnlineNow();
                  BotToast.closeAllLoading();
                  getLocationLiveUpdates();
                  displayToastMessage("تم الاتصال ", context);
                  Get.to(() => AvailableDeliveries());
                } else {
                  await SignalRDriver().stopConnection();
                  displayToastMessage("تم قطع الاتصال", context);
                }
              },
              onPressed: () {
                _key.currentState!.openDrawer();
              },
            ),

            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 25,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      padding: const EdgeInsets.only(top: 30),
                      buildingsEnabled: true,
                      myLocationEnabled: false,
                      markers: _markers.values.toSet(),
                      myLocationButtonEnabled: true,
                      initialCameraPosition: MapDriverScreen._kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        newGoogleMapController = controller;

                        _controllerGoogleMap.complete(controller);
                        if (mounted) {
                          locatePosition();
                        }
                      },
                    ),
                  ),
                  // Animarker(
                  //     curve: Curves.linear,
                  //     useRotation: true,
                  //     shouldAnimateCamera: false,
                  //     angleThreshold: 0,
                  //     zoom: 20,
                  //     rippleColor: kPRIMARY,
                  //     rippleRadius: 0.8,
                  //     markers: _markers.values.toSet(),
                  //     mapId: _controllerGoogleMap.future
                  //         .then<int>((value) => value.mapId),
                  //     child: GoogleMap(
                  //       mapType: MapType.normal,
                  //       padding: const EdgeInsets.only(top: 30),
                  //       buildingsEnabled: true,
                  //       myLocationEnabled: false,
                  //       // markers: _markers.values.toSet(),
                  //       initialCameraPosition: MapDriverScreen._kGooglePlex,
                  //       onMapCreated: (GoogleMapController controller) {
                  //         _controllerGoogleMap.complete(controller);
                  //         newGoogleMapController = controller;
                  //         locatePosition();
                  //       },
                  //  )),
                  const MapPanelWidget(),
                ],
              ),
            ),
            // online offline driver Container
          ],
        ));
  }

  void locatePosition() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // currentPosition = position;

    // final permission = await Location.instance. serviceEnabled();
    // LocationData position = await Location.instance.getLocation();

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(
      target: latLatPosition,
      zoom: 19,
      bearing: position.heading,
    );
    if (!mounted) return;

    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(
      cameraPosition,
    ));

    final data = si<SStorage>().get(key: kVehicleType, type: ValueType.string);

    late final MarkerConfig markerConfig;
    markerConfig = data == '500'
        ? kDriverMotorMarker(latLatPosition)
        : kDriverMarker(latLatPosition);
    final Marker marker = await _marker(
      markerId: markerConfig.markerId,
      pinPath: markerConfig.pinPath,
      point: markerConfig.point,
      title: markerConfig.title,
      snippet: markerConfig.snippet,
    );
    setStateIfMounted(() {
      _markers[marker.markerId] = marker;
    });
  }

  Future<void> makeDriverOnlineNow() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      //nothing
      return;
    }
    if (!mounted) {
      stream?.cancel();
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await SignalRDriver().sendLocation(
      point: LatLng(position.latitude, position.longitude),
      angel: position.heading,
    );
    await SignalRDriver().sendLocationProduct(
      point: LatLng(position.latitude, position.longitude),
      angel: position.heading,
    );
  }

  Future<void> getLocationLiveUpdates() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      //nothing
      return;
    }
    if (!mounted) {
      stream?.cancel();
      return;
    }

    stream =
        Geolocator.getPositionStream().listen((Position currentLocation) async {
      if (SignalRDriver.connectionIsOpen == true && mounted) {
        print(
            "latlang:${LatLng(currentLocation.latitude, currentLocation.longitude)}");

        await SignalRDriver().sendLocation(
            point: LatLng(
              currentLocation.latitude,
              currentLocation.longitude,
            ),
            angel: currentLocation.heading);

        await SignalRDriver().sendLocationProduct(
            point: LatLng(
              currentLocation.latitude,
              currentLocation.longitude,
            ),
            angel: currentLocation.heading);
        LatLng latLng =
            LatLng(currentLocation.latitude, currentLocation.longitude);
        CameraPosition cameraPosition = CameraPosition(
          target: latLng,
          bearing: currentLocation.heading,
          zoom: 18,
        );
        newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(
          cameraPosition,
        ));
        final data =
            si<SStorage>().get(key: kVehicleType, type: ValueType.string);

        late final MarkerConfig markerConfig;
        markerConfig =
            data == '500' ? kDriverMotorMarker(latLng) : kDriverMarker(latLng);
        final Marker marker = await _marker(
          markerId: markerConfig.markerId,
          pinPath: markerConfig.pinPath,
          point: markerConfig.point,
          title: markerConfig.title,
          snippet: markerConfig.snippet,
        );
        setStateIfMounted(() {
          _markers[markerConfig.markerId] = marker;
        });
      }
    });
  }

  Future<Marker> _marker(
      {required MarkerId markerId,
      required LatLng point,
      required String pinPath,
      required String title,
      required String snippet}) async {
    return RippleMarker(
      ripple: true,
      //Ripple state

      icon: await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(50, 50)),
        pinPath,
      ),
      // icon: BitmapDescriptor.defaultMarker,
      markerId: markerId,
      position: point,
      infoWindow: InfoWindow(title: title, snippet: snippet),
    );
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }
}
