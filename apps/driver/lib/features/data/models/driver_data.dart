import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverData {
  final int driverId;
  final LatLng currentLocation;
  final String carColor;
  final String carModelName;
  final String driverName;
  final String driverNumber;
  final String labelCar;

  DriverData(
      {required this.carColor,
      required this.carModelName,
      required this.driverName,
      required this.driverNumber,
      required this.labelCar,
      required this.driverId,
      required this.currentLocation});
}
