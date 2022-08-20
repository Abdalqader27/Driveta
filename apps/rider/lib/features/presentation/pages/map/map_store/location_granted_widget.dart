import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import '../../../../../common/widgets/custom_button.dart';

class LocationGrantedWidget extends StatefulWidget {
  const LocationGrantedWidget({Key? key, required this.builder})
      : super(key: key);
  final ValueWidgetBuilder<LocationData> builder;

  @override
  _LocationGrantedWidgetState createState() => _LocationGrantedWidgetState();
}

class _LocationGrantedWidgetState extends State<LocationGrantedWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Location.instance.hasPermission().asStream(),
        builder: (_, hasPermission) {
          if (hasPermission.data == null) {
            return const Center(
                child: SizedBox(child: CircularProgressIndicator()));
          } else {
            if (hasPermission.data != PermissionStatus.granted) {
              return noLocationWidget(context: context);
            }
            return StreamBuilder(
                stream: Location.instance.requestPermission().asStream(),
                builder: (_, requestPermission) {
                  if (requestPermission.data == null) {
                    return const Center(
                        child: SizedBox(child: CircularProgressIndicator()));
                  } else {
                    if (requestPermission.data != PermissionStatus.granted) {
                      return noLocationWidget(context: context);
                    }
                    return StreamBuilder<LocationData?>(
                        stream: Location.instance.getLocation().asStream(),
                        builder: (context, loc) {
                          if (loc.hasData) if (loc.data == null) {
                            return noLocationWidget(context: context);
                          } else {
                            const Center(
                                child: const SizedBox(
                                    child: CircularProgressIndicator()));
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
                          return const Center(
                              child:
                                  SizedBox(child: CircularProgressIndicator()));
                        });
                  }
                });
          }
        });
  }

  Widget openLocationButton({required BuildContext context}) {
    return Center(
        child: SizedBox(
      width: 85,
      child: CustomButton(
        title: "تشغيل ",
        height: 44,
        icon: const Icon(
          Icons.location_on_outlined,
          size: 22,
        ),
        color: kPrimaryColor,
        textStyle: Theme.of(context).textTheme.button,
        onPressed: () async {
          try {
            bool _serviceEnabled;
            PermissionStatus _permissionGranted;

            _serviceEnabled = await Location.instance.serviceEnabled();
            if (!_serviceEnabled) {
              _serviceEnabled = await Location.instance.requestService();
              if (!_serviceEnabled) {
                return;
              }
            }
            _permissionGranted = await Location.instance.hasPermission();
            if (_permissionGranted == PermissionStatus.denied) {
              _permissionGranted = await Location.instance.requestPermission();
              if (_permissionGranted != PermissionStatus.granted) {
                return;
              }
            }

            setState(() {});
          } on PlatformException catch (_) {}
        },
      ),
    ));
  }

  Widget noLocationWidget({required BuildContext context}) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.location_on_outlined, size: 32),
        Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              " الرجاء تشغيل  الموقع لفتح الخريطة ",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )),
        openLocationButton(context: context)
      ],
    ));
  }
}
