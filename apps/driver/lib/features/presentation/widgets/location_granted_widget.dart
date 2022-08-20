// import 'package:design/design.dart';
// import 'package:flutter/services.dart';

// import 'package:location/location.dart';

// import '../../../common/utils/logs.dart';

// class LocationGrantedWidget extends StatefulWidget {
//   const LocationGrantedWidget({Key? key, required this.builder}) : super(key: key);
//   final ValueWidgetBuilder builder;

//   @override
//   _LocationGrantedWidgetState createState() => _LocationGrantedWidgetState();
// }

// class _LocationGrantedWidgetState extends State<LocationGrantedWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: getLocation(),
//         builder: (context, snapshot) {
//           return Padding(
//             padding: const EdgeInsets.only(top: 28.0),
//             child: StreamBuilder<LocationData?>(
//                 stream:snapshot.onLocationChanged,
//                 builder: (_, loc) {
//                   if (loc.data == null) {
//                     return const SLoading();
//                   } else {
//                     if (loc.data != null && loc.data!.latitude != null && loc.data!.longitude != null) {
//                       return ValueListenableBuilder<LocationData>(
//                         valueListenable: ValueNotifier<LocationData>(loc.data ?? LocationData.fromMap({})),
//                         builder: widget.builder,
//                       );
//                     }
//                   }
      
//                   return openLocationButton(context: context);
//                 }),
//           );
//         }
//       ),
//     );
//   }

//   Widget openLocationButton({required BuildContext context}) {
//     return Center(
//         child: SizedBox(
//       child: SButton.filled(
//         text: "تشغيل ",
//         onPressed: () async {
//           try {
//             bool _serviceEnabled;
//             PermissionStatus _permissionGranted;

//             _serviceEnabled = await serviceEnabled();
//             if (!_serviceEnabled) {
//               _serviceEnabled = await Location.instance.requestService();
//               if (!_serviceEnabled) {
//                 return;
//               }
//             }
//             if (_permissionGranted == PermissionStatus.denied) {
//               _permissionGranted = await requestPermission();
//               if (_permissionGranted != PermissionStatus.authorizedAlways) {
//                 return;
//               }
//             }

//             setState(() {});
//           } on PlatformException catch (_) {}
//         },
//       ),
//     ));
//   }

//   Widget noLocationWidget({required BuildContext context}) {
//     return Center(
//         child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(Icons.location_on_outlined, size: 32),
//         Container(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               " الرجاء تشغيل  الموقع لفتح الخريطة ",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             )),
//         openLocationButton(context: context)
//       ],
//     ));
//   }
// }
