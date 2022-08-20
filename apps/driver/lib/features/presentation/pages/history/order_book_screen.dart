import 'package:design/design.dart';
import 'package:driver/features/data/models/delivers.dart';
import 'package:driver/features/presentation/pages/history/widgets/order_book_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../manager/container.dart';
import '../../widgets/round_app_bar.dart';
import 'order_book_screen_details.dart';

class OrderBookScreen extends StatelessWidget {
  const OrderBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: HistoryContainer(builder: (context, List<Delivers> data) {
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
