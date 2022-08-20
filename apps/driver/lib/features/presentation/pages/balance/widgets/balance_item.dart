import 'package:design/design.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/config/theme/colors.dart';

class BalanceItem extends StatelessWidget {
  final int index;
  final String invoiceNumber;
  final String invoiceMoney;

  const BalanceItem(
      {Key? key,
      required this.index,
      required this.invoiceNumber,
      required this.invoiceMoney})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: kPRIMARY,
        child: Text(index.toString()),
      ),
      title: const SText.bodyMedium('رقم الفاتورة '),
      subtitle: SText.labelMedium(invoiceNumber),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SText.labelMedium("$invoiceMoney ل.س"),
        ],
      ),
    );
  }
}
