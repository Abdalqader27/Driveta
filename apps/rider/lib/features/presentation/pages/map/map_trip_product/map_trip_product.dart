import 'package:design/design.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:rider/features/presentation/pages/map/map_trip_product/provider/map_trip_provider.dart';
import 'package:rider/features/presentation/pages/map/map_trip_product/widgets/map_body_container.dart';
import 'package:rider/features/presentation/pages/map/map_trip_product/widgets/title_app_bar.dart';

import '../../../../../common/utils/google_api_key.dart';
import '../map_store/location_granted_widget.dart';

class MapTripProduct extends StatefulWidget {
  const MapTripProduct({Key? key}) : super(key: key);

  @override
  State<MapTripProduct> createState() => _MapTripProductState();
}

class _MapTripProductState extends State<MapTripProduct>
    with WidgetsBindingObserver, GoogleApiKey {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LocationGrantedWidget(builder:
          (BuildContext context, LocationData locationData, Widget? child) {
        return Consumer<MapTripProvider>(
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
}
