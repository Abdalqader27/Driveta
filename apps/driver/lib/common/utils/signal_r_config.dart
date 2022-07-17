import 'dart:convert';

import 'package:core/core.dart';
import 'package:driver/features/presentation/manager/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:driver/features/data/models/delivers.dart';

import 'package:logging/logging.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../../app_injection.dart';
import '../../features/injections/injection_network.dart';
import '../../features/presentation/manager/event.dart';
import '../../features/presentation/pages/map_driver/available_deliver.dart';

bool flagOpenPage = false;

class SignalRDriver {
  static late HubConnection? _hubConnection;
  static bool _connectionIsOpen = false;
  static const String connectionIsOpenPropName = "connectionIsOpen";

  static bool get connectionIsOpen => _connectionIsOpen;

  static final SignalRDriver _instance = SignalRDriver._();
  factory SignalRDriver() => _instance;


  SignalRDriver._() {
        _hubConnection = HubConnectionBuilder()
        .withUrl('$kBaseUrl' 'deliveryHub/',
            options: HttpConnectionOptions(
              requestTimeout: 700000,
              accessTokenFactory: () async {
                return si<SStorage>()
                    .get(key: kAccessToken, type: ValueType.string);
              },
            ))
        .withAutomaticReconnect()
        .build();

    _hubConnection!.serverTimeoutInMilliseconds = 100000000;
    _hubConnection!.keepAliveIntervalInMilliseconds = 100000000000000000;
    _hubConnection!.onclose(({error}) {
      _connectionIsOpen = false;
      print("Connection Closed");
    });
            _hubConnection!.on("ReceiveDeliveries", onReceiveDeliveries);
        _hubConnection!.on("ReceiveEndingDriver", onReceiveEndingDriver);

  }



  /// For open and close signal R
   Future<bool> openConnection() async {
    try {
  
      if (_hubConnection!.state != HubConnectionState.Connected) {
        await _hubConnection!.start();
        _connectionIsOpen = true;

        print('HubConnectionState.Connected is ${_hubConnection!.state}');
      } else {
        print(
            ' Already HubConnectionState.Connected is ${_hubConnection!.state}');
      }
      return true;
    } catch (e) {
      print("$e");
      return false;
    }
  }

   Future<void> stopConnection() async {
    print("stopConnection is fired ");
    if (_hubConnection!.state == HubConnectionState.Connected) {
      await _hubConnection!.stop();
      _hubConnection = null;
      _connectionIsOpen = false;
      print("stopConnection is done $_connectionIsOpen ");
    }
  }

   Future<void> sendLocation({LatLng? point}) async {
    print('HubConnectionState.Connected is ${_hubConnection!.state}');
    print("SendLocation is fired ");
    try {
      if (connectionIsOpen == false ||
          _hubConnection!.state != HubConnectionState.Connected) {
        await openConnection();
      }
      if (point != null) {
        _hubConnection!.invoke(
          "SendLocation",
          args: <Object>[point.longitude.toString(), point.latitude.toString()],
        );
        print("SendLocation is sending data $point ");

        //  print("SendLocation $point");
      }
    } catch (e) {
      print("SendLocation is catching error $e ");
    }
  }

  // /AcceptDelivery(Guid id) (invoke) (Driver) (deliveryId)
   Future<void> acceptDelivery({required String id}) async {
    print('HubConnectionState.Connected is ${_hubConnection!.state}');
    print("acceptDelivery is fired ");
    try {
      if (connectionIsOpen == false ||
          _hubConnection!.state != HubConnectionState.Connected) {
        await openConnection();
      }
     await _hubConnection!.invoke(
        "AcceptDelivery",
        args: <Object>[id],
      );
    
      
      print("AcceptDelivery is sending data $id ");
    } catch (e) {
      print("AcceptDelivery is catching error $e ");
    }
  }

   Future<void> arrivedToLocation({required String id}) async {
    print('HubConnectionState.Connected is ${_hubConnection!.state}');
    print("ArrivedToLocation is fired ");
    try {
      if (connectionIsOpen == false ||
          _hubConnection!.state != HubConnectionState.Connected) {
        await openConnection();
      }

      _hubConnection!.invoke(
        "ArrivedToLocation",
        args: <Object>[id],
      );
      print("ArrivedToLocation is sending data $id ");
    } catch (e) {
      print("ArrivedToLocation is catching error $e ");
    }
  }

   Future<void> startDelivery({required String id}) async {
    print('HubConnectionState.Connected is ${_hubConnection!.state}');
    print("StartDelivery is fired ");
    try {
      if (connectionIsOpen == false ||
          _hubConnection!.state != HubConnectionState.Connected) {
        await openConnection();
      }
      _hubConnection!.invoke(
        "StartDelivery",
        args: <Object>[id],
      );
      print("StartDelivery is sending data $id ");
    } catch (e) {
      print("StartDelivery is catching error $e ");
    }
  }

   Future<void> endDeliveryDriver(
      {required num price,
      required String id,
      required String endLat,
      required String endLong,
      required num distance,
      required String dropOff,
      required String expectedTime}) async {
    print('HubConnectionState.Connected is ${_hubConnection!.state}');
    print("EndDeliveryDriver is fired ");
    try {
      if (_hubConnection!.state != HubConnectionState.Connected) {
        await openConnection();
      }
      _hubConnection!.invoke(
        "EndDeliveryDriver",
        args: <Object>[
          {
            'price': price,
            'id': id,
            'endLat': endLat,
            'endLong': endLong,
            'distance': distance,
            'expectedTime': expectedTime,
            'dropOff': dropOff
          }
        ],
      );
      print("EndDeliveryDriver is sending data ${json.encode({
            'price': price,
            'id': id,
            'endLat': endLat,
            'endLong': endLong,
            'distance': distance,
            'expectedTime': expectedTime,
            'dropOff': dropOff
          })} ");
    } catch (e) {
      print("EndDeliveryDriver is catching error $e ");
    }
  }

   void onReceiveDeliveries(List<Object>? arguments) {
    print("onReceiveDeliveries $arguments");
    if (arguments != null) {
      List<Delivers> delivers = [];
      for (var item in arguments[0] as List) {
        delivers.add(Delivers.fromJson(item));
      }
      // need to call bloc to update the list of delivers
      // si<DriverBloc>().add(GetAvailableDeliveries(delivers));
      deliversStream.sink.add(delivers);
      if (flagOpenPage == false) {
        Get.to(() => const AvailableDeliveries());
        flagOpenPage = true;
      }
    }
  }

   void onReceiveEndingDriver(List<Object>? arguments) {
    print("ReceiveEndingDriver $arguments");
  }
}
