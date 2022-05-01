import 'package:driver/features/map_driver/presentation/pages/balance/widgets/balance_body.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/round_app_bar.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            RoundedAppBar(
              title: 'الرصيد  ',
              subTitle: 'يمكنك مشاهدة معاملاتك المالية  ',
            ),
            BalanceBodyWidget()
          ],
        ),
      ),
    );
  }
}
