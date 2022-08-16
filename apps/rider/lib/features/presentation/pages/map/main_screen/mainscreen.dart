import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animarker/widgets/animarker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:rider/common/assistants/assistantMethods.dart';
import 'package:rider/common/config/theme/colors.dart';
import 'package:rider/features/data/models/delivers.dart';
import 'package:rider/features/presentation/widgets/noDriverAvailableDialog.dart';

import '../../../../../blocs/container_map_bloc.dart';
import '../../../../../blocs/map_bloc.dart';
import '../../../../../common/utils/check_map_status.dart';
import '../../../../../common/utils/config.dart';
import '../../../../../common/utils/go_to.dart';
import '../../../../../common/utils/map_style.dart';
import '../../../../../common/utils/signal_r.dart';
import '../../../../../common/utils/signal_r_new.dart';
import '../../../../../common/widgets/map_pin.dart';
import '../../../../../main.dart';
import '../../../../data/models/direct_details.dart';
import '../../../../data/models/map_state.dart';
import '../../../widgets/float_actions_buttons.dart';
import '../../../widgets/header_location_destination.dart';
import '../../../widgets/map_drawer.dart';
import '../../../widgets/map_next_button.dart';
import '../map_store/map_store_screen.dart';
import '../map_trip_live/providers/map_live_provider.dart';
import '../widgets/choice_cars.dart';
import '../widgets/searching_on_driver.dart';

Set<String> set = {};

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

late GoogleMapController mainMapController;

class MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  Completer<GoogleMapController>? _controllerGoogleMap = Completer();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DirectionDetails? directionDetails;
  Position? currentPosition;
  double bottomPadding = 0;
  double rideDetailsContainerHeight = 0;
  double requestRideContainerHeight = 0;
  double searchContainerHeight = 220.0;
  double driverDetailsContainerHeight = 0;
  bool showLottie = true;
  bool drawerOpen = true;
  bool isRequestingPositionDetails = false;
  late Timer timer;
  bool mapDarkMode = true;
  late String _darkMapStyle;
  late String _lightMapStyle;
  late BuildContext ctxx;

  @override
  void initState() {
    super.initState();
    SignalRRider().openConnection();

    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() => showLottie = false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    mainMapController.dispose();
    _controllerGoogleMap = null;
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ctxx = context;
    return WillPopScope(
      onWillPop: onWillpop,
      child: Scaffold(
          key: scaffoldKey,
          drawer: const MapDrawer(),
          body: ContainerMapBloc(builder: (
            AsyncSnapshot<Map<MarkerId, Marker>> marker,
            AsyncSnapshot<Map<PolylineId, Polyline>> polyline,
          ) {
            return Stack(
              children: [
                Animarker(
                  curve: Curves.linear,
                  useRotation: true,
                  shouldAnimateCamera: false,
                  angleThreshold: 0,
                  zoom: 20,
                  rippleColor: kPRIMARY,
                  rippleRadius: 0.8,
                  markers: Set.of(marker.data?.values ?? {}),
                  mapId: _controllerGoogleMap!.future
                      .then<int>((value) => value.mapId),
                  child: GoogleMap(
                    padding: EdgeInsets.only(bottom: bottomPadding, top: 25.0),
                    mapType: MapType.normal,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    initialCameraPosition: _kGooglePlex,
                    polylines: Set.of(polyline.data?.values ?? {}),
                    onCameraIdle: _onCameraIdle,
                    onCameraMove: _onCameraMove,
                    onMapCreated: (GoogleMapController controller) async {
                      _controllerGoogleMap!.complete(controller);
                      mainMapController = controller;
                      setState(() => bottomPadding = 220.0);
                      locatePosition();
                    },
                  ),
                ),

                MapPin(bottom: bottomPadding),

                //HamburgerButton for Drawer
                drawerButton(),

                /// this for location and destination #1
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: SizedBox(
                    height: searchContainerHeight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const HeaderLocDes(),
                        MapNextButton(
                          onTap: () {
                            displayRideDetailsContainer();
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                ///Ride Details Ui #2
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ChoiceCarsWidget(
                    height: rideDetailsContainerHeight,
                    directionDetails: directionDetails,
                    onTap: (carDetails) {
                      directionDetails?.type = carDetails.item1;
                      si<MapState>().pinData.directionDetails =
                          directionDetails;
                      displayRequestRideContainer(polyline, carDetails);
                    },
                  ),
                ),

                /// Searching on Driver #3
                SearchingOnDriverWidget(
                  height: requestRideContainerHeight,
                  onTap: () async {
                    BotToast.showLoading();
                    await si<SignalRService>().invoke(
                        hubUrl: hubUrl,
                        methodName: "RemoveDelivery",
                        args: <Object>[si<MapLiveProvider>().deliver!.id]);
                    resetApp();
                    BotToast.cleanAll();
                  },
                ),
                Visibility(
                  visible: showLottie,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xffffffff),
                    child: Lottie.asset(
                      'lotti_files/22770-hello-peep.json',
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ],
            );
          }),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          floatingActionButton: MapFloatActionsButton(
            directionTap: () {
              goToLocation(
                si<MapState>().pinData.destinationPoint,
              );
            },
            locationTap: () async {
              goToLocation(
                LatLng(
                  currentPosition?.latitude ?? 0,
                  currentPosition?.longitude ?? 0,
                ),
              );
            },
            themeTap: () {
              showModalBottomSheet(
                context: context,
                clipBehavior: Clip.antiAlias,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                builder: (context) => Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(20),
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "تغيير الثيم",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _mapThemes.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    mainMapController.setMapStyle(
                                        _mapThemes[index]['style']);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 100,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      //
                                      //     image: DecorationImage(
                                      //       fit: BoxFit.cover,
                                      //       image: NetworkImage(
                                      //         _mapThemes[index]['image'],
                                    ),
                                    //     )),
                                    child: Card(
                                      child: Image.network(
                                        _mapThemes[index]['image'],
                                        fit: BoxFit.fill,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    )),
              );
            },
          )),
    );
  }

  final List<dynamic> _mapThemes = [
    {
      'name': 'Sliver',
      'style': MapStyle().sliver,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0xf5f5f5&style=element:labels%7Cvisibility:off&style=element:labels.icon%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x616161&style=element:labels.text.stroke%7Ccolor:0xf5f5f5&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0xbdbdbd&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:poi%7Celement:geometry%7Ccolor:0xeeeeee&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:poi.park%7Celement:geometry%7Ccolor:0xe5e5e5&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:road%7Celement:geometry%7Ccolor:0xffffff&style=feature:road.arterial%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:road.highway%7Celement:geometry%7Ccolor:0xdadada&style=feature:road.highway%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:transit.line%7Celement:geometry%7Ccolor:0xe5e5e5&style=feature:transit.station%7Celement:geometry%7Ccolor:0xeeeeee&style=feature:water%7Celement:geometry%7Ccolor:0xc9c9c9&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    },
    {
      'name': 'Retro',
      'style': MapStyle().retro,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0xebe3cd&style=element:labels%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x523735&style=element:labels.text.stroke%7Ccolor:0xf5f1e6&style=feature:administrative%7Celement:geometry.stroke%7Ccolor:0xc9b2a6&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.land_parcel%7Celement:geometry.stroke%7Ccolor:0xdcd2be&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0xae9e90&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:landscape.natural%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:poi%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x93817c&style=feature:poi.park%7Celement:geometry.fill%7Ccolor:0xa5b076&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x447530&style=feature:road%7Celement:geometry%7Ccolor:0xf5f1e6&style=feature:road.arterial%7Celement:geometry%7Ccolor:0xfdfcf8&style=feature:road.highway%7Celement:geometry%7Ccolor:0xf8c967&style=feature:road.highway%7Celement:geometry.stroke%7Ccolor:0xe9bc62&style=feature:road.highway.controlled_access%7Celement:geometry%7Ccolor:0xe98d58&style=feature:road.highway.controlled_access%7Celement:geometry.stroke%7Ccolor:0xdb8555&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x806b63&style=feature:transit.line%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:transit.line%7Celement:labels.text.fill%7Ccolor:0x8f7d77&style=feature:transit.line%7Celement:labels.text.stroke%7Ccolor:0xebe3cd&style=feature:transit.station%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:water%7Celement:geometry.fill%7Ccolor:0xb9d3c2&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x92998d&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    },
    {
      'name': 'Dark',
      'style': MapStyle().dark,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0x212121&style=element:labels%7Cvisibility:off&style=element:labels.icon%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x757575&style=element:labels.text.stroke%7Ccolor:0x212121&style=feature:administrative%7Celement:geometry%7Ccolor:0x757575&style=feature:administrative.country%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.locality%7Celement:labels.text.fill%7Ccolor:0xbdbdbd&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:poi.park%7Celement:geometry%7Ccolor:0x181818&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:poi.park%7Celement:labels.text.stroke%7Ccolor:0x1b1b1b&style=feature:road%7Celement:geometry.fill%7Ccolor:0x2c2c2c&style=feature:road%7Celement:labels.text.fill%7Ccolor:0x8a8a8a&style=feature:road.arterial%7Celement:geometry%7Ccolor:0x373737&style=feature:road.highway%7Celement:geometry%7Ccolor:0x3c3c3c&style=feature:road.highway.controlled_access%7Celement:geometry%7Ccolor:0x4e4e4e&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:transit%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:water%7Celement:geometry%7Ccolor:0x000000&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x3d3d3d&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    },
    {
      'name': 'Night',
      'style': MapStyle().night,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0x242f3e&style=element:labels%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x746855&style=element:labels.text.stroke%7Ccolor:0x242f3e&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.locality%7Celement:labels.text.fill%7Ccolor:0xd59563&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0xd59563&style=feature:poi.park%7Celement:geometry%7Ccolor:0x263c3f&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x6b9a76&style=feature:road%7Celement:geometry%7Ccolor:0x38414e&style=feature:road%7Celement:geometry.stroke%7Ccolor:0x212a37&style=feature:road%7Celement:labels.text.fill%7Ccolor:0x9ca5b3&style=feature:road.highway%7Celement:geometry%7Ccolor:0x746855&style=feature:road.highway%7Celement:geometry.stroke%7Ccolor:0x1f2835&style=feature:road.highway%7Celement:labels.text.fill%7Ccolor:0xf3d19c&style=feature:transit%7Celement:geometry%7Ccolor:0x2f3948&style=feature:transit.station%7Celement:labels.text.fill%7Ccolor:0xd59563&style=feature:water%7Celement:geometry%7Ccolor:0x17263c&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x515c6d&style=feature:water%7Celement:labels.text.stroke%7Ccolor:0x17263c&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    },
    {
      'name': 'Aubergine',
      'style': MapStyle().aubergine,
      'image':
          'https://maps.googleapis.com/maps/api/staticmap?center=-33.9775,151.036&zoom=13&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0x1d2c4d&style=element:labels%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x8ec3b9&style=element:labels.text.stroke%7Ccolor:0x1a3646&style=feature:administrative.country%7Celement:geometry.stroke%7Ccolor:0x4b6878&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0x64779e&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:administrative.province%7Celement:geometry.stroke%7Ccolor:0x4b6878&style=feature:landscape.man_made%7Celement:geometry.stroke%7Ccolor:0x334e87&style=feature:landscape.natural%7Celement:geometry%7Ccolor:0x023e58&style=feature:poi%7Celement:geometry%7Ccolor:0x283d6a&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x6f9ba5&style=feature:poi%7Celement:labels.text.stroke%7Ccolor:0x1d2c4d&style=feature:poi.park%7Celement:geometry.fill%7Ccolor:0x023e58&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x3C7680&style=feature:road%7Celement:geometry%7Ccolor:0x304a7d&style=feature:road%7Celement:labels.text.fill%7Ccolor:0x98a5be&style=feature:road%7Celement:labels.text.stroke%7Ccolor:0x1d2c4d&style=feature:road.highway%7Celement:geometry%7Ccolor:0x2c6675&style=feature:road.highway%7Celement:geometry.stroke%7Ccolor:0x255763&style=feature:road.highway%7Celement:labels.text.fill%7Ccolor:0xb0d5ce&style=feature:road.highway%7Celement:labels.text.stroke%7Ccolor:0x023e58&style=feature:transit%7Celement:labels.text.fill%7Ccolor:0x98a5be&style=feature:transit%7Celement:labels.text.stroke%7Ccolor:0x1d2c4d&style=feature:transit.line%7Celement:geometry.fill%7Ccolor:0x283d6a&style=feature:transit.station%7Celement:geometry%7Ccolor:0x3a4762&style=feature:water%7Celement:geometry%7Ccolor:0x0e1626&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x4e6d70&size=164x132&key=AIzaSyDk4C4EBWgjuL1eBnJlu1J80WytEtSIags&scale=2'
    }
  ];

  void _onCameraMove(CameraPosition position) {
    if (CheckMapStatus.checkState(
      preState: StatusTripMap.init,
      nextState: StatusTripMap.selectLocation,
    )) {
      si<MapState>().pinData.currentPoint = position.target;
    } else if (CheckMapStatus.checkState(
      preState: StatusTripMap.selectLocation,
      nextState: StatusTripMap.selectDestination,
    )) {
      si<MapState>().pinData.destinationPoint = position.target;
    }
  }

  void _onCameraIdle() async {
    if (CheckMapStatus.checkState(
      preState: StatusTripMap.init,
      nextState: StatusTripMap.selectLocation,
    )) {
      si<MapState>().isCurrentLoading = true;
      si<MapBloc>().sinkSetMapState(si<MapState>());
      String currentAddress = await AssistantMethods.searchCoordinateAddress(
          si<MapState>().pinData.currentPoint);
      si<MapState>().isCurrentLoading = false;
      si<MapState>().pinData.pickUpAddress = currentAddress;
      si<MapBloc>().sinkSetMapState(si<MapState>());
    } else if (CheckMapStatus.checkState(
      preState: StatusTripMap.selectLocation,
      nextState: StatusTripMap.selectDestination,
    )) {
      si<MapState>().isDestinationLoading = true;
      si<MapBloc>().sinkSetMapState(si<MapState>());
      String currentAddress = await AssistantMethods.searchCoordinateAddress(
          si<MapState>().pinData.destinationPoint);

      si<MapState>().isDestinationLoading = false;
      si<MapState>().pinData.dropOffAddress = currentAddress;
      si<MapBloc>().sinkSetMapState(si<MapState>());
    }
  }

  get dialog => AwesomeDialog(
        context: context,
        dialogType: DialogType.NO_HEADER,
        animType: AnimType.RIGHSLIDE,
        customHeader: [
          Lottie.asset('lotti_files/87096-log-in.json'),
          Lottie.asset('lotti_files/11133-kicking-cats.json'),
          Lottie.asset('lotti_files/23100-happy-bird.json'),
          Lottie.asset('lotti_files/33187-rabbit-in-a-hat.json'),
        ][Random().nextInt(3)],
        headerAnimationLoop: true,
        title: 'الخروج',
        desc: 'هل حقا تريد  الخروج ؟',
        btnCancelText: 'نعم ',
        btnOkText: 'لا',
        btnOkOnPress: () {
          return false;
        },
        btnCancelOnPress: () {
          SystemNavigator.pop();

          return true;
        },
        btnCancelColor: kPRIMARY,
        btnOkColor: kRed4,
      ).show();

  Future<bool> onWillpop() async {
    switch (si<MapState>().next) {
      case StatusTripMap.selectLocation:
        {
          BotToast.showLoading();
          for (var item in set) {
            await si<SignalRService>().invoke(
                hubUrl: hubUrl, methodName: "RemoveDelivery", args: <Object>[item]);
          }
          BotToast.cleanAll();
          dialog;
          return false;
        }
      case StatusTripMap.selectDestination:
        {
          si<MapState>().next = StatusTripMap.selectLocation;
          si<MapState>().pre = StatusTripMap.init;
          si<MapState>().pinData.dropOffAddress = 'لم يتم التحديد بعد';
          si<MapBloc>().sinkSetMapState(si<MapState>());
          si<MapBloc>().deleteMarker(kCurrentMarkerId);
          resetApp();
          setState(() {});
        }
        break;
      case StatusTripMap.path:
        {
          si<MapState>().pre = StatusTripMap.selectLocation;
          si<MapState>().next = StatusTripMap.selectDestination;
          si<MapState>().pinData.dropOffAddress = 'لم يتم التحديد بعد';
          si<MapBloc>().sinkSetMapState(si<MapState>());
          si<MapBloc>().deleteMarker(kDestinationMarkerId);
          resetApp();
          setState(() {});
        }
        break;
      case StatusTripMap.routeData:
        {
          si<MapState>().pre = StatusTripMap.selectDestination;
          si<MapState>().next = StatusTripMap.path;
          si<MapBloc>().sinkSetMapState(si<MapState>());
          si<MapBloc>().clearPolyline();
          setState(() {});
        }
        break;

      default:
        {}
    }

    return false;
  }

  int calcPrice({required int distance, required int start}) {
    print('distance: $distance');
    int factor = start ~/ 2;
    print('factor: $factor');

    var temp = distance ~/ 250;
    print('temp: $temp');
    print('start: $start');

    return start + temp * factor;
  }

  Positioned drawerButton() {
    return Positioned(
      top: 36.0,
      right: 15.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (drawerOpen) {
                scaffoldKey.currentState?.openDrawer();
              } else {
                resetApp();
              }
            },
            child: Card(
              color: kPRIMARY,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: kPRIMARY,
                mini: true,
                heroTag: 'menu_or_search',
                tooltip: ' البحث ',
                onPressed: null,
                child: Icon(
                  (drawerOpen) ? Icons.menu : Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.to(() => const MapStoreScreen());
            },
            child: const Card(
              color: kPRIMARY,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: kPRIMARY,
                mini: true,
                heroTag: 'stores_main_map',
                tooltip: ' المتاجر ',
                onPressed: null,
                child: Icon(
                  Icons.storefront,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addDelivery(CarDetails carDetails) async {
    BotToast.showLoading();
    Delivers delivery = Delivers(
        id: '-',
        startLat: si<MapState>().pinData.currentPoint.latitude.toString(),
        startLong: si<MapState>().pinData.currentPoint.longitude.toString(),
        endLat: si<MapState>().pinData.destinationPoint.latitude.toString(),
        endLong: si<MapState>().pinData.destinationPoint.longitude.toString(),
        distance: si<MapState>().pinData.directionDetails?.distanceValue ?? 0,
        vehicleType: carDetails.item2,
        startDate: DateTime.now(),
        expectedTime:
            si<MapState>().pinData.directionDetails?.durationText ?? '',
        price: calcPrice(
            distance:
                si<MapState>().pinData.directionDetails?.distanceValue ?? 0,
            start: carDetails.item2),
        pickUp: si<MapState>().pinData.pickUpAddress,
        dropOff: si<MapState>().pinData.dropOffAddress);
    si<MapLiveProvider>().setDeliver = delivery;
    final data = await SignalRRider().addDelivery(deliver: delivery);
    set.add(data);
    delivery = delivery.copyWith(id: data);

    si<MapLiveProvider>().setDeliver = delivery;
    print("Add DeliveryData $data");
    BotToast.closeAllLoading();
    print("addDelivery \n${json.encode({
          "pickUp": si<MapState>().pinData.pickUpAddress,
          "dropOff": si<MapState>().pinData.dropOffAddress,
          "startLat": si<MapState>().pinData.currentPoint.latitude.toString(),
          "startLong": si<MapState>().pinData.currentPoint.longitude.toString(),
          "endLat":
              si<MapState>().pinData.destinationPoint.longitude.toString(),
          "price": calcPrice(
              distance:
                  si<MapState>().pinData.directionDetails?.distanceValue ?? 0,
              start: carDetails.item2),
          "endLong":
              si<MapState>().pinData.destinationPoint.longitude.toString(),
          "expectedTime": si<MapState>().pinData.directionDetails?.durationText,
          "distance": si<MapState>().pinData.directionDetails?.distanceValue
        })}");
  }

  void updateRideTimeToPickUpLoc(LatLng driverCurrentLocation) async {
    if (isRequestingPositionDetails == false) {
      isRequestingPositionDetails = true;

      var positionUserLatLng = LatLng(
          currentPosition?.latitude ?? 0, currentPosition?.longitude ?? 0);
      var details = await AssistantMethods.obtainPlaceDirectionDetails(
          driverCurrentLocation, positionUserLatLng);
      if (details == null) {
        return;
      }
      setState(() {});

      isRequestingPositionDetails = false;
    }
  }

  void updateRideTimeToDropOffLoc(LatLng driverCurrentLocation) async {
    if (isRequestingPositionDetails == false) {
      isRequestingPositionDetails = true;

      var dropOff = si<MapState>().pinData.destinationPoint;
      var dropOffUserLatLng = LatLng(dropOff.latitude, dropOff.longitude);

      var details = await AssistantMethods.obtainPlaceDirectionDetails(
          driverCurrentLocation, dropOffUserLatLng);
      if (details == null) {
        return;
      }
      setState(() {});

      isRequestingPositionDetails = false;
    }
  }

  void displayRequestRideContainer(polyline, carDetails) {
    setState(() {
      requestRideContainerHeight = 400.0;
      rideDetailsContainerHeight = 0;
      bottomPadding = 420.0;
      drawerOpen = false;
    });
    si<MapBloc>().setMapFitToTour(Set.of(polyline.data?.values ?? {}));
    addDelivery(carDetails);
  }

  void displayDriverDetailsContainer() {
    setState(() {
      requestRideContainerHeight = 0.0;
      rideDetailsContainerHeight = 0.0;
      bottomPadding = 295.0;
      driverDetailsContainerHeight = 285.0;
    });
  }

  resetApp() async {
    _controllerGoogleMap = Completer();

    setState(() {
      drawerOpen = true;
      searchContainerHeight = 220.0;
      rideDetailsContainerHeight = 0;
      requestRideContainerHeight = 0;
      bottomPadding = 230.0;
      si<MapBloc>().clearPolyline();
      si<MapBloc>().clearMarkers();
      si<MapState>().pre = StatusTripMap.init;
      si<MapState>().next = StatusTripMap.selectLocation;
      si<MapState>().pinData.dropOffAddress = 'لم يتم التحديد بعد';

      driverDetailsContainerHeight = 0.0;
    });
    BotToast.closeAllLoading();
    locatePosition();
  }

  void displayRideDetailsContainer() async {
    await getPlaceDirection();
    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 290.0;
      bottomPadding = 290.0;
      drawerOpen = false;
    });
  }

  void locatePosition() async {
    // await Geolocator.requestPermission();
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      //nothing
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLatPosition, zoom: 18, bearing: 0, tilt: 0);
    mainMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods.searchCoordinateAddress(
        LatLng(position.latitude, position.longitude));
    print("This is your Address :: $address");
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 18,
      bearing: 0,
      tilt: 0);

  Future<void> getPlaceDirection() async {
    var initialPos = si<MapState>().pinData.currentPoint;
    var finalPos = si<MapState>().pinData.destinationPoint;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);

    si<MapState>().pinData.directionDetails = details;
    setState(() {
      directionDetails = details;
    });
  }

  void noDriverFound() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const NoDriverAvailableDialog());
  }
}
