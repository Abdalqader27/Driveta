import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Models/route_data.dart';
import '../libraries/init_app/run_app.dart';
import 'map_bloc.dart';
import 'map_theme_bloc.dart';

typedef MapBlocBuilder = Function(
  AsyncSnapshot<Map<MarkerId, Marker>> marker,
  AsyncSnapshot<Map<PolylineId, Polyline>> polyline,
  AsyncSnapshot<RouteData> routeData,
  AsyncSnapshot<String> mode,
  //AsyncSnapshot<MapState> mapState
);

class ContainerMapBloc extends StatelessWidget {
  final MapBlocBuilder builder;

  const ContainerMapBloc({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // marker
    return StreamBuilder<Map<MarkerId, Marker>>(
        initialData: const <MarkerId, Marker>{},
        stream: inj<MapBloc>().rxMarkerList,
        builder: (
          BuildContext context,
          AsyncSnapshot<Map<MarkerId, Marker>> marker,
        ) {
          //polyline
          return StreamBuilder<Map<PolylineId, Polyline>>(
              initialData: const <PolylineId, Polyline>{},
              stream: inj<MapBloc>().rxPolylineList,
              builder: (
                BuildContext context,
                AsyncSnapshot<Map<PolylineId, Polyline>> polyline,
              ) {
                //route data
                return StreamBuilder<RouteData>(
                    stream: inj<MapBloc>().rxRouteData,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<RouteData> routeData,
                    ) {
                      //map mode
                      return StreamBuilder<String>(
                          initialData: '',
                          stream: inj<MapThemeBloc>().mapMode,
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<String> mapMode,
                          ) {
                            return builder(
                              marker,
                              polyline,
                              routeData,
                              mapMode,
                              // mapState,
                            );
                            //map st
                            // ate
                            // return StreamBuilder<MapState>(
                            //     stream: serviceLocator<MapBloc>().rxMapState,
                            //     initialData: MapState(
                            //       statusMap: StatusMap.selectLocation,
                            //       locationData: LocationData(),
                            //     ),
                            //     builder: (
                            //       BuildContext context,
                            //       AsyncSnapshot<MapState> mapState,
                            //     ) {
                            //
                            //     });
                          });
                    });
              });
        });
  }
}
