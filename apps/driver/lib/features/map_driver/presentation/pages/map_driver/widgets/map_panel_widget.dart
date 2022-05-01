import 'package:driver/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'map_panel_widget_body.dart';

class MapPanelWidget extends StatefulWidget {
  const MapPanelWidget({Key? key}) : super(key: key);

  @override
  State<MapPanelWidget> createState() => _MapPanelWidgetState();
}

class _MapPanelWidgetState extends State<MapPanelWidget> {
  final PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: SlidingUpPanel(
        color: Theme.of(context).scaffoldBackgroundColor,
        parallaxEnabled: true,
        backdropTapClosesPanel: true,
        controller: panelController,
        slideDirection: SlideDirection.DOWN,
        backdropEnabled: true,
        maxHeight: 0.85.sh,
        minHeight: 30.h,
        panel: MapPanelWidgetBody(panelController: panelController),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.r), bottomRight: Radius.circular(15.0.r)),
      ),
    );
  }
}
