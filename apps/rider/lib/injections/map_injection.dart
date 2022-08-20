import '../blocs/map_bloc.dart';
import '../features/data/models/map_state.dart';
import '../features/data/models/trip_data.dart';
import '../main.dart';

Future<void> mapInjection() async {
  si.registerLazySingleton(() => MapBloc());
  si.registerLazySingleton(() => TripData());
  si.registerLazySingleton(() => MapState(
        pinData: si<TripData>(),
      ));
}
