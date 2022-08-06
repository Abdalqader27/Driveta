import 'dart:convert';import 'package:get/get.dart';import 'package:get/get_core/src/get_main.dart';import 'package:google_maps_flutter/google_maps_flutter.dart';import 'package:rider/common/utils/signal_r_new.dart';import 'package:rider/features/data/models/delivers.dart';import 'package:rider/features/data/models/delivers_product.dart';import 'package:rider/features/presentation/pages/map/map_trip_product/map_trip_product.dart';import 'package:rider/main.dart';import '../../blocs/map_bloc.dart';import '../../features/data/models/driver.dart';import '../../features/data/models/marker_config.dart';import '../../features/injection/injection_network.dart';import '../../features/presentation/pages/map/map_trip_live/map_trip_live.dart';import '../../features/presentation/pages/map/map_trip_live/providers/map_live_provider.dart';import '../../features/presentation/pages/map/map_trip_product/provider/map_trip_provider.dart';import '../../generated/assets.dart';// Configer the loggingconst hubUrl = '$kBase' 'deliveryHub/';class SignalRRider {  static final SignalRRider _instance = SignalRRider._();  static const String connectionIsOpenPropName = "connectionIsOpen";  SignalRRider._();  factory SignalRRider() => _instance;  /// For open and close signal R  Future<bool> openConnection() async {    final hub = si<SignalRService>();    try {      await hub.openHub(hubUrl);      print("hub ${hub.isConnected(hubUrl)}");      hub.on(          hubUrl: hubUrl,          methodName: "ReceiveLocations",          method: onReceiveLocations);      hub.on(          hubUrl: hubUrl,          methodName: "ReceiveLocationsProduct",          method: onReceiveLocationsProduct);      hub.on(          hubUrl: hubUrl,          methodName: "ReceiveAcceptation",          method: onReceiveAcceptation);      hub.on(          hubUrl: hubUrl,          methodName: "ReceiveAcceptationProduct",          method: onReceiveAcceptationProduct);      hub.on(          hubUrl: hubUrl,          methodName: "ReceiveArrivedToLocation",          method: onReceiveArrivedToLocation);      hub.on(          hubUrl: hubUrl,          methodName: "ReceiveArrivedToLocationProduct",          method: onReceiveArrivedToLocationProduct);      hub.on(          hubUrl: hubUrl,          methodName: "ReceiveStarting",          method: onReceiveStarting);      hub.on(          hubUrl: hubUrl,          methodName: "ReceiveStartingProduct",          method: onReceiveStartingProduct);      hub.on(          hubUrl: hubUrl,          methodName: "ReceiveEndingCustomer",          method: onReceiveEndingCustomer);      hub.on(          hubUrl: hubUrl,          methodName: "ReceiveEndingCustomerProduct",          method: onReceiveEndingCustomerProduct);      hub.onClose(hubUrl, (e) => print("Connection Closed : $e"));      hub.onReconnecting(hubUrl, (e) => print("onٍReconnecting $e"));      hub.onReconnected(hubUrl, (id) => print("onReconnected $id"));      return true;    } catch (e) {      print("openHub error : $e");      return false;    }  }  Future<void> stopConnection() async {    print("stopConnection is fired ");    final hub = si<SignalRService>();    if (hub.isConnected('$kBase' 'deliveryHub/')) {      await hub.closeHub('$kBase' 'deliveryHub/');    }  }  //  ///1. AddDelivery (invoke) (Customer)  Future<void> addDelivery({required Delivers deliver}) async {    print("AddDelivery is fired ");    try {      si<SignalRService>().invoke(        hubUrl: hubUrl,        methodName: "AddDelivery",        args: <Object>[          {            'startLat': deliver.startLat.toString(),            'startLong': deliver.startLong.toString(),            'endLat': deliver.endLat.toString(),            'endLong': deliver.endLong.toString(),            'distance': deliver.distance,            'vehicleType': deliver.vehicleType,            'price': deliver.price,            'expectedTime': deliver.expectedTime,            'pickUp': deliver.pickUp.toString(),            'dropOff': deliver.dropOff.toString(),          }        ],      );      print("AddDelivery is sending data ${json.encode({            'startLat': deliver.startLat.toString(),            'startLong': deliver.startLong.toString(),            'endLat': deliver.endLat.toString(),            'endLong': deliver.endLong.toString(),            'distance': deliver.distance,            'vehicleType': deliver.vehicleType,            'price': deliver.price,            'expectedTime': deliver.expectedTime,            'pickUp': deliver.pickUp.toString(),            'dropOff': deliver.dropOff.toString(),          })} ");    } catch (e) {      print("AddDelivery is catching error $e ");      if (e          .toString()          .contains('Cannot send data if the connection is not in the')) {}    }  }  // }  Future<void> addDeliveryProduct(      {required DeliversProduct deliverProduct}) async {    print("AddDelivery Product is fired ");    try {      si<SignalRService>().invoke(        hubUrl: hubUrl,        methodName: "AddDeliveryProduct",        args: <Object>[          {            'startLat': deliverProduct.startLat.toString(),            'startLong': deliverProduct.startLong.toString(),            'endLat': deliverProduct.endLat.toString(),            'endLong': deliverProduct.endLong.toString(),            'distance': deliverProduct.distance,            'vehicleType': deliverProduct.vehicleType,            'price': deliverProduct.price,            'expectedTime': deliverProduct.expectedTime,            'pickUp': deliverProduct.pickUp.toString(),            'dropOff': deliverProduct.dropOff.toString(),            'details': deliverProduct.details.map((e) => e.toJson()).toList(),          }        ],      );      print("AddDelivery is sending data ${json.encode({            'startLat': deliverProduct.startLat.toString(),            'startLong': deliverProduct.startLong.toString(),            'endLat': deliverProduct.endLat.toString(),            'endLong': deliverProduct.endLong.toString(),            'distance': deliverProduct.distance,            'vehicleType': deliverProduct.vehicleType,            'price': deliverProduct.price,            'expectedTime': deliverProduct.expectedTime,            'pickUp': deliverProduct.pickUp.toString(),            'dropOff': deliverProduct.dropOff.toString(),            'details': deliverProduct.details.map((e) => e.toJson()).toList(),          })} ");    } catch (e) {      print("AddDelivery Product is catching error $e ");    }  }  Future<void> endDeliveryProductCustomer(      {required num price,      required String id,      required String endLat,      required String endLong,      required num distance,      required String dropOff,      required String expectedTime}) async {    print("EndDelivery Product Customer is fired ");    try {      si<SignalRService>().invoke(        hubUrl: hubUrl,        methodName: "EndDeliveryCustomerProduct",        args: <Object>[          {            'price': price,            'id': id,            'endLat': endLat,            'endLong': endLong,            'distance': distance,            'expectedTime': expectedTime,            'dropOff': dropOff          }        ],      );      print("EndDeliveryCustomerProduct is sending data ${json.encode({            'price': price,            'id': id,            'endLat': endLat,            'endLong': endLong,            'distance': distance,            'expectedTime': expectedTime,            'dropOff': dropOff          })} ");    } catch (e) {      print("EndDeliveryCustomerProduct is catching error $e ");    }  }  Future<void> endDeliveryCustomer(      {required num price,      required String id,      required String endLat,      required String endLong,      required num distance,      required String dropOff,      required String expectedTime}) async {    print("EndDeliveryCustomer is fired ");    try {      si<SignalRService>().invoke(        hubUrl: hubUrl,        methodName: "EndDeliveryCustomer",        args: <Object>[          {            'price': price,            'id': id,            'endLat': endLat,            'endLong': endLong,            'distance': distance,            'expectedTime': expectedTime,            'dropOff': dropOff          }        ],      );      print("EndDeliveryCustomer is sending data ${json.encode({            'price': price,            'id': id,            'endLat': endLat,            'endLong': endLong,            'distance': distance,            'expectedTime': expectedTime,            'dropOff': dropOff          })} ");    } catch (e) {      print("EndDeliveryCustomer is catching error $e ");    }  }//ReceiveAcceptation(Guid id) (on) (Customer) (driverId)// Notify by driver (Tell him that he had been accepted by driver blabla)  static void onReceiveAcceptation(List<Object>? arguments) {    print("ReceiveAcceptation $arguments");    if (arguments != null) {      final provider = si<MapLiveProvider>();      if (provider.selectedDriverId == null) {        provider.setSelectedDriverIdAndOpenTrip(arguments[0].toString());        Get.to(() => const MapTripLive());      }    }  }  void onReceiveLocations(List<Object>? arguments) {    if (arguments != null) {      print("ReceiveLocations ${json.encode(arguments[0])}");      for (var item in arguments[0] as List) {        final driver = Driver.fromJson(item);        si<MapLiveProvider>().addDriver(driver);        if (driver.lat != null && driver.long != null) {          si<MapBloc>().setMarker(MarkerConfig(            point:                LatLng(double.parse(driver.lat!), double.parse(driver.long!)),            pinPath: Assets.pinsDrivingPin,            markerId: MarkerId(driver.id.toString()),            snippet: '${driver.name}',            title: '${driver.isAvailable}',          ));        }      }    }  }//ReceiveLocations list drivers//Notify by driver (Tell him that he has reach the start location)// Here you should putting some text telling the customer that driver has arrived  static void onReceiveArrivedToLocation(List<Object>? arguments) {    print("ReceiveArrivedToLocation ${arguments}");    final provider = si<MapLiveProvider>();    provider.setStateTripProduct = provider.state.copyWith(number: 1);  }  static void onReceiveStarting(List<Object>? arguments) {    print("ReceiveStarting ${arguments}");    final provider = si<MapLiveProvider>();    provider.setStateTripProduct = provider.state.copyWith(number: 2);  }  //Here the customer has to pay to the driver and you should showing him a model of rating the driver  // Rating the driver request:  // [HttpPut]  // CustomerApp/RateDelivery(Guid id, double rate)  // Response: bool  // the id is deliveryId  static void onReceiveEndingCustomer(List<Object>? arguments) {    print("ReceiveEndingCustomer ${arguments}");    final provider = si<MapLiveProvider>();    provider.setStateTripProduct = provider.state.copyWith(number: 3);  }  /// PRODUCTS  void onReceiveLocationsProduct(List<Object>? arguments) {    if (arguments != null) {      print("ReceiveLocations product ${json.encode(arguments[0])}");      for (var item in arguments[0] as List) {        final driver = Driver.fromJson(item);        si<MapTripProvider>().addDriver(driver);      }    }  }  static void onReceiveAcceptationProduct(List<Object>? arguments) {    print("ReceiveAcceptationProduct $arguments");    if (arguments != null) {      final provider = si<MapTripProvider>();      if (provider.selectedDriverId == null) {        provider.setSelectedDriverIdAndOpenTrip(arguments[0].toString());        Get.to(() => const MapTripProduct());      }    }  }  static void onReceiveArrivedToLocationProduct(List<Object>? arguments) {    print("ReceiveArrivedToLocationProduct ${arguments}");    final provider = si<MapTripProvider>();    provider.setStateTripProduct = provider.state.copyWith(number: 1);  }  static void onReceiveStartingProduct(List<Object>? arguments) {    print("ReceiveStarting Product ${arguments}");    final provider = si<MapTripProvider>();    provider.setStateTripProduct = provider.state.copyWith(number: 2);  }  static void onReceiveEndingCustomerProduct(List<Object>? arguments) {    print("ReceiveEndingCustomerProduct ${arguments}");    final provider = si<MapTripProvider>();    provider.setStateTripProduct = provider.state.copyWith(number: 3);  }}