import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../Models/map_state.dart';
import '../../blocs/map_bloc.dart';
import '../../common/utils/check_map_status.dart';
import '../../generated/assets.dart';
import '../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../libraries/init_app/run_app.dart';
import 'header_item.dart';

class HeaderLocDes extends StatefulWidget {
  const HeaderLocDes({Key? key}) : super(key: key);

  @override
  State<HeaderLocDes> createState() => _HeaderLocDesState();
}

class _HeaderLocDesState extends State<HeaderLocDes> {
  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.synchronized(
      duration: const Duration(milliseconds: 100),
      child: StreamBuilder<MapState>(
          stream: inj<MapBloc>().rxMapState,
          initialData: inj<MapState>(),
          builder: (context, snapshot) {
            final data = snapshot.data;
            return Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          RPadding.all16(
                            child: SvgPicture.asset(
                              Assets.iconsIcRoute,
                              height: 80.r,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HeaderItem(
                                context: context,
                                title: '???????????? ????????????',
                                subtitle: data!.pinData.currentAddress,
                                checkValue: CheckMapStatus.checkCompleteState(
                                  nextState: StatusMap.selectLocation,
                                  preState: StatusMap.init,
                                ),
                                loading: data.isCurrentLoading),
                            DottedLine(
                              dashColor: Colors.grey.withOpacity(.5),
                            ),
                            HeaderItem(
                                context: context,
                                title: ' ????????????',
                                subtitle: data.pinData.destinationAddress,
                                checkValue: CheckMapStatus.checkCompleteState(
                                  nextState: StatusMap.selectDestination,
                                  preState: StatusMap.selectLocation,
                                ),
                                loading: data.isDestinationLoading),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
