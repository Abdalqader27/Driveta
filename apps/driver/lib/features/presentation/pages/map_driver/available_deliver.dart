import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';
import 'package:driver/common/utils/signal_r_config.dart';
import 'package:driver/features/domain/use_cases/driver_usecase.dart';
import 'package:driver/features/presentation/manager/container.dart';
import 'package:driver/features/presentation/pages/map_driver/widgets/available_delevieries_item.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../AllScreens/newRideScreen.dart';
import '../../../../app_injection.dart';
import '../../widgets/round_app_bar.dart';
import 'package:driver/features/data/models/delivers.dart';

final BehaviorSubject<List<Delivers>> deliversStream =
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
                    return ListView.builder(
                        itemCount: snap.data!.length,
                        itemBuilder: (context, i) {
                          Delivers deliver = snap.data![i];
                          return AvailableDeliveriesItem(
                            delivers: deliver,
                            onTap: () async {
                              try {
                                BotToast.showLoading();
                                SignalRDriver.acceptDelivery(id: deliver.id);
                                // await si<DriverUseCase>().changeDeliveryStatue(
                                //     id: delivers.id, statue: 'Accept');
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
