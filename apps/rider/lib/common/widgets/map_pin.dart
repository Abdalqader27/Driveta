import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/map_bloc.dart';
import '../../features/data/models/map_state.dart';
import '../../generated/assets.dart';
import '../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../main.dart';
import '../utils/check_map_status.dart';

class MapPin extends StatelessWidget {
  final double bottom;

  const MapPin({Key? key, required this.bottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: EdgeInsets.only(bottom: bottom),
      child: IgnorePointer(
        child: StreamBuilder<MapState>(
            stream: si<MapBloc>().rxMapState,
            initialData: si<MapState>(),
            builder: (context, snapshot) {
              if (CheckMapStatus.checkState(
                      preState: StatusTripMap.init,
                      nextState: StatusTripMap.selectLocation) ||
                  CheckMapStatus.checkState(
                      preState: StatusTripMap.selectLocation,
                      nextState: StatusTripMap.selectDestination)) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        CheckMapStatus.checkState(
                                preState: StatusTripMap.init,
                                nextState: StatusTripMap.selectLocation)
                            ? Assets.iconsIcSetloc
                            : CheckMapStatus.checkState(
                                    preState: StatusTripMap.selectLocation,
                                    nextState: StatusTripMap.selectDestination)
                                ? Assets.iconsIcPick
                                : '',
                        height: 50.r,
                        width: 50.r,
                        //color: Theme.of(context).iconTheme.color,
                        // color: isDark ? Colors.white : Colors.black.withOpacity(0.7),,
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
