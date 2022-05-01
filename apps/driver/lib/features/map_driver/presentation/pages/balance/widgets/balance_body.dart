import 'package:driver/libraries/el_widgets/el_widgets.dart';
import 'package:flutter/material.dart';

import 'balance_item.dart';

class BalanceBodyWidget extends StatelessWidget {
  const BalanceBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RSizedBox.v16(),
          const RPadding.all12(
            child: MaterialText.bodyText1('الفواتير'),
          ),
          Expanded(
              child: Card(
            child: ListView.separated(
              itemCount: 10,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return BalanceItem(
                  index: index + 1,
                  invoiceMoney: '12000',
                  invoiceNumber: '#123213',
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
