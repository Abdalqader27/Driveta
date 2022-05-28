import 'features/injection/injection_network.dart';
import 'features/injection/injection_services.dart';
import 'features/injection/rider_injection.dart';
import 'injections/map_injection.dart';

Future<void> init() async {
  await mapInjection();
  await InjectionServices.dependencies();

  NetworkInjection.dependencies();
  RiderInjection.dependencies();
}
