import 'package:design/design.dart';
import 'package:driver/features/data/models/invoices.dart';
import 'package:get/get.dart';

import '../balance_deleivers.dart';
import 'balance_item.dart';

class BalanceBodyWidget extends StatelessWidget {
  final Invoices invoices;
  const BalanceBodyWidget({Key? key, required this.invoices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (invoices.invoices?.isEmpty ?? true) {
      return Expanded(
        child: const SPadding.all12(
          child: SText.bodyMedium('لايوجد فواتير'),
        ),
      );
    }
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
              itemCount: invoices.invoices?.length ?? 0,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final invoice = invoices.invoices![index];
                return GestureDetector(
                  onTap: () => Get.to(() => BalanceDelivers(
                        invoice: invoice,
                      )),
                  child: BalanceItem(
                    index: index + 1,
                    invoiceMoney: invoice.total.toString(),
                    invoiceNumber: invoice.invoiceNumber ?? '',
                  ),
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
