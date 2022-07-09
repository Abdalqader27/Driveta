import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../../blocs/map_bloc.dart';
import '../../../common/config/theme/colors.dart';
import '../../../common/utils/check_map_status.dart';
import '../../../common/utils/config.dart';
import '../../../common/utils/go_to.dart';
import '../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../../libraries/el_widgets/widgets/responsive_sized_box.dart';
import '../../../main.dart';
import '../../data/models/direct_details.dart';
import '../../data/models/map_state.dart';

late Future<DirectionDetails?> placeDirectionDetailsFuture;

class MapNextButton extends StatelessWidget {
  final Function() onTap;

  const MapNextButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MapState>(
        initialData: si<MapState>(),
        stream: si<MapBloc>().rxMapState,
        builder: (context, snapshot) {
          return CupertinoButton(
            onPressed: () async => await _nextTap(context),
            child: Center(
              child: Card(
                color: kPRIMARY,
                child: Center(
                  child: RPadding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.r, vertical: 10.r),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const RSizedBox.h16(),
                        MaterialText.button(CheckMapStatus.getStatusName(),
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: kWhite)),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<VoidCallback?> _nextTap(BuildContext context) async {
    if (CheckMapStatus.checkState(
      preState: StatusTripMap.init,
      nextState: StatusTripMap.selectLocation,
    )) {
      si<MapState>().swapState();
      si<MapState>().next = StatusTripMap.selectDestination;
      si<MapBloc>().sinkSetMapState(si<MapState>());
      si<MapBloc>().setMarker(
        kCurrentMarker(si<MapState>().pinData.currentPoint),
      );
      LatLng customCurrentPoint = LatLng(
          si<MapState>().pinData.currentPoint.latitude + 0.00009,
          si<MapState>().pinData.currentPoint.longitude + 0.0009);
      goToLocation(customCurrentPoint);
    } else if (CheckMapStatus.checkState(
      preState: StatusTripMap.selectLocation,
      nextState: StatusTripMap.selectDestination,
    )) {
      si<MapState>().swapState();
      si<MapState>().next = StatusTripMap.path;
      si<MapBloc>().sinkSetMapState(si<MapState>());
      si<MapBloc>().setMarker(
        kDestinationMarker(si<MapState>().pinData.destinationPoint),
      );
    } else if (CheckMapStatus.checkState(
      preState: StatusTripMap.selectDestination,
      nextState: StatusTripMap.path,
    )) {
      si<MapState>().swapState();
      si<MapState>().next = StatusTripMap.routeData;
      si<MapBloc>().sinkSetMapState(si<MapState>());
      onTap();
      si<MapBloc>().setPolyline(si<MapState>().pinData, kPolylineConfigWalk);
    } else if (CheckMapStatus.checkState(
      preState: StatusTripMap.path,
      nextState: StatusTripMap.routeData,
    )) {
      // placeDirectionDetailsFuture = AssistantMethods.obtainPlaceDirectionDetails(
      //   si<MapState>().pinData.currentPoint,
      //   si<MapState>().pinData.destinationPoint,
      // );
      // print((await placeDirectionDetailsFuture)?.distanceText);
    }
  }
}
