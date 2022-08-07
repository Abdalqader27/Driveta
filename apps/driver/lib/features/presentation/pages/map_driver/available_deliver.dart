import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';
import 'package:driver/common/utils/signal_r_config.dart';
import 'package:driver/features/data/models/delivers.dart';
import 'package:driver/features/presentation/pages/map_driver/widgets/available_delevieries_item.dart';
import 'package:driver/features/presentation/widgets/lottie_widget.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../AllScreens/newRideScreen.dart';
import '../../widgets/round_app_bar.dart';

final BehaviorSubject<List<Delivers>> deliversStream =
    BehaviorSubject<List<Delivers>>.seeded([]);

final BehaviorSubject<List<Delivers>> deliversProductStream =
    BehaviorSubject<List<Delivers>>.seeded([]);

class AvailableDeliveries extends StatelessWidget {
  const AvailableDeliveries({Key? key}) : super(key: key);

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
                      return LottieWidget.notFound2();
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
                                SignalRDriver().acceptDelivery(id: deliver.id);
                                BotToast.closeAllLoading();
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

class AvilableDeliveriesProduct extends StatelessWidget {
  const AvilableDeliveriesProduct({Key? key}) : super(key: key);

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
                      return LottieWidget.notFound2();
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
                                SignalRDriver()
                                    .acceptDeliveryProduct(id: deliver.id);
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
