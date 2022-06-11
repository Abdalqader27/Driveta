import 'package:driver/features/presentation/pages/history/widgets/order_book_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../DataHandler/appData.dart';
import '../../widgets/round_app_bar.dart';
import '../../manager/container.dart';

class OrderBookScreen extends StatelessWidget {
  const OrderBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: HistoryContainer(builder: (context, data) {
          return Column(
            children: [
              const RoundedAppBar(
                title: 'سجل الطلبات',
                subTitle: 'لديك 25 طلب ',
              ),
              Expanded(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return OrderBookItem(
                    history: Provider.of<AppData>(context, listen: false).tripHistoryDataList[index],
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
