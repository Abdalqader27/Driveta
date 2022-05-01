import 'dart:async';import 'package:driver/features/auth/presentation/pages/sgin_up/registeration_screen.dart';import 'package:driver/Assistants/assistantMethods.dart';import 'package:driver/Models/drivers.dart';import 'package:driver/Notifications/pushNotificationService.dart';import 'package:driver/common/config/theme/colors.dart';import 'package:driver/configMaps.dart';import 'package:driver/features/map_driver/presentation/pages/map_driver/widgets/map_app_bar.dart';import 'package:driver/features/map_driver/presentation/pages/map_driver/widgets/map_drawer.dart';import 'package:driver/features/map_driver/presentation/pages/map_driver/widgets/map_panel_widget.dart';import 'package:driver/main.dart';import 'package:firebase_auth/firebase_auth.dart';import 'package:firebase_database/firebase_database.dart';import 'package:flutter/material.dart';import 'package:flutter_animarker/core/ripple_marker.dart';import 'package:flutter_animarker/widgets/animarker.dart';import 'package:flutter_geofire/flutter_geofire.dart';import 'package:geolocator/geolocator.dart';import 'package:google_maps_flutter/google_maps_flutter.dart';import '../../../../../common/utils/config.dart';class MapDriverScreen extends StatefulWidget {  static const String idScreen = "mapDelivery";  static const CameraPosition _kGooglePlex = CameraPosition(    target: LatLng(37.42796133580664, -122.085749655962),    zoom: 14.4746,  );  const MapDriverScreen({Key? key}) : super(key: key);  @override  State<MapDriverScreen> createState() => _MapDriverScreenState();}class _MapDriverScreenState extends State<MapDriverScreen> {  final Completer<GoogleMapController> _controllerGoogleMap = Completer();  late GoogleMapController newGoogleMapController;  final Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};  final geoLocator = Geolocator();  late final GlobalKey<ScaffoldState> _key;  bool isDriverAvailable = false;  @override  void initState() {    super.initState();    _key = GlobalKey();    getCurrentDriverInfo();  }  @override  Widget build(BuildContext context) {    return Scaffold(        key: _key,        drawer: MapDrawer(          onClose: () {            Navigator.of(_key.currentState!.context).pop();          },        ),        body: Column(          children: [            MapAppBarWidget(              title: 'تطبيق السائق ',              onChanged: (value) {                if (value) {                  makeDriverOnlineNow();                  getLocationLiveUpdates();                  setState(() {                    isDriverAvailable = true;                  });                  displayToastMessage("you are Online Now.", context);                } else {                  makeDriverOfflineNow();                  setState(() {                    isDriverAvailable = false;                  });                  displayToastMessage("you are Offline Now.", context);                  locatePosition();                }              },              onPressed: () {                _key.currentState!.openDrawer();              },            ),            Expanded(              child: Stack(                children: [                  Animarker(                      curve: Curves.linear,                      duration: const Duration(milliseconds: 2000),                      useRotation: true,                      shouldAnimateCamera: false,                      angleThreshold: 0,                      zoom: 20,                      rippleColor: kPRIMARY,                      rippleRadius: 0.8,                      rippleDuration: const Duration(milliseconds: 3000),                      markers: _markers.values.toSet(),                      mapId: _controllerGoogleMap.future.then<int>((value) => value.mapId),                      child: GoogleMap(                        mapType: MapType.normal,                        myLocationButtonEnabled: true,                        initialCameraPosition: MapDriverScreen._kGooglePlex,                        myLocationEnabled: false,                        //markers: _markers.values.toSet(),                        onMapCreated: (GoogleMapController controller) {                          _controllerGoogleMap.complete(controller);                          newGoogleMapController = controller;                          locatePosition();                        },                      )),                  const MapPanelWidget(),                ],              ),            ),            //online offline driver Container          ],        ));  }  void getRideType() {    driversRef.child(currentfirebaseUser!.uid).child("car_details").child("type").once().then((s) {      DataSnapshot snapshot = s.snapshot;      if (snapshot.value != null) {        setState(() => rideType = snapshot.value.toString());      }    });  }  void getRatings() {    //update ratings    driversRef.child(currentfirebaseUser!.uid).child("ratings").once().then((s) {      DataSnapshot dataSnapshot = s.snapshot;      if (dataSnapshot.value != null) {        double ratings = double.parse(dataSnapshot.value.toString());        setState(() => starCounter = ratings);        if (starCounter <= 1.5) {          setState(() => title = "Very Bad");          return;        }        if (starCounter <= 2.5) {          setState(() => title = "Bad");          return;        }        if (starCounter <= 3.5) {          setState(() => title = "Good");          return;        }        if (starCounter <= 4.5) {          setState(() => title = "Very Good");          return;        }        if (starCounter <= 5.0) {          setState(() => title = "Excellent");          return;        }      }    });  }  void locatePosition() async {    await Geolocator.checkPermission();    await Geolocator.requestPermission();    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);    currentPosition = position;    LatLng latLatPosition = LatLng(position.latitude, position.longitude);    CameraPosition cameraPosition = CameraPosition(target: latLatPosition, zoom: 18, bearing: position.heading);    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));    final markerConfig = kDriverMarker(latLatPosition);    final Marker marker = await _marker(      markerId: markerConfig.markerId,      pinPath: markerConfig.pinPath,      point: markerConfig.point,      title: markerConfig.title,      snippet: markerConfig.snippet,    );    setState(() {      _markers[markerConfig.markerId] = marker;    });  }  void getCurrentDriverInfo() async {    currentfirebaseUser = FirebaseAuth.instance.currentUser;    driversRef.child(currentfirebaseUser!.uid).once().then((s) {      DataSnapshot dataSnapShot = s.snapshot;      if (dataSnapShot.value != null) {        driversInformation = Drivers.fromSnapshot(dataSnapShot);      }    });    PushNotificationService pushNotificationService = PushNotificationService();    pushNotificationService.initialize(context);    pushNotificationService.getToken();    AssistantMethods.retrieveHistoryInfo(context);    getRatings();    getRideType();  }  void makeDriverOnlineNow() async {    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);    currentPosition = position;    Geofire.initialize("availableDrivers");    Geofire.setLocation(currentfirebaseUser!.uid, currentPosition.latitude, currentPosition.longitude);    rideRequestRef?.set("searching");    rideRequestRef?.onValue.listen((event) {});  }  void getLocationLiveUpdates() async {    homeTabPageStreamSubscription = Geolocator.getPositionStream().listen((Position position) async {      currentPosition = position;      if (isDriverAvailable == true) {        Geofire.setLocation(currentfirebaseUser!.uid, position.latitude, position.longitude);      }      LatLng latLng = LatLng(position.latitude, position.longitude);      print(position.heading);      CameraPosition cameraPosition = CameraPosition(        target: latLng,        zoom: 18,        // bearing: position.heading / 10,      );      // newGoogleMapController.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));      newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));      final markerConfig = kDriverMarker(latLng);      final Marker marker = await _marker(        markerId: markerConfig.markerId,        pinPath: markerConfig.pinPath,        point: markerConfig.point,        title: markerConfig.title,        snippet: markerConfig.snippet,      );      setState(() {        _markers[markerConfig.markerId] = marker;      });    });  }  void makeDriverOfflineNow() {    Geofire.removeLocation(currentfirebaseUser!.uid);    rideRequestRef?.onDisconnect();    rideRequestRef?.remove();    rideRequestRef = null;  }  Future<Marker> _marker(      {required MarkerId markerId,      required LatLng point,      required String pinPath,      required String title,      required String snippet}) async {    return RippleMarker(      ripple: true, //Ripple state      icon: await BitmapDescriptor.fromAssetImage(        const ImageConfiguration(size: Size(200, 200)),        pinPath,      ),      // icon: BitmapDescriptor.defaultMarker,      markerId: markerId,      position: point,      infoWindow: InfoWindow(title: title, snippet: snippet),    );  }}