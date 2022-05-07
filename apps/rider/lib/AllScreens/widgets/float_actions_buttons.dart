import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../Models/map_state.dart';
import '../../blocs/map_bloc.dart';
import '../../common/config/theme/colors.dart';
import '../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../libraries/init_app/run_app.dart';
import '../searchScreen.dart';

class MapFloatActionsButton extends StatelessWidget {
  final VoidCallback locationTap;
  final VoidCallback directionTap;
  final VoidCallback themeTap;

  const MapFloatActionsButton({Key? key, required this.locationTap, required this.directionTap, required this.themeTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MapState>(
        initialData: inj<MapState>(),
        stream: inj<MapBloc>().rxMapState,
        builder: (context, snapshot) {
          print("${snapshot.data?.pre}");
          print("${snapshot.data?.next}");
          return RPadding(
            padding: EdgeInsets.symmetric(vertical: 60.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: snapshot.data!.pre == StatusMap.selectLocation,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Get.to(() => const SearchScreen());
                      //_handlePressButton(context);
                    },
                    child: const Card(
                      color: kPRIMARY,
                      child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: kPRIMARY,
                        mini: true,
                        heroTag: 'search',
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        tooltip: ' البحث ',
                        onPressed: null,
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
                      child: Icon(
                        Icons.map_outlined,
                        color: Colors.white,
                      ),
                      tooltip: ' الشكل ',
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
                      child: Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                      tooltip: ' الموقع ',
                    ),
                  ),
                ),
                Visibility(
                  visible: snapshot.data!.pre == StatusMap.selectDestination || snapshot.data!.pre == StatusMap.path,
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
                        child: Icon(
                          Icons.directions,
                          color: Colors.white,
                        ),
                        tooltip: ' الوجهة ',
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
