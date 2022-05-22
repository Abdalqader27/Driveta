import 'package:driver/common/config/theme/colors.dart';
import 'package:driver/features/invoice/presentation/manager/invoice/container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../DataHandler/appData.dart';
import '../../../../../common/widgets/round_app_bar.dart';
import '../../../../../generated/assets.dart';
import '../../../history/presentation/pages/order_book_screen.dart';
import '../widgets/balance_body.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const RoundedAppBar(
              title: 'الرصيد  ',
              subTitle: 'يمكنك مشاهدة معاملاتك المالية  ',
            ),
            Expanded(
              child: InvoiceContainer(builder: (context, data) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 70),
                        child: Column(
                          children: [
                            const Text(
                              'الاجمالي  الكلي',
                              style: TextStyle(color: kPRIMARY),
                            ),
                            Text(
                              "\$${data['totalAmount']}",
                              style: TextStyle(color: kPRIMARY, fontSize: 50, fontFamily: 'Brand Bold'),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      // margin: EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderBookScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.iconsCarTop,
                                width: 70,
                                height: 50,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              const Text(
                                'الرحلات الكلية',
                                style: TextStyle(fontSize: 16),
                              ),
                              // Expanded(
                              //     child: Container(
                              //         child: Text(
                              //   Provider.of<AppData>(context, listen: false).countTrips.toString(),
                              //   textAlign: TextAlign.end,
                              //   style: TextStyle(fontSize: 18),
                              // ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BalanceBodyWidget(),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
