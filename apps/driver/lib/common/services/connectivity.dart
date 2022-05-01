import 'package:internet_connection_checker/internet_connection_checker.dart';

class Connectivity {
  final InternetConnectionChecker internetChecker;

  Connectivity({required this.internetChecker});

  Future<bool> get isConnected async {
    return internetChecker.hasConnection;
  }
}
