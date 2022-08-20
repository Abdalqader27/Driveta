import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import '../../../../../../common/widgets/lottie_widget.dart';

Location location = Location();

class LocationGrantedWidget extends StatefulWidget {
  const LocationGrantedWidget({Key? key, required this.builder}) : super(key: key);
  final ValueWidgetBuilder builder;

  @override
  _LocationGrantedWidgetState createState() => _LocationGrantedWidgetState();
}

class _LocationGrantedWidgetState extends State<LocationGrantedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: location.hasPermission().asStream(),
          builder: (_, hasPermission) {
            if (hasPermission.data == null) {
              return const LottieWidget.loading();
            } else {
              if (hasPermission.data != PermissionStatus.granted) {
                return noLocationWidget(context: context);
              }
              return StreamBuilder(
                  stream: location.requestPermission().asStream(),
                  builder: (_, requestPermission) {
                    if (requestPermission.data == null) {
                      return const LottieWidget.loading();
                    } else {
                      if (requestPermission.data != PermissionStatus.granted) {
                        return noLocationWidget(context: context);
                      }
                      return StreamBuilder<LocationData?>(
                          stream: location.getLocation().asStream(),
                          builder: (context, loc) {
                            if (loc.hasData) {
                              if (loc.data == null) {
                                return const LottieWidget.notFound();
                              } else {
                                const LottieWidget.loading();
                              }
                            }
                            if (loc.data != null &&
                                loc.data!.latitude != null &&
                                loc.data!.longitude != null) {
                              return ValueListenableBuilder<LocationData>(
                                valueListenable: ValueNotifier<LocationData>(
                                    loc.data ?? LocationData.fromMap({})),
                                builder: widget.builder,
                              );
                            }
                            return const LottieWidget.loading();
                          });
                    }
                  });
            }
          }),
    );
  }

  Widget openLocationButton({required BuildContext context}) {
    return Center(
        child: SizedBox(
      width: 100,
      child: TextButton(
        onPressed: () async {
          try {
            bool _serviceEnabled;
            PermissionStatus _permissionGranted;

            _serviceEnabled = await location.serviceEnabled();
            if (!_serviceEnabled) {
              _serviceEnabled = await location.requestService();
              if (!_serviceEnabled) {
                return;
              }
            }
            _permissionGranted = await location.hasPermission();
            if (_permissionGranted == PermissionStatus.denied) {
              _permissionGranted = await location.requestPermission();
              if (_permissionGranted != PermissionStatus.granted) {
                return;
              }
            }

            setState(() {});
          } on PlatformException catch (_) {}
        },
        child: const Text('تشغيل'),
      ),
    ));
  }

  Widget noLocationWidget({required BuildContext context}) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.location_on_outlined, size: 38),
        Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              " الرجاء تشغيل  الموقع لفتح الخريطة ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        openLocationButton(context: context)
      ],
    ));
  }
}
