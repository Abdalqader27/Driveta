import 'dart:async';

import 'package:design/design.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/features/presentation/pages/map/map_store/location_granted_widget.dart';
import 'package:rider/features/presentation/pages/map/map_store/widgets/google_maps.dart';

import '../../../manager/container.dart';
import 'map_store_records.dart';

class MapStoreScreen extends StatefulWidget {
  const MapStoreScreen({Key? key}) : super(key: key);

  @override
  State<MapStoreScreen> createState() => _MapStoreScreenState();
}

class _MapStoreScreenState extends State<MapStoreScreen> {
  final GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  bool shouldShow = true;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer(Duration(seconds: 3), () {
      setState(() {
        shouldShow = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text('المتاجر',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ))),
      drawer: _SliderView(
        onItemClick: (title) {
          _key.currentState!.closeSlider();
        },
      ),
      body: Stack(
        children: [
          GetStoresContainer(builder: (context, data) {
            return LocationGrantedWidget(builder:
                (BuildContext context, dynamic location, Widget? child) {
              return GoogleMapsScreen(
                myLocation: location,
                // isMapSatellite: snapshot.data,
              );
            });
          }),
          Visibility(
            visible: shouldShow,
            child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Lottie.asset(
                'lotti_files/87096-log-in.json',
                width: 100,
                height: 200,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderView extends StatelessWidget {
  final Function(String)? onItemClick;

  const _SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        InkWell(
          onTap: () => Get.to(() => const MapStoreRecordScreen()),
          child: Card(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text('السجل',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'sst-arabic')),
                Lottie.asset(
                  'lotti_files/94539-order-history.json',
                  height: 120,
                  width: 120,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SliderMenuItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function(String)? onTap;

  const _SliderMenuItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title, style: TextStyle(color: Colors.black)),
        leading: Icon(iconData, color: Colors.black),
        onTap: () => onTap?.call(title));
  }
}
