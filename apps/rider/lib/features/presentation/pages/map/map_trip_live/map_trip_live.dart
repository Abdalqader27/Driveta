import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rider/common/utils/signal_r.dart';
import 'package:rider/features/presentation/pages/map/map_trip_live/providers/map_live_provider.dart';

import '../../../../../../common/utils/google_api_key.dart';
import '../../../../../common/config/theme/colors.dart';
import '../../../../../main.dart';
import '../map_trip_product/provider/map_trip_provider.dart';
import '../map_trip_product/widgets/map_body_container.dart';
import '../map_trip_product/widgets/title_app_bar.dart';
import 'widget/location_granted_widget.dart';

late GoogleMapController tripLiveMapController;

class MapTripLive extends StatefulWidget {
  const MapTripLive({Key? key}) : super(key: key);

  @override
  State<MapTripLive> createState() => _MapTripLiveState();
}

class _MapTripLiveState extends State<MapTripLive>
    with WidgetsBindingObserver, GoogleApiKey {
  @override
  Widget build(BuildContext context) {
    ctx = context;

    return Scaffold(
      body: LocationGrantedWidget(
          builder: (BuildContext context, locationData, Widget? child) {
        return Consumer<MapLiveProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                MapProductContainer(
                  locationData: locationData,
                  onMapCreated: provider.onMapCreated,
                  markers: Set.of(provider.markers.values),
                  polyLines: Set.of(provider.polyLines.values),
                  mapId: provider.mapId(),
                ),
                TitleAppBar(
                  titleSpan: provider.state.getTitleSpan(),
                  durationText: provider.details?.durationText
                          .replaceAll('mins', 'د ')
                          .replaceAll('min', 'د ') ??
                      '',
                  title: provider.state.getTitle(),
                  driverName: (provider.selectedDriver)?.name ?? '',
                  driverPhone: provider.selectedDriver?.phoneNumber ?? '',
                ),
                if (provider.state.number == 0)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: FlatButton(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.red)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const <Widget>[
                            Text(
                              'الغاء الرحلة ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 17,
                            ),
                          ],
                        ),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.RIGHSLIDE,
                            headerAnimationLoop: true,
                            title: 'تنبيه',
                            desc: 'هل حقا تريد إلغاء الرحلة ؟',
                            btnCancelText: 'نعم ',
                            btnOkText: 'لا',
                            btnOkOnPress: () {},
                            btnCancelOnPress: () {
                              SignalRRider().removeDeliveryCustomer(
                                id: provider.deliver!.id,
                              );
                            },
                            btnCancelColor: kPRIMARY,
                            btnOkColor: kRed4,
                          ).show();

                          // UrlLauncer.launch('tel:00${snapshot.data.captainNumber}');
                        },
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      }),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    si<MapTripProvider>().reset();
    super.dispose();
  }
}
