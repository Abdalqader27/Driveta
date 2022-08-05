import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rider/features/presentation/pages/profile/profile_page.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../../../../libraries/el_widgets/widgets/responsive_sized_box.dart';
import '../../../common/config/theme/colors.dart';
import '../../../common/widgets/drawer_header.dart';
import '../../../main.dart';
import '../manager/container.dart';
import '../pages/about_app/about_app_page.dart';
import '../pages/orders_history/order_history_page.dart';
import '../pages/sgin_in/loginScreen.dart';
import '../pages/support/support_page.dart';
import 'map_drawer_item.dart';

class MapDrawer extends StatelessWidget {
  const MapDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RPadding.all8(
        child: Card(
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
                        color: kGREY.withOpacity(.2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            GetProfileContainer(builder: (context, data) {
                              return GestureDetector(
                                child: DrawerHeaderClipper(data: data),
                                onTap: () => Get.to(() => Profile(
                                      user: data,
                                    )),
                              );
                            }),
                            MapDrawerItem(
                                icon: Icons.playlist_add_check,
                                title: 'سجل الطلبات ',
                                leadingText: const SizedBox.shrink(),
                                onTap: () =>
                                    {Get.to(() => const OrderHistoryPage())}),
                            // MapDrawerItem(
                            //     icon: Icons.settings,
                            //     title: 'الاعدادات',
                            //     leadingText: const SizedBox.shrink(),
                            //     onTap: () =>
                            //         {Get.to(() => const SettingsPage())}),
                            MapDrawerItem(
                                icon: Icons.help,
                                title: 'الدعم والشكوى',
                                leadingText: const SizedBox.shrink(),
                                onTap: () =>
                                    {Get.to(() => const SupportScreen())}),
                            MapDrawerItem(
                                icon: Icons.info,
                                title: 'حول التطبيق',
                                leadingText: const SizedBox.shrink(),
                                onTap: () =>
                                    {Get.to(() => const AboutAppPage())}),
                          ],
                        ),
                      ),
                      const RSizedBox.v4(),
                      MapDrawerItem(
                        icon: Icons.logout,
                        title: 'تسجيل الخروج',
                        leadingText: const Text(''),
                        onTap: () {
                          si<SStorage>().clearAll();
                          Navigator.of(context).pop();

                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.idScreen, (route) => false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
