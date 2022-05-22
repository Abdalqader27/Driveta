import 'package:flutter/material.dart';

import '../../../../../../common/config/theme/colors.dart';
import '../../../../../../libraries/el_widgets/el_widgets.dart';

class BalanceItem extends StatelessWidget {
  final int index;
  final String invoiceNumber;
  final String invoiceMoney;

  const BalanceItem({Key? key, required this.index, required this.invoiceNumber, required this.invoiceMoney})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: kPRIMARY,
        child: Text(index.toString()),
      ),
      title: const MaterialText.subTitle2('رقم الفاتورة '),
      subtitle: MaterialText.caption(invoiceNumber),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.attach_money),
          MaterialText.caption(invoiceMoney),
        ],
      ),
    );
  }
}
