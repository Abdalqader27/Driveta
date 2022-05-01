import 'package:driver/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/config/theme/colors.dart';
import '../../../../../../libraries/el_widgets/el_widgets.dart';

class BalanceTransactionWidget extends StatelessWidget {
  const BalanceTransactionWidget({Key? key, required this.total, required this.salary}) : super(key: key);
  final double total;
  final double salary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MaterialText.headLine6('الإجمالي'),
                  const RSizedBox.v8(),
                  MaterialText.bodyText2(total.toString())
                ],
              ),
            ),
            Container(
              width: 1.w,
              height: 50.h,
              color: kGREY,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MaterialText.headLine6('رصيدك  '),
                  const RSizedBox.v8(),
                  MaterialText.bodyText2(salary.toString())
                ],
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
