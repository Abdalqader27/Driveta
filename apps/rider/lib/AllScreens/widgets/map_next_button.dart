import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../Assistants/assistantMethods.dart';
import '../../Models/directDetails.dart';
import '../../Models/map_state.dart';
import '../../blocs/map_bloc.dart';
import '../../common/config/theme/colors.dart';
import '../../common/utils/check_map_status.dart';
import '../../common/utils/config.dart';
import '../../common/utils/go_to.dart';
import '../../libraries/el_widgets/widgets/material_text.dart';
import '../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../libraries/el_widgets/widgets/responsive_sized_box.dart';
import '../../libraries/init_app/run_app.dart';

late Future<DirectionDetails?> placeDirectionDetailsFuture;

class MapNextButton extends StatelessWidget {
  final Function() onTap;

  const MapNextButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MapState>(
        initialData: inj<MapState>(),
        stream: inj<MapBloc>().rxMapState,
        builder: (context, snapshot) {
          return CupertinoButton(
            onPressed: () => _nextTap(context),
            child: Center(
              child: Card(
                color: kPRIMARY,
                child: Center(
                  child: RPadding(
                    padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 10.r),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const RSizedBox.h16(),
                        MaterialText.button(CheckMapStatus.getStatusName(),
                            style: Theme.of(context).textTheme.button!.copyWith(color: kWhite)),
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

  VoidCallback? _nextTap(BuildContext context) {
    if (CheckMapStatus.checkState(
      preState: StatusMap.init,
      nextState: StatusMap.selectLocation,
    )) {
      inj<MapState>().swapState();
      inj<MapState>().next = StatusMap.selectDestination;
      inj<MapBloc>().rxSetMapState(inj<MapState>());
      inj<MapBloc>().setMarker(
        kCurrentMarker(inj<MapState>().pinData.currentPoint),
      );
      LatLng customCurrentPoint = LatLng(inj<MapState>().pinData.currentPoint.latitude + 0.00009,
          inj<MapState>().pinData.currentPoint.longitude + 0.0009);
      goToLocation(customCurrentPoint);
    } else if (CheckMapStatus.checkState(
      preState: StatusMap.selectLocation,
      nextState: StatusMap.selectDestination,
    )) {
      inj<MapState>().swapState();
      inj<MapState>().next = StatusMap.path;
      inj<MapBloc>().rxSetMapState(inj<MapState>());
      inj<MapBloc>().setMarker(
        kDestinationMarker(inj<MapState>().pinData.destinationPoint),
      );
    } else if (CheckMapStatus.checkState(
      preState: StatusMap.selectDestination,
      nextState: StatusMap.path,
    )) {
      inj<MapState>().swapState();
      inj<MapState>().next = StatusMap.routeData;
      inj<MapBloc>().rxSetMapState(inj<MapState>());
      onTap();
      inj<MapBloc>().setPolyline(inj<MapState>().pinData, kPolylineConfigWalk);
    } else if (CheckMapStatus.checkState(
      preState: StatusMap.path,
      nextState: StatusMap.routeData,
    )) {
      placeDirectionDetailsFuture = AssistantMethods.obtainPlaceDirectionDetails(
        inj<MapState>().pinData.currentPoint,
        inj<MapState>().pinData.destinationPoint,
      );
      // showCupertinoModalBottomSheet(
      //   context: context,
      //   builder: (context) => const DistanceTimeWidget(),
      // );
    }
  }
}
