import 'package:design/design.dart';
import 'package:driver/features/data/models/delivers.dart';
import 'package:driver/features/data/models/invoices.dart';
import 'package:get/get.dart';

import '../../widgets/round_app_bar.dart';
import '../history/order_book_screen_details.dart';
import '../history/widgets/order_book_item.dart';

class BalanceDelivers extends StatelessWidget {
  final Invoice invoice;
  const BalanceDelivers({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            RoundedAppBar(
              title: 'سجل الفاتورة',
              subTitle: '${invoice.deliveries?.length ?? 0}',
            ),
            Expanded(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: invoice.deliveries?.length ?? 0,
              itemBuilder: (context, i) {
                final history = invoice.deliveries![i];
                Delivers delivers = Delivers(
                    customerId: history.customerId ?? '',
                    customerName: history.customerName ?? '',
                    id: history.id ?? '',
                    distance: history.distance ?? 0,
                    startLong: history.startLong ?? '',
                    startLat: history.startLat ?? '',
                    dropOff: history.dropOff ?? '',
                    price: history.price ?? 0,
                    endLat: history.endLat ?? '',
                    endLong: history.endLong ?? '',
                    expectedTime: history.expectedTime ?? '',
                    pickUp: history.pickUp ?? '');

                return GestureDetector(
                  onTap: () => Get.to(() => OrderBookScreenDetails(
                        delivers: delivers,
                      )),
                  child: OrderBookItem(
                    index: i,
                    history: delivers,
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
