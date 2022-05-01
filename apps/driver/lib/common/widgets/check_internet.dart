import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/rxdart.dart';

import 'check_connection_state.dart';

class CheckInternetWidget extends StatefulWidget {
  const CheckInternetWidget({Key? key}) : super(key: key);

  @override
  _CheckInternetWidgetState createState() => _CheckInternetWidgetState();
}

class _CheckInternetWidgetState extends State<CheckInternetWidget> {
  late StreamSubscription<InternetConnectionStatus> _dataConnectionListener;
  late StreamSubscription<ConnectivityResult> _connectivityListener;
  late final BehaviorSubject<bool> appHasInternetConnection;
  late final BehaviorSubject<bool> appIsConnected;

  @override
  void initState() {
    super.initState();
    appHasInternetConnection = BehaviorSubject<bool>.seeded(true); // y
    appIsConnected = BehaviorSubject<bool>.seeded(true);
    _listenToNetworkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: true,
        stream: appIsConnected.stream,
        builder: (context, appIsConnected) {
          return StreamBuilder<bool>(
              initialData: true,
              stream: appHasInternetConnection.stream,
              builder: (context, appHasInternetConnection) {
                return ConnectStateWidget(
                  isConnected:
                      (appHasInternetConnection.data! && appIsConnected.data!),
                );
              });
        });
  }

  _listenToNetworkConnection() {
    _connectivityListener = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi) {
          appIsConnected.sink.add(true);
        } else {
          appIsConnected.sink.add(false);
        }
      },
    );
    final dataConnectionChecker = InternetConnectionChecker()
      ..checkInterval = const Duration(seconds: 4);
    _dataConnectionListener =
        dataConnectionChecker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          appHasInternetConnection.sink.add(true);
          break;
        case InternetConnectionStatus.disconnected:
          appHasInternetConnection.sink.add(false);
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _dataConnectionListener.cancel();
    _connectivityListener.cancel();
  }
}
