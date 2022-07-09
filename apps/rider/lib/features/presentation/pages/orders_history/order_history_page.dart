import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rider/features/presentation/pages/orders_history/widget/order_history_item.dart';

import '../../../../../common/widgets/round_app_bar.dart';
import '../../../data/models/delivers.dart';
import '../../manager/container.dart';
import 'order_book_screen_details.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetDeliveriesContainer(builder: (context, List<Delivers> data) {
          return Column(
            children: [
              RoundedAppBar(
                title: 'سجل الطلبات',
                subTitle: 'لديك ${data.length} طلب ',
              ),
              Expanded(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, i) {
                  final history = data[i];
                  return GestureDetector(
                    onTap: () => Get.to(() => OrderBookScreenDetails(
                          delivers: history,
                        )),
                    child: OrderBookItem(
                      index: i,
                      history: history,
                    ),
                  );
                },
              ))
            ],
          );
        }),
      ),
    );
  }
}
