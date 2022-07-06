import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../../Models/map_state.dart';
import '../../../blocs/map_bloc.dart';
import '../../../common/config/theme/colors.dart';
import '../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../../libraries/init_app/run_app.dart';
import '../pages/search/searchScreen.dart';

class MapFloatActionsButton extends StatelessWidget {
  final VoidCallback locationTap;
  final VoidCallback directionTap;
  final VoidCallback themeTap;

  const MapFloatActionsButton(
      {Key? key, required this.locationTap, required this.directionTap, required this.themeTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MapState>(
        initialData: si<MapState>(),
        stream: si<MapBloc>().rxMapState,
        builder: (context, snapshot) {
          return RPadding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: snapshot.data!.pre == StatusTripMap.selectLocation,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.to(() => const SearchScreen());
                    },
                    child: const Card(
                      color: kPRIMARY,
                      child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: kPRIMARY,
                        mini: true,
                        heroTag: 'search',
                        tooltip: ' البحث ',
                        onPressed: null,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                CupertinoButton(
                  onPressed: themeTap,
                  padding: EdgeInsets.zero,
                  child: const Card(
                    color: kPRIMARY,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: kPRIMARY,
                      mini: true,
                      heroTag: 'style',
                      onPressed: null,
                      tooltip: ' الشكل ',
                      child: Icon(
                        Icons.map_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                CupertinoButton(
                  onPressed: locationTap,
                  padding: EdgeInsets.zero,
                  child: const Card(
                    color: kPRIMARY,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: kPRIMARY,
                      mini: true,
                      heroTag: 'Location',
                      onPressed: null,
                      tooltip: ' الموقع ',
                      child: Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: snapshot.data!.pre == StatusTripMap.selectDestination ||
                      snapshot.data!.pre == StatusTripMap.path,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: directionTap,
                    child: const Card(
                      color: kPRIMARY,
                      child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: kPRIMARY,
                        mini: true,
                        heroTag: 'Directions',
                        onPressed: null,
                        tooltip: ' الوجهة ',
                        child: Icon(
                          Icons.directions,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
