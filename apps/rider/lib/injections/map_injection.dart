import '../blocs/map_bloc.dart';
import '../blocs/map_theme_bloc.dart';
import '../features/data/models/map_state.dart';
import '../features/data/models/trip_data.dart';
import '../main.dart';

Future<void> mapInjection() async {
  si.registerLazySingleton(() => MapBloc());
  si.registerLazySingleton(() => MapThemeBloc());
  si.registerLazySingleton(() => TripData());
  si.registerLazySingleton(() => MapState(
        pinData: si<TripData>(),
      ));
  // inj.registerLazySingleton(() => RealTime());
}
