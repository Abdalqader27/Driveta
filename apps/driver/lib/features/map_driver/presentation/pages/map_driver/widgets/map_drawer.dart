import 'package:driver/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../common/config/theme/colors.dart';
import '../../../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../../../../../libraries/el_widgets/widgets/responsive_sized_box.dart';
import '../../about_app/about_app_screen.dart';
import '../../balance/balance_screen.dart';
import '../../order_book/order_book_screen.dart';
import '../../support_complaint /support_complaint_screen.dart';
import 'map_drawer_item.dart';

class MapDrawer extends StatelessWidget {
  final VoidCallback? onClose;

  const MapDrawer({Key? key, this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RPadding.all8(
      child: Column(
        children: [
          Expanded(
            child: RSizedBox(
              width: .7.sw,
              child: ListView(
                reverse: false,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MapDrawerItem(
                            icon: Icons.playlist_add_check,
                            title: 'سجل الطلبات ',
                            leadingText: const SizedBox.shrink(),
                            onTap: () => Get.to(() => const OrderBookScreen())),
                        MapDrawerItem(
                            icon: Icons.account_balance_wallet,
                            title: 'الرصيد',
                            leadingText: const SizedBox.shrink(),
                            onTap: () => Get.to(() => const BalanceScreen())),
                        MapDrawerItem(
                            icon: Icons.help,
                            title: 'الدعم والشكوى',
                            leadingText: const SizedBox.shrink(),
                            onTap: () => Get.to(() => const SupportComplaintScreen())),
                        MapDrawerItem(
                          icon: Icons.logout,
                          title: 'تسجيل الخروج',
                          leadingText: const Text(''),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const RSizedBox.v4(),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: MapDrawerItem(
                        icon: Icons.info,
                        title: 'حول التطبيق',
                        leadingText: const SizedBox.shrink(),
                        onTap: () => Get.to(() => const AboutAppScreen())),
                  ),
                ],
              ),
            ),
          ),
          RPadding.all8(
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: kPRIMARY,
              child: const Icon(Icons.close),
              onPressed: onClose,
            ),
          )
        ],
      ),
    );
  }
}
