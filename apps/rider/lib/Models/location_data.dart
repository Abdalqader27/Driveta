import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'directDetails.dart';

class TripData {
  LatLng currentPoint;
  LatLng destinationPoint;
  String pickUpAddress;
  String dropOffAddress;
  DirectionDetails? directionDetails;
  String city;

  TripData(
      {this.currentPoint = const LatLng(0, 0),
      this.destinationPoint = const LatLng(0, 0),
      this.directionDetails,
      this.pickUpAddress = ' لم يتم التحديد بعد',
      this.dropOffAddress = 'لم يتم التحديد بعد ',
      this.city = 'لم يتم التحديد بعد'});
}

class DataLocation {
  String? address;
  String? city;

  DataLocation({this.address, this.city});
}
