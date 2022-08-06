import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rider/features/presentation/pages/map/map_trip_live/providers/map_live_provider.dart';

import '../../../../../../common/utils/google_api_key.dart';
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
                  durationText: provider.details?.durationText ?? '',
                  title: provider.state.getTitle(),
                  driverName: provider.state.driver?.name ?? '',
                  driverPhone: provider.state.driver?.phoneNumber ?? '',
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
    super.dispose();
  }
}
