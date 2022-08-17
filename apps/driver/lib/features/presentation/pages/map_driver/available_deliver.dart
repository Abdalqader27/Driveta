import 'package:android_intent_plus/android_intent.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:design/design.dart';
import 'package:driver/app_injection.dart';
import 'package:driver/common/utils/signal_r_config.dart';
import 'package:driver/features/data/models/delivers.dart';
import 'package:driver/features/presentation/manager/bloc.dart';
import 'package:driver/features/presentation/pages/map_driver/widgets/available_delevieries_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../AllScreens/newRideScreen.dart';
import '../../../../common/config/theme/colors.dart';
import '../../manager/event.dart';
import '../../widgets/round_app_bar.dart';

final BehaviorSubject<List<Delivers>> deliversStream =
    BehaviorSubject<List<Delivers>>.seeded([]);

final BehaviorSubject<List<Delivers>> deliversProductStream =
    BehaviorSubject<List<Delivers>>.seeded([]);

class AvailableDeliveries extends StatefulWidget {
  const AvailableDeliveries({Key? key}) : super(key: key);

  @override
  State<AvailableDeliveries> createState() => _AvailableDeliveriesState();
}

class _AvailableDeliveriesState extends State<AvailableDeliveries> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    si<DriverBloc>().add(GetAvailableDeliveries());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const RoundedAppBar(
              title: 'الطلبات المتاحة  ',
            ),
            Expanded(
              child: StreamBuilder<List<Delivers>>(
                  stream: deliversStream.stream,
                  initialData: [],
                  builder: (context, AsyncSnapshot<List<Delivers>> snap) {
                    if (snap.data!.isEmpty) {
                      return Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('لايوجد طلبات'),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: CupertinoButton(
                            color: kPRIMARY,
                            borderRadius: BorderRadius.circular(30),
                            child: SText.titleMedium(
                              'الرجوع',
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(color: Colors.white),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          )),
                        ],
                      ));
                    }

                    return ListView.builder(
                        itemCount: snap.data!.length,
                        itemBuilder: (context, i) {
                          Delivers deliver = snap.data![i];
                          return AvailableDeliveriesItem(
                            delivers: deliver,
                            onTap: () async {
                              try {
                                BotToast.showLoading();
                                SignalRDriver()
                                    .acceptDelivery(id: deliver.id ?? '');
                                BotToast.closeAllLoading();
                                Get.back();
                                Get.to(
                                    () => NewRideScreen(rideDetails: deliver));
                              } catch (e) {
                                BotToast.closeAllLoading();
                              }
                            },
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class AvilableDeliveriesProduct extends StatefulWidget {
  const AvilableDeliveriesProduct({Key? key}) : super(key: key);

  @override
  State<AvilableDeliveriesProduct> createState() =>
      _AvilableDeliveriesProductState();
}

class _AvilableDeliveriesProductState extends State<AvilableDeliveriesProduct> {
  @override
  void initState() {
    super.initState();
    si<DriverBloc>().add(GetAvailableDeliveriesProduct());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const RoundedAppBar(
              color: kRed0,
              title: '  الطلبات المتاحة  للمنتجات ',
            ),
            Expanded(
              child: StreamBuilder<List<Delivers>>(
                  stream: deliversProductStream.stream,
                  initialData: [],
                  builder: (context, AsyncSnapshot<List<Delivers>> snap) {
                    if (snap.data!.isEmpty) {
                      return Text('لايوجد توصيلات');
                    }

                    return ListView.builder(
                        itemCount: snap.data!.length,
                        itemBuilder: (context, i) {
                          Delivers deliver = snap.data![i];
                          return AvailableDeliveriesProductItem(
                            delivers: deliver,
                            onTap: () async {
                              try {
                                BotToast.showLoading();
                                SignalRDriver().acceptDeliveryProduct(
                                    id: deliver.id ?? '');
                                BotToast.closeAllLoading();
                                Get.to(() => NewRideScreen(
                                    rideDetails: deliver, type: 2));
                              } catch (e) {
                                BotToast.closeAllLoading();
                              }
                            },
                          );
                        });
                  }),
            )
          ],
        ),
      ),
    );
  }
}
