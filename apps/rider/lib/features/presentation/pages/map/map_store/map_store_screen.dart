import 'package:design/design.dart';
import 'package:rider/features/presentation/pages/map/map_store/location_granted_widget.dart';
import 'package:rider/features/presentation/pages/map/map_store/widgets/google_maps.dart';

import '../../../manager/container.dart';

class MapStoreScreen extends StatefulWidget {
  const MapStoreScreen({Key? key}) : super(key: key);

  @override
  State<MapStoreScreen> createState() => _MapStoreScreenState();
}

class _MapStoreScreenState extends State<MapStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetStoresContainer(builder: (context, data) {
        return LocationGrantedWidget(
            builder: (BuildContext context, dynamic location, Widget? child) {
          return GoogleMapsScreen(
            myLocation: location,
            // isMapSatellite: snapshot.data,
          );
        });
      }),
    );
  }
}
