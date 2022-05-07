import '../../Models/map_state.dart';
import '../../libraries/init_app/run_app.dart';

class CheckMapStatus {
  static bool checkState({
    required StatusMap preState,
    required StatusMap nextState,
  }) {
    return (inj<MapState>().pre == preState && inj<MapState>().next == nextState);
  }

  static bool checkCompleteState({
    required StatusMap preState,
    required StatusMap nextState,
  }) {
    if (inj<MapState>().pre == preState && inj<MapState>().next == nextState) {
      return true;
    } else if (inj<MapState>().pre == StatusMap.selectDestination && inj<MapState>().next == StatusMap.path) {
      return true;
    } else if (inj<MapState>().pre == StatusMap.path && inj<MapState>().next == StatusMap.startTrip) {
      return true;
    }
    return false;
  }

  static String getStatusName() {
    if (checkState(preState: StatusMap.init, nextState: StatusMap.selectLocation)) {
      return 'تحديد الموقع';
    } else if (checkState(preState: StatusMap.selectLocation, nextState: StatusMap.selectDestination)) {
      return 'تحديد الوجهة';
    } else if (checkState(preState: StatusMap.selectDestination, nextState: StatusMap.path)) {
      return 'تحديد المسار ';
    } else if (checkState(preState: StatusMap.path, nextState: StatusMap.routeData)) {
      return 'عرض التفاصيل';
    }
    return 'التالي ';
  }
}
