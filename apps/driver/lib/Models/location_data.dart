import 'package:google_maps_flutter/google_maps_flutter.dart';

class PinData {
  LatLng currentPoint;
  LatLng destinationPoint;
  String currentAddress;
  String destinationAddress;
  String city;

  PinData(
      {this.currentPoint = const LatLng(0, 0),
      this.destinationPoint = const LatLng(0, 0),
      this.currentAddress = ' لم يتم التحديد بعد',
      this.destinationAddress = 'لم يتم التحديد بعد ',
      this.city = 'لم يتم التحديد بعد'});
}

class DataLocation {
  String? address;
  String? city;

  DataLocation({this.address, this.city});
}
