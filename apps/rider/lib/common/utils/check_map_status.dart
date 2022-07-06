import '../../Models/map_state.dart';
import '../../libraries/init_app/run_app.dart';

class CheckMapStatus {
  static bool checkState({
    required StatusTripMap preState,
    required StatusTripMap nextState,
  }) {
    return (si<MapState>().pre == preState && si<MapState>().next == nextState);
  }

  static bool checkCompleteState({
    required StatusTripMap preState,
    required StatusTripMap nextState,
  }) {
    if (si<MapState>().pre == preState && si<MapState>().next == nextState) {
      return true;
    } else if (si<MapState>().pre == StatusTripMap.selectDestination &&
        si<MapState>().next == StatusTripMap.path) {
      return true;
    } else if (si<MapState>().pre == StatusTripMap.path &&
        si<MapState>().next == StatusTripMap.startTrip) {
      return true;
    }
    return false;
  }

  static String getStatusName() {
    if (checkState(preState: StatusTripMap.init, nextState: StatusTripMap.selectLocation)) {
      return 'تحديد الموقع';
    } else if (checkState(
        preState: StatusTripMap.selectLocation, nextState: StatusTripMap.selectDestination)) {
      return 'تحديد الوجهة';
    } else if (checkState(
        preState: StatusTripMap.selectDestination, nextState: StatusTripMap.path)) {
      return 'تحديد المسار ';
    } else if (checkState(preState: StatusTripMap.path, nextState: StatusTripMap.routeData)) {
      return 'عرض التفاصيل';
    }
    return 'التالي ';
  }
}
