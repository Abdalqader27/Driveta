import '../Models/location_data.dart';
import '../Models/map_state.dart';
import '../blocs/map_bloc.dart';
import '../blocs/map_theme_bloc.dart';
import '../libraries/init_app/run_app.dart';

Future<void> mapInjection() async {
  si.registerLazySingleton(() => MapBloc());
  si.registerLazySingleton(() => MapThemeBloc());
  si.registerLazySingleton(() => PinData());
  si.registerLazySingleton(() => MapState(
        pinData: si<PinData>(),
      ));
  // inj.registerLazySingleton(() => RealTime());
}
