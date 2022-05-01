import 'package:driver/features/map_driver/presentation/pages/order_book/widgets/order_book_item.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/round_app_bar.dart';

class OrderBookScreen extends StatelessWidget {
  const OrderBookScreen({Key? key}) : super(key: key);

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
                return const OrderBookItem();
              },
            ))
          ],
        ),
      ),
    );
  }
}
