import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rider/features/presentation/pages/orders_history/widget/order_history_item.dart';

import '../../../../../common/widgets/round_app_bar.dart';
import '../../../../common/widgets/lottie_widget.dart';
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
                  child: data.isEmpty
                      ? const LottieWidget.empty(width: 300)
                      : AnimationLimiter(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final history = data[index];

                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 80.0,
                                  child: FadeInAnimation(
                                    child: GestureDetector(
                                      onTap: () =>
                                          Get.to(() => OrderBookScreenDetails(
                                                delivers: history,
                                              )),
                                      child: OrderBookItem(
                                        index: index,
                                        history: history,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ))
            ],
          );
        }),
      ),
    );
  }
}
