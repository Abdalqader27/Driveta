import 'package:rider/features/data/data_sources/rider_api.dart';import 'package:rider/features/data/repositories/rider_repository.dart';import 'package:rider/features/domain/use_cases/rider_usecase.dart';import 'package:rider/features/presentation/manager/bloc.dart';import 'package:rider/main.dart';import '../presentation/pages/map/map_trip_live/providers/map_live_provider.dart';import '../presentation/pages/map/map_trip_product/provider/map_trip_provider.dart';class RiderInjection {  static void dependencies() {    si.registerLazySingleton(      () => RiderApi(api: si()),    );    si.registerLazySingleton(      () => RiderRepository(connectivity: si(), remote: si()),    );    si.registerLazySingleton(      () => RiderUseCase(repository: si()),    );    si.registerLazySingleton(() => RiderBloc(si()));    si.registerLazySingleton(() => MapTripProductProvider());    si.registerLazySingleton(() => MapLiveProvider());  }}