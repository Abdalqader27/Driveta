import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../main.dart';
import 'map_bloc.dart';
import 'map_theme_bloc.dart';

typedef MapBlocBuilder = Function(
  AsyncSnapshot<Map<MarkerId, Marker>> marker,
  AsyncSnapshot<Map<PolylineId, Polyline>> polyline,
);

class ContainerMapBloc extends StatelessWidget {
  final MapBlocBuilder builder;

  const ContainerMapBloc({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // marker
    return StreamBuilder<Map<MarkerId, Marker>>(
        initialData: const <MarkerId, Marker>{},
        stream: si<MapBloc>().streamMarker,
        builder: (BuildContext context,
            AsyncSnapshot<Map<MarkerId, Marker>> marker) {
          //polyline
          return StreamBuilder<Map<PolylineId, Polyline>>(
              initialData: const <PolylineId, Polyline>{},
              stream: si<MapBloc>().streamPolyline,
              builder: (BuildContext context,
                  AsyncSnapshot<Map<PolylineId, Polyline>> polyline) {
                //route data
                return StreamBuilder<String>(
                    initialData: '',
                    stream: si<MapThemeBloc>().mapMode,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<String> mapMode,
                    ) {
                      return builder(marker, polyline);
                    });
              });
        });
  }
}
