import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../common/services/preferences.dart';
import 'base_bloc.dart';

class MapThemeBloc with Preferences implements BaseBloc {
  final BehaviorSubject<String> _mapMode = BehaviorSubject<String>();
  Stream<String> get mapMode => _mapMode.stream;

  /// Functions
  void init() async {
    final String mapMode = await getMapMode();
    try {
      final String mapFileData = await _getFileData('assets/json/$mapMode.json');
      _mapMode.sink.add(mapFileData);
    } catch (_) {
      _mapMode.sink.add('');
    }
  }

  static Future<String> _getFileData(String path) async => await rootBundle.loadString(path);

  void changeMapMode(String mode) async {
    await saveMapMode(mode);
    init();
  }

  @override
  void dispose() {
    _mapMode.close();
  }
}

final MapThemeBloc singleBloc = MapThemeBloc();
