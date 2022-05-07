import '../Models/location_data.dart';
import '../Models/map_state.dart';
import '../blocs/map_bloc.dart';
import '../blocs/map_theme_bloc.dart';
import '../libraries/init_app/run_app.dart';

Future<void> mapInjection() async {
  inj.registerLazySingleton(() => MapBloc());
  inj.registerLazySingleton(() => MapThemeBloc());
  inj.registerLazySingleton(() => PinData());
  inj.registerLazySingleton(() => MapState(
        pinData: inj<PinData>(),
      ));
  // inj.registerLazySingleton(() => RealTime());
}
