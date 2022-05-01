import 'package:flutter/material.dart';

import '../../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import 'balance_item.dart';
import 'balance_transaction.dart';

class BalanceBodyWidget extends StatelessWidget {
  const BalanceBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const RPadding.all8(
            child: MaterialText.subTitle2('المعاملات المالية'),
          ),
          const BalanceTransactionWidget(
            salary: 12.31232,
            total: 222222,
          ),
          Expanded(
              child: ListView.separated(
            itemCount: 10,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return BalanceItem(
                index: index + 1,
                invoiceMoney: '12000',
                invoiceNumber: '#123213',
              );
            },
          ))
        ],
      ),
    );
  }
}
