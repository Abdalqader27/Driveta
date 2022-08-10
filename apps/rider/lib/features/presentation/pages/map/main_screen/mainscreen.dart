import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
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
                    initialCameraPosition: _kGooglePlex,
                    myLocationEnabled: false,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
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
            //mapState: mapState.data!,
            directionTap: () {
              //inj<RealTime>().openConnection();
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
            themeTap: () async {},
          )),
    );
  }

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

  Future<bool> onWillpop() async {
    switch (si<MapState>().next) {
      case StatusTripMap.selectLocation:
        {
          return true;
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
    int factor = start ~/ 2;
    var temp = (distance / 250.0).round();
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
            distance: carDetails.item2,
            start: si<MapState>().pinData.directionDetails?.distanceValue ?? 0),
        pickUp: si<MapState>().pinData.pickUpAddress,
        dropOff: si<MapState>().pinData.dropOffAddress);
    si<MapLiveProvider>().setDeliver = delivery;
    final data = await SignalRRider().addDelivery(deliver: delivery);
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
          "price": AssistantMethods.calculateFares(directionDetails!),
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
    _controllerGoogleMap != Completer();

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
