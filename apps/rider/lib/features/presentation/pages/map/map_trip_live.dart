import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/utils/google_api_key.dart';
import '../../../../../generated/assets.dart';
import '../../../../Models/map_state.dart';
import '../../../../blocs/container_map_bloc.dart';
import '../../../../blocs/map_bloc.dart';
import '../../../../common/config/theme/colors.dart';
import '../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../../../libraries/el_widgets/widgets/responsive_sized_box.dart';
import '../../../../libraries/init_app/run_app.dart';
import 'map_trip_live/widget/location_granted_widget.dart';
import 'map_trip_live/widget/map_body_container.dart';

late GoogleMapController tripLiveMapController;

class MapTripLive extends StatefulWidget {
  const MapTripLive({Key? key}) : super(key: key);

  @override
  State<MapTripLive> createState() => _MapTripLiveState();
}

class _MapTripLiveState extends State<MapTripLive> with WidgetsBindingObserver, GoogleApiKey {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: LocationGrantedWidget(builder: (BuildContext context, location, Widget? child) {
          return ContainerMapBloc(builder: (
            AsyncSnapshot<Map<MarkerId, Marker>> marker,
            AsyncSnapshot<Map<PolylineId, Polyline>> polyline,
          ) {
            Future.delayed(const Duration(seconds: 1), () {
              si<MapBloc>().setMapFitToTour(Set.of(polyline.data!.values),
                  controller: tripLiveMapController);
            });

            return Scaffold(
              body: Stack(
                alignment: Alignment.center,
                children: [
                  MapBodyContainer(
                    markers: Set.of(marker.data!.values),
                    polyLines: Set.of(polyline.data!.values),
                    locationData: location,
                    padding: const EdgeInsets.only(top: 240),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    top: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(), gradient: linearGradient(context)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [titleCaptainOnHisWay(context)],
                      ),
                    ),
                  )
                ],
              ),
            );
            // bottomNavigationBar: BottomNavigation(),);
          });
        }),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  LinearGradient linearGradient(context) {
    return LinearGradient(colors: [
      Color(0xfffbfbfb),
      Color(0xfffbfbfb),
      Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).primaryColor
          : Color(0xfffbfbfb),
//                                              Colors.white30,
      Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).primaryColor.withOpacity(.0001)
          : Color(0xfffbfbfb).withOpacity(.2),
    ], begin: Alignment.center, end: Alignment.bottomCenter, tileMode: TileMode.clamp);
  }

  Widget titleCaptainOnHisWay(context) {
    return RPadding.all12(
      child: Column(
        children: <Widget>[
          RSizedBox.v16(),
          RichText(
            text: TextSpan(
                text: " الساىق ",
                children: [
                  TextSpan(
                      text: "في طريقه اليك",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'sst-arabic',
                          color: kPRIMARY)),
                ],
                style: TextStyle(
                  color: Theme.of(context).brightness != Brightness.dark
                      ? Colors.black
                      : Color(0xfffbfbfb),
                  fontSize: 20,
                  fontFamily: 'sst-arabic',
                  fontWeight: FontWeight.bold,
                )),
            textAlign: TextAlign.center,
          ),
          RSizedBox.v16(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialText.subTitle2(
                  "المدة المتوقعة للوصول خلال :",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          MaterialText.subTitle2(
            "${si<MapState>().pinData.directionDetails?.durationText}",
            style: TextStyle(color: kBlack, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Divider(),
              ),
              ListTile(
                leading: Container(
                  height: 60,
                  width: 60,
                  child: ClipOval(
                    child: SizedBox(
                        width: 50.0, height: 50.0, child: SvgPicture.asset(Assets.iconsUser)),
                  ),
                ),
                title: Text(
                  'اسم السائق',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'نوع السيارة',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                trailing: Container(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'اتصال ',
                          style: TextStyle(color: Colors.green, fontSize: 13),
                        ),
                        Icon(
                          Icons.call,
                          color: Colors.green,
                          size: 17,
                        ),
                      ],
                    ),
                    onPressed: () {
                      // UrlLauncer.launch('tel:00${snapshot.data.captainNumber}');
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
