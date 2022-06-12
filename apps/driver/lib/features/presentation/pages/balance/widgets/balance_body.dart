import 'package:design/design.dart';

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
          const SSizedBox.v16(),
          const SPadding.all12(
            child: SText.bodyMedium('الفواتير'),
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
