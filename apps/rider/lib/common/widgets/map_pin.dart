import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../Models/map_state.dart';
import '../../blocs/map_bloc.dart';
import '../../generated/assets.dart';
import '../../libraries/init_app/run_app.dart';
import '../utils/check_map_status.dart';

class MapPin extends StatelessWidget {
  const MapPin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: StreamBuilder<MapState>(
          stream: inj<MapBloc>().rxMapState,
          initialData: inj<MapState>(),
          builder: (context, snapshot) {
            print("ssss" + (snapshot.data).toString());
            if (CheckMapStatus.checkState(preState: StatusMap.init, nextState: StatusMap.selectLocation) ||
                CheckMapStatus.checkState(preState: StatusMap.selectLocation, nextState: StatusMap.selectDestination)) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      CheckMapStatus.checkState(preState: StatusMap.init, nextState: StatusMap.selectLocation)
                          ? Assets.iconsIcSetloc
                          : CheckMapStatus.checkState(
                                  preState: StatusMap.selectLocation, nextState: StatusMap.selectDestination)
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
    );
  }
}
