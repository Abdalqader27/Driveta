import 'dart:async';

import 'package:driver/features/injections/driver_injection.dart';
import 'package:get_it/get_it.dart';

import 'features/injections/injection_network.dart';
import 'features/injections/injection_services.dart';

final si = GetIt.instance;

class Injections {
  static Future<void> init() async {
    NetworkInjection.dependencies();
    await InjectionServices.dependencies();
    DriverInjection.dependencies();
  }
}
