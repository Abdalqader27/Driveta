import 'dart:convert';

import 'package:core/core.dart';
import 'package:driver/features/presentation/manager/bloc.dart';
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

  /// For open and close signal R
  static Future<bool> openConnection() async {
    try {
      _hubConnection = HubConnectionBuilder()
          .withUrl('http://driveta2-001-site1.itempurl.com/deliveryHub/',
              options: HttpConnectionOptions(
        accessTokenFactory: () async {
          return si<SStorage>().get(key: kAccessToken, type: ValueType.string);
        },
      )).build();

      if (_hubConnection!.state != HubConnectionState.Connected) {
        await _hubConnection!.start();
        _connectionIsOpen = true;
        _hubConnection!.on("ReceiveDeliveries", onReceiveDeliveries);
        _hubConnection!.on("ReceiveEndingDriver", onReceiveEndingDriver);

        print("SignalR_is_hasConnection is $_connectionIsOpen");
      } else {
        print("Signal R is Connected");
      }
      return true;
    } catch (e) {
      print("$e");
      return false;
    }
  }

  static Future<void> stopConnection() async {
    if (_hubConnection!.state == HubConnectionState.Connected) {
      await _hubConnection!.stop();
      _hubConnection = null;
      _connectionIsOpen = false;
      print("SignalR is has$_connectionIsOpen");
    }
  }

  static Future<void> sendLocation({LatLng? point}) async {
    print('HubConnectionState.Connected is ${_hubConnection!.state}');
    try {
      if (connectionIsOpen == false ||
          _hubConnection!.state != HubConnectionState.Connected) {
        await openConnection();
      }
      if (point != null) {
        print("SendLocation $point");

        _hubConnection!.invoke(
          "SendLocation",
          args: <Object>[point.longitude.toString(), point.latitude.toString()],
        );
        //  print("SendLocation $point");
      }
    } catch (e) {
      print("SendLocation $e");
    }
  }

  ///AcceptDelivery(Guid id) (invoke) (Driver) (deliveryId)
  static Future<void> acceptDelivery({required String id}) async {
    try {
      if (connectionIsOpen == false ||
          _hubConnection!.state != HubConnectionState.Connected) {
        await openConnection();
      }
      _hubConnection!.invoke(
        "AcceptDelivery",
        args: <Object>[id],
      );
    } catch (_) {}
  }

  static Future<void> startDelivery({required String id}) async {
    try {
      if (connectionIsOpen == false ||
          _hubConnection!.state != HubConnectionState.Connected) {
        await openConnection();
      }
      _hubConnection!.invoke(
        "StartDelivery",
        args: <Object>[id],
      );
    } catch (_) {}
  }

  static Future<void> endDeliveryDriver(
      {required num price,
      required String id,
      required String endLat,
      required String endLong,
      required num distance,
      required String dropOff,
      required String expectedTime}) async {
    try {
      if (connectionIsOpen == false ||
          _hubConnection!.state != HubConnectionState.Connected) {
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
    } catch (_) {}
  }

  static void onReceiveDeliveries(List<Object>? arguments) {
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

  static void onReceiveEndingDriver(List<Object>? arguments) {
    print("ReceiveEndingDriver $arguments");
  }
}
