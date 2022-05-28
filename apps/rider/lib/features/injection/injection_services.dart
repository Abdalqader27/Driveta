import 'dart:async';

import 'package:core/core.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../libraries/init_app/run_app.dart';

class InjectionServices {
  static Future<void> dependencies() async {
    si.registerSingleton(await SharedPreferences.getInstance());

    si.registerSingleton(SStorage(si<SharedPreferences>()));

    si.registerSingleton(SNavigatorObserver());
  }
}
