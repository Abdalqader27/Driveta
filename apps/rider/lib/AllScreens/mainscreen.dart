import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rider/AllScreens/HistoryScreen.dart';
import 'package:rider/AllScreens/aboutScreen.dart';
import 'package:rider/AllScreens/loginScreen.dart';
import 'package:rider/AllScreens/profileTabPage.dart';
import 'package:rider/AllScreens/ratingScreen.dart';
import 'package:rider/AllScreens/registerationScreen.dart';
import 'package:rider/AllScreens/searchScreen.dart';
import 'package:rider/AllScreens/widgets/header_location_destination.dart';
import 'package:rider/AllScreens/widgets/map_drawer.dart';
import 'package:rider/AllScreens/widgets/map_next_button.dart';
import 'package:rider/AllWidgets/CollectFareDialog.dart';
import 'package:rider/AllWidgets/Divider.dart';
import 'package:rider/AllWidgets/noDriverAvailableDialog.dart';
import 'package:rider/AllWidgets/progressDialog.dart';
import 'package:rider/Assistants/assistantMethods.dart';
import 'package:rider/Assistants/geoFireAssistant.dart';
import 'package:rider/DataHandler/appData.dart';
import 'package:rider/Models/directDetails.dart';
import 'package:rider/Models/history.dart';
import 'package:rider/Models/nearbyAvailableDrivers.dart';
import 'package:rider/common/config/theme/colors.dart';
import 'package:rider/configMaps.dart';
import 'package:rider/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/map_state.dart';
import '../Models/route_data.dart';
import '../blocs/container_map_bloc.dart';
import '../blocs/map_bloc.dart';
import '../common/utils/check_map_status.dart';
import '../common/utils/config.dart';
import '../common/widgets/map_pin.dart';
import '../libraries/el_widgets/widgets/responsive_padding.dart';
import '../libraries/init_app/run_app.dart';

late GoogleMapController newGoogleMapController;

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen";

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DirectionDetails? tripDirectionDetails;

  Position? currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  double rideDetailsContainerHeight = 0;
  double requestRideContainerHeight = 0;
  double searchContainerHeight = 220.0;
  double driverDetailsContainerHeight = 0;

  bool drawerOpen = true;
  bool nearbyAvailableDriverKeysLoaded = false;

  DatabaseReference? rideRequestRef;

  BitmapDescriptor? nearByIcon;

  List<NearbyAvailableDrivers>? availableDrivers;

  String state = "normal";

  StreamSubscription<dynamic>? rideStreamSubscription;

  bool isRequestingPositionDetails = false;

  String? uName = "";

  @override
  void initState() {
    super.initState();
    AssistantMethods.getCurrentOnlineUserInfo();
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
          AsyncSnapshot<RouteData> routeData,
          AsyncSnapshot<String> mapMode,
        ) {
          return Stack(
            children: [
              GoogleMap(
                padding: EdgeInsets.only(bottom: bottomPaddingOfMap, top: 25.0),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                initialCameraPosition: _kGooglePlex,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                polylines: Set.of(polyline.data?.values ?? {}),
                onCameraIdle: _onCameraIdle,
                onCameraMove: _onCameraMove,
                markers: Set.of(marker.data?.values ?? {}),
                onMapCreated: (GoogleMapController controller) {
                  _controllerGoogleMap.complete(controller);
                  newGoogleMapController = controller;
                  setState(() => bottomPaddingOfMap = 220.0);
                  locatePosition();
                },
              ),
              RPadding(
                child: const MapPin(),
                padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
              ),

              //HamburgerButton for Drawer
              drawerButton(),

              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
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

              //Ride Details Ui
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: AnimatedSize(
                  vsync: this,
                  curve: Curves.bounceIn,
                  duration: const Duration(milliseconds: 160),
                  child: Container(
                    height: rideDetailsContainerHeight,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17.0),
                      child: Column(
                        children: [
                          //bike ride
                          GestureDetector(
                            onTap: () {
                              displayToastMessage("searching Bike...", context);

                              setState(() {
                                state = "requesting";
                                carRideType = "bike";
                              });
                              displayRequestRideContainer();
                              availableDrivers = GeoFireAssistant.nearByAvailableDriversList;
                              searchNearestDriver();
                            },
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/bike.png",
                                      height: 70.0,
                                      width: 80.0,
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Bike",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: "Brand Bold",
                                          ),
                                        ),
                                        Text(
                                          ((tripDirectionDetails != null)
                                              ? "${tripDirectionDetails?.distanceText}"
                                              : ''),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      ((tripDirectionDetails != null)
                                          ? '\$${(AssistantMethods.calculateFares(tripDirectionDetails!)) / 2}'
                                          : ''),
                                      style: const TextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10.0),
                          const Divider(height: 2.0),
                          const SizedBox(height: 10.0),

                          //uber-go ride
                          GestureDetector(
                            onTap: () {
                              displayToastMessage("searching Uber-Go...", context);

                              setState(() {
                                state = "requesting";
                                carRideType = "uber-go";
                              });
                              displayRequestRideContainer();
                              availableDrivers = GeoFireAssistant.nearByAvailableDriversList;
                              searchNearestDriver();
                            },
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/ubergo.png",
                                      height: 70.0,
                                      width: 80.0,
                                    ),
                                    const SizedBox(width: 16.0),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Uber-Go",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: "Brand Bold",
                                          ),
                                        ),
                                        Text(
                                          ((tripDirectionDetails != null)
                                              ? "${tripDirectionDetails?.distanceText}"
                                              : ''),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      ((tripDirectionDetails != null)
                                          ? '\$${AssistantMethods.calculateFares(tripDirectionDetails!)}'
                                          : ''),
                                      style: const TextStyle(
                                        fontFamily: "Brand Bold",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10.0),
                          const Divider(height: 2.0),
                          const SizedBox(height: 10.0),

                          //uber-x ride
                          GestureDetector(
                            onTap: () {
                              displayToastMessage("searching Uber-X...", context);

                              setState(() {
                                state = "requesting";
                                carRideType = "uber-x";
                              });
                              displayRequestRideContainer();
                              availableDrivers = GeoFireAssistant.nearByAvailableDriversList;
                              searchNearestDriver();
                            },
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/uberx.png",
                                      height: 70.0,
                                      width: 80.0,
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Uber-X",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: "Brand Bold",
                                          ),
                                        ),
                                        Text(
                                          ((tripDirectionDetails != null)
                                              ? "${tripDirectionDetails?.distanceText}"
                                              : ''),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      ((tripDirectionDetails != null)
                                          ? '\$${(AssistantMethods.calculateFares(tripDirectionDetails!)) * 2}'
                                          : ''),
                                      style: const TextStyle(
                                        fontFamily: "Brand Bold",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10.0,
                          ),

                          const SizedBox(
                            height: 10.0,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: const [
                                Icon(
                                  FontAwesomeIcons.moneyCheckAlt,
                                  size: 18.0,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Text("Cash"),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black54,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              //Cancel Ui
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0.5,
                        blurRadius: 16.0,
                        color: Colors.black54,
                        offset: const Offset(0.7, 0.7),
                      ),
                    ],
                  ),
                  height: requestRideContainerHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ColorizeAnimatedTextKit(
                            onTap: () {
                              print("Tap Event");
                            },
                            text: const [
                              "Requesting a Ride...",
                              "Please wait...",
                              "Finding a Driver...",
                            ],
                            textStyle: const TextStyle(fontSize: 55.0, fontFamily: "Signatra"),
                            colors: const [
                              Colors.green,
                              Colors.purple,
                              Colors.pink,
                              Colors.blue,
                              Colors.yellow,
                              Colors.red,
                            ],
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            cancelRideRequest();
                            resetApp();
                          },
                          child: Container(
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(26.0),
                              border: Border.all(width: 2.0, color: Colors.grey[300]!),
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 26.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: const Text(
                            "Cancel Ride",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //Display Assisned Driver Info
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: const Radius.circular(16.0),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      const BoxShadow(
                        spreadRadius: 0.5,
                        blurRadius: 16.0,
                        color: Colors.black54,
                        offset: Offset(0.7, 0.7),
                      ),
                    ],
                  ),
                  height: driverDetailsContainerHeight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              rideStatus,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20.0, fontFamily: "Brand Bold"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                        const Divider(
                          height: 2.0,
                          thickness: 2.0,
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                        Text(
                          carDetailsDriver,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          driverName,
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                        const Divider(
                          height: 2.0,
                          thickness: 2.0,
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //call button
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                onPressed: () async {
                                  launch(('tel://${driverphone}'));
                                },
                                color: Colors.black87,
                                child: Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Text(
                                        "Call Driver   ",
                                        style:
                                            TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.call,
                                        color: Colors.white,
                                        size: 26.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    if (CheckMapStatus.checkState(
      preState: StatusMap.init,
      nextState: StatusMap.selectLocation,
    )) {
      inj<MapState>().pinData.currentPoint = position.target;
    } else if (CheckMapStatus.checkState(
      preState: StatusMap.selectLocation,
      nextState: StatusMap.selectDestination,
    )) {
      inj<MapState>().pinData.destinationPoint = position.target;
    }
  }

  void _onCameraIdle() async {
    if (CheckMapStatus.checkState(
      preState: StatusMap.init,
      nextState: StatusMap.selectLocation,
    )) {
      inj<MapState>().isCurrentLoading = true;
      inj<MapBloc>().rxSetMapState(inj<MapState>());
      String currentAddress =
          await AssistantMethods.searchCoordinateAddress(inj<MapState>().pinData.currentPoint, context);

      inj<MapState>().isCurrentLoading = false;
      inj<MapState>().pinData.currentAddress = currentAddress ?? "حدث خطا ما ";
      inj<MapBloc>().rxSetMapState(inj<MapState>());

      // Logs.logger.i('${currentAddress?.address}');
    } else if (CheckMapStatus.checkState(
      preState: StatusMap.selectLocation,
      nextState: StatusMap.selectDestination,
    )) {
      inj<MapState>().isDestinationLoading = true;
      inj<MapBloc>().rxSetMapState(inj<MapState>());
      String currentAddress =
          await AssistantMethods.searchCoordinateAddress(inj<MapState>().pinData.destinationPoint, context);

      inj<MapState>().isDestinationLoading = false;
      inj<MapState>().pinData.destinationAddress = currentAddress ?? "حدث خطا ما ";
      inj<MapBloc>().rxSetMapState(inj<MapState>());
    }
  }

  Future<bool> onWillpop() async {
    switch (inj<MapState>().next) {
      case StatusMap.selectLocation:
        {
          return true;
        }
      case StatusMap.selectDestination:
        {
          inj<MapState>().next = StatusMap.selectLocation;
          inj<MapState>().pre = StatusMap.init;
          inj<MapState>().pinData.destinationAddress = 'لم يتم التحديد بعد';
          inj<MapBloc>().rxSetMapState(inj<MapState>());
          inj<MapBloc>().deleteMarker(kCurrentMarkerId);
        }
        break;
      case StatusMap.path:
        {
          inj<MapState>().pre = StatusMap.selectLocation;
          inj<MapState>().next = StatusMap.selectDestination;
          inj<MapBloc>().deleteMarker(kDestinationMarkerId);
          inj<MapState>().pinData.destinationAddress = 'لم يتم التحديد بعد';
          inj<MapBloc>().rxSetMapState(inj<MapState>());
        }
        break;
      case StatusMap.routeData:
        {
          inj<MapState>().pre = StatusMap.selectDestination;
          inj<MapState>().next = StatusMap.path;
          inj<MapBloc>().rxSetMapState(inj<MapState>());
          inj<MapBloc>().clearPolyline();
        }
        break;

      default:
        {}
    }
    return false;
  }

  Positioned drawerButton() {
    return Positioned(
      top: 36.0,
      left: 22.0,
      child: GestureDetector(
        onTap: () {
          if (drawerOpen) {
            scaffoldKey.currentState?.openDrawer();
          } else {
            resetApp();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: kPRIMARY,
            borderRadius: BorderRadius.circular(22.0),
          ),
          child: CircleAvatar(
            backgroundColor: kPRIMARY,
            child: Icon(
              (drawerOpen) ? Icons.menu : Icons.close,
              color: Colors.white,
            ),
            radius: 20.0,
          ),
        ),
      ),
    );
  }

  Container buildDrawer(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 255.0,
      child: Drawer(
        child: ListView(
          children: [
            //Drawer Header
            Container(
              height: 165.0,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    Image.asset(
                      "images/user_icon.png",
                      height: 65.0,
                      width: 65.0,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$uName",
                          style: const TextStyle(fontSize: 16.0, fontFamily: "Brand Bold"),
                        ),
                        const SizedBox(
                          height: 6.0,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileTabPage()));
                            },
                            child: const Text("Visit Profile")),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            DividerWidget(),

            const SizedBox(
              height: 12.0,
            ),

            //Drawer Body Contrllers
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryScreen()));
              },
              child: const ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  "History",
                  style: const TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileTabPage()));
              },
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Visit Profile",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
              },
              child: const ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
              },
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  "Sign Out",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveRideRequest() {
    rideRequestRef = FirebaseDatabase.instance.ref().child("Ride Requests").push();

    var pickUp = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var dropOff = Provider.of<AppData>(context, listen: false).dropOffLocation;

    Map pickUpLocMap = {
      "latitude": pickUp?.latitude.toString(),
      "longitude": pickUp?.longitude.toString(),
    };

    Map dropOffLocMap = {
      "latitude": dropOff?.latitude.toString(),
      "longitude": dropOff?.longitude.toString(),
    };

    Map rideInfoMap = {
      "driver_id": "waiting",
      "payment_method": "cash",
      "pickup": pickUpLocMap,
      "dropoff": dropOffLocMap,
      "created_at": DateTime.now().toString(),
      "rider_name": userCurrentInfo?.name,
      "rider_phone": userCurrentInfo?.phone,
      "pickup_address": pickUp?.placeName,
      "dropoff_address": dropOff?.placeName,
      "ride_type": carRideType,
    };

    rideRequestRef?.set(rideInfoMap);

    rideStreamSubscription = rideRequestRef?.onValue.listen((event) async {
      if (event.snapshot.value == null) {
        return;
      }

      if ((event.snapshot.value as Map)["car_details"] != null) {
        setState(() {
          carDetailsDriver = (event.snapshot.value as Map)["car_details"].toString();
        });
      }
      if ((event.snapshot.value as Map)["driver_name"] != null) {
        setState(() {
          driverName = (event.snapshot.value as Map)["driver_name"].toString();
        });
      }
      if ((event.snapshot.value as Map)["driver_phone"] != null) {
        setState(() {
          driverphone = (event.snapshot.value as Map)["driver_phone"].toString();
        });
      }

      if ((event.snapshot.value as Map)["driver_location"] != null) {
        double driverLat = double.parse((event.snapshot.value as Map)["driver_location"]["latitude"].toString());
        double driverLng = double.parse((event.snapshot.value as Map)["driver_location"]["longitude"].toString());
        LatLng driverCurrentLocation = LatLng(driverLat, driverLng);

        if (statusRide == "accepted") {
          updateRideTimeToPickUpLoc(driverCurrentLocation);
        } else if (statusRide == "onride") {
          updateRideTimeToDropOffLoc(driverCurrentLocation);
        } else if (statusRide == "arrived") {
          setState(() {
            rideStatus = "Driver has Arrived.";
          });
        }
      }

      if ((event.snapshot.value as Map)["status"] != null) {
        statusRide = (event.snapshot.value as Map)["status"].toString();
      }
      if (statusRide == "accepted") {
        displayDriverDetailsContainer();
        Geofire.stopListener();
        deleteGeofileMarkers();
      }
      if (statusRide == "ended") {
        if ((event.snapshot.value as Map)["fares"] != null) {
          int fare = int.parse((event.snapshot.value as Map)["fares"].toString());
          var res = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => CollectFareDialog(
              paymentMethod: "cash",
              fareAmount: fare,
            ),
          );

          String driverId = "";
          if (res == "close") {
            if ((event.snapshot.value as Map)["driver_id"] != null) {
              driverId = (event.snapshot.value as Map)["driver_id"].toString();
            }

            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RatingScreen(driverId: driverId)));

            rideRequestRef?.onDisconnect();
            rideRequestRef = null;
            rideStreamSubscription?.cancel();
            rideStreamSubscription = null;
            resetApp();
          }
        }
      }
    });
  }

  void deleteGeofileMarkers() {
    inj<MapBloc>().deleteMarker(kDriverMarkerId);
  }

  void updateRideTimeToPickUpLoc(LatLng driverCurrentLocation) async {
    if (isRequestingPositionDetails == false) {
      isRequestingPositionDetails = true;

      var positionUserLatLng = LatLng(currentPosition?.latitude ?? 0, currentPosition?.longitude ?? 0);
      var details = await AssistantMethods.obtainPlaceDirectionDetails(driverCurrentLocation, positionUserLatLng);
      if (details == null) {
        return;
      }
      setState(() {
        rideStatus = "Driver is Coming - " + "${details.durationText}";
      });

      isRequestingPositionDetails = false;
    }
  }

  void updateRideTimeToDropOffLoc(LatLng driverCurrentLocation) async {
    if (isRequestingPositionDetails == false) {
      isRequestingPositionDetails = true;

      var dropOff = Provider.of<AppData>(context, listen: false).dropOffLocation;
      var dropOffUserLatLng = LatLng(dropOff?.latitude ?? 0, dropOff?.longitude ?? 0);

      var details = await AssistantMethods.obtainPlaceDirectionDetails(driverCurrentLocation, dropOffUserLatLng);
      if (details == null) {
        return;
      }
      setState(() {
        rideStatus = "Going to Destination - " + "${details.durationText}";
      });

      isRequestingPositionDetails = false;
    }
  }

  void cancelRideRequest() {
    rideRequestRef?.remove();
    setState(() => state = "normal");
  }

  void displayRequestRideContainer() {
    setState(() {
      requestRideContainerHeight = 250.0;
      rideDetailsContainerHeight = 0;
      bottomPaddingOfMap = 230.0;
      drawerOpen = true;
    });

    saveRideRequest();
  }

  void displayDriverDetailsContainer() {
    setState(() {
      requestRideContainerHeight = 0.0;
      rideDetailsContainerHeight = 0.0;
      bottomPaddingOfMap = 295.0;
      driverDetailsContainerHeight = 285.0;
    });
  }

  resetApp() {
    setState(() {
      drawerOpen = true;
      searchContainerHeight = 220.0;
      rideDetailsContainerHeight = 0;
      requestRideContainerHeight = 0;
      bottomPaddingOfMap = 230.0;
      inj<MapBloc>().clearPolyline();
      inj<MapBloc>().clearMarkers();
      inj<MapState>().pre = StatusMap.init;
      inj<MapState>().next = StatusMap.selectLocation;
      inj<MapState>().pinData.destinationAddress = 'لم يتم التحديد بعد';

      statusRide = "";
      driverName = "";
      driverphone = "";
      carDetailsDriver = "";
      rideStatus = "Driver is Coming";
      driverDetailsContainerHeight = 0.0;
    });

    locatePosition();
  }

  void displayRideDetailsContainer() async {
    await getPlaceDirection();

    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 340.0;
      bottomPaddingOfMap = 360.0;
      drawerOpen = false;
    });
  }

  void locatePosition() async {
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(target: latLatPosition, zoom: 20);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await AssistantMethods.searchCoordinateAddress(LatLng(position.latitude, position.longitude), context);
    print("This is your Address :: " + address);

    initGeoFireListner();

    uName = userCurrentInfo?.name;

    AssistantMethods.retrieveHistoryInfo(context);
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<void> getPlaceDirection() async {
    var initialPos = inj<MapState>().pinData.currentPoint;
    var finalPos = inj<MapState>().pinData.destinationPoint;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    var details = await AssistantMethods.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng);
    setState(() {
      tripDirectionDetails = details;
    });
  }

  void initGeoFireListner() {
    Geofire.initialize("availableDrivers");
    //comment
    Geofire.queryAtLocation(currentPosition?.latitude ?? 0, currentPosition?.longitude ?? 0, 15)?.listen((map) {
      if (map != null) {
        var callBack = map['callBack'];

        switch (callBack) {
          case Geofire.onKeyEntered:
            NearbyAvailableDrivers nearbyAvailableDrivers = NearbyAvailableDrivers();
            nearbyAvailableDrivers.key = map['key'];
            nearbyAvailableDrivers.latitude = map['latitude'];
            nearbyAvailableDrivers.longitude = map['longitude'];
            GeoFireAssistant.nearByAvailableDriversList.add(nearbyAvailableDrivers);
            if (nearbyAvailableDriverKeysLoaded == true) {
              updateAvailableDriversOnMap();
            }
            break;

          case Geofire.onKeyExited:
            GeoFireAssistant.removeDriverFromList(map['key']);
            updateAvailableDriversOnMap();
            break;

          case Geofire.onKeyMoved:
            NearbyAvailableDrivers nearbyAvailableDrivers = NearbyAvailableDrivers();
            nearbyAvailableDrivers.key = map['key'];
            nearbyAvailableDrivers.latitude = map['latitude'];
            nearbyAvailableDrivers.longitude = map['longitude'];
            GeoFireAssistant.updateDriverNearbyLocation(nearbyAvailableDrivers);
            updateAvailableDriversOnMap();
            break;

          case Geofire.onGeoQueryReady:
            updateAvailableDriversOnMap();
            break;
        }
      }

      setState(() {});
    });
    //comment
  }

  void updateAvailableDriversOnMap() {
    inj<MapBloc>().clearMarkers();

    // setState(() {
    //   markersSet.clear();
    // });

    for (NearbyAvailableDrivers driver in GeoFireAssistant.nearByAvailableDriversList) {
      LatLng driverAvaiablePosition = LatLng(driver.latitude ?? 0, driver.longitude ?? 0);
      inj<MapBloc>().setMarker(kDriverMarker(driverAvaiablePosition));
    }
  }

  void createIconMarker() {
    if (nearByIcon == null) {
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: const Size(2, 2));
      BitmapDescriptor.fromAssetImage(imageConfiguration, "images/car_ios.png").then((value) {
        nearByIcon = value;
      });
    }
  }

  void noDriverFound() {
    showDialog(
        context: context, barrierDismissible: false, builder: (BuildContext context) => NoDriverAvailableDialog());
  }

  void searchNearestDriver() {
    if (availableDrivers!.isEmpty) {
      cancelRideRequest();
      resetApp();
      noDriverFound();
      return;
    }

    var driver = availableDrivers![0];

    driversRef.child(driver.key!).child("car_details").child("type").once().then((s) async {
      DataSnapshot snap = s.snapshot;
      if (snap.value != null) {
        String carType = snap.value.toString();
        if (carType == carRideType) {
          notifyDriver(driver);
          availableDrivers?.removeAt(0);
        } else {
          displayToastMessage(carRideType + " drivers not available. Try again.", context);
        }
      } else {
        displayToastMessage("No car found. Try again.", context);
      }
    });
  }

  void notifyDriver(NearbyAvailableDrivers driver) {
    driversRef.child(driver.key!).child("newRide").set(rideRequestRef!.key);

    driversRef.child(driver.key!).child("token").once().then((s) {
      DataSnapshot snap = s.snapshot;

      if (snap.value != null) {
        String token = snap.value.toString();
        AssistantMethods.sendNotificationToDriver(token, context, rideRequestRef!.key!);
      } else {
        return;
      }

      const oneSecondPassed = Duration(seconds: 1);
      Timer.periodic(oneSecondPassed, (timer) {
        if (state != "requesting") {
          driversRef.child(driver.key!).child("newRide").set("cancelled");
          driversRef.child(driver.key!).child("newRide").onDisconnect();
          driverRequestTimeOut = 40;
          timer.cancel();
        }

        driverRequestTimeOut = driverRequestTimeOut - 1;

        driversRef.child(driver.key!).child("newRide").onValue.listen((event) {
          if (event.snapshot.value.toString() == "accepted") {
            driversRef.child(driver.key!).child("newRide").onDisconnect();
            driverRequestTimeOut = 40;
            timer.cancel();
          }
        });

        if (driverRequestTimeOut == 0) {
          driversRef.child(driver.key!).child("newRide").set("timeout");
          driversRef.child(driver.key!).child("newRide").onDisconnect();
          driverRequestTimeOut = 40;
          timer.cancel();

          searchNearestDriver();
        }
      });
    });
  }
}
