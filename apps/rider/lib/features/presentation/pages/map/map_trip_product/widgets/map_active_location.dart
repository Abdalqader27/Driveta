import 'package:design/design.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rider/features/presentation/pages/map/map_trip_product/provider/map_trip_provider.dart';

class MapActiveLocation extends StatelessWidget {
  final Function(Position) onActiveLocation;
  final Function() onInactiveLocation;
  final Widget body;

  const MapActiveLocation(
      {Key? key,
      required this.onActiveLocation,
      required this.onInactiveLocation,
      required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<MapTripProvider, int>(
      selector: (context, provider) => provider.state.number,
      builder: (context, value, child) {
        return StreamBuilder<Position>(
            stream: Geolocator.getPositionStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                onInactiveLocation();
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (value > 0) {
                onActiveLocation(snapshot.data!);
              } else {
                onInactiveLocation();
              }
              return body;
            });
      },
    );
  }
}
