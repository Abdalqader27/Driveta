import 'location_data.dart';

class MapState {
  final bool showLocationBtn;
  final bool showDestinationBtn;
  final bool showDriverBtn;
  final String title;
  final String subtitle;
  PinData pinData;
  bool isCurrentLoading;
  bool isDestinationLoading;
  bool hideHeader;
  StatusMap pre;
  StatusMap next;

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
    this.pre = StatusMap.init,
    this.next = StatusMap.selectLocation,
  });

  void swapState() {
    pre = next;
  }
}

enum StatusMap {
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
