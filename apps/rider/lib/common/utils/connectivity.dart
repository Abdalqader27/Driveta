// Created By Abed
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SConnectivity {
  final InternetConnectionChecker? internetChecker;

  SConnectivity({required this.internetChecker});

  Future<bool> get isConnected async {
    return internetChecker!.hasConnection;
  }
}
