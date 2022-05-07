import 'package:flutter/material.dart';
import 'package:rider/AllScreens/orders_history/widget/order_history_item.dart';

import '../../../../../common/widgets/round_app_bar.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const RoundedAppBar(
              title: 'سجل الطلبات',
              subTitle: 'لديك 25 طلب ',
            ),
            Expanded(
                child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const OrderHistoryItem();
              },
            ))
          ],
        ),
      ),
    );
  }
}
