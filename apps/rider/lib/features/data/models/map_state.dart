import 'trip_data.dart';

class MapState {
  final bool showLocationBtn;
  final bool showDestinationBtn;
  final bool showDriverBtn;
  final String title;
  final String subtitle;
  TripData pinData;
  bool isCurrentLoading;
  bool isDestinationLoading;
  bool hideHeader;
  StatusTripMap pre;
  StatusTripMap next;

  MapState({
    this.showLocationBtn = true,
    this.showDestinationBtn = false,
    this.showDriverBtn = false,
    this.hideHeader = false,
    this.title = '',
    this.subtitle = '',
    this.isCurrentLoading = false,
    this.isDestinationLoading = false,
    required this.pinData,
    this.pre = StatusTripMap.init,
    this.next = StatusTripMap.selectLocation,
  });

  void swapState() {
    pre = next;
  }
}

enum StatusTripMap {
  init,
  selectLocation,
  selectDestination,
  path,
  routeData,
  startTrip,
  driverOnHisWay,
  caughtUser,
  endTrip
}
