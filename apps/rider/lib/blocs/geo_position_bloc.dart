// import 'package:geolocator/geolocator.dart';
// import 'package:rxdart/rxdart.dart';
//
// import 'base_bloc.dart';
//
// class GeoPositionBloc implements BaseBloc {
//   final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
//   final BehaviorSubject<Position> positions = BehaviorSubject<Position>();
//
//   Stream<Position> get position => positions.stream;
//
//   static const LocationOptions locationOptions = LocationOptions(
//     accuracy: LocationAccuracy.high,
//     distanceFilter: 10,
//   );
//
//   /// Functions
//   void init() {
//     _geolocatorPlatform.checkPermission().asStream().listen((event) {
//       if (event == LocationPermission.always ||
//           event == LocationPermission.whileInUse) {
//         listToLocation();
//       }
//     });
//   }
//
//   void listToLocation() => _geolocatorPlatform
//       .getPositionStream(
//         distanceFilter: 10,
//         desiredAccuracy: LocationAccuracy.bestForNavigation,
//       )
//       .listen((Position position) => positions.sink.add(position));
//
//   @override
//   void dispose() {
//     positions.close();
//   }
// }
