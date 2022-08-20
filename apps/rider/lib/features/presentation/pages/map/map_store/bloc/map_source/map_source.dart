import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider/features/presentation/pages/map/map_store/bloc/map_bloc.dart';

class MapSource {
  static MapBloc? mapBloc = MapBloc();

  // MapSource() {
  //   mapBloc ??= MapBloc(key);
  //   refreshKey(key);
  // }

  static refreshKey(GlobalKey<ScaffoldState> key) {
    mapBloc!.key = key;
  }
}
