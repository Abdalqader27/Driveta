import 'package:design/design.dart';
import 'package:driver/features/presentation/pages/map_driver/available_deliver.dart';
import 'package:driver/features/presentation/pages/support/support_complaint_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../../../common/config/theme/colors.dart';
import '../../../../../../features/presentation/pages/balance/balance_screen.dart';
import '../../../../../../configMaps.dart';
import '../../../../../../features/presentation/pages/sgin_in/login_screen.dart';
import '../../../../../../main.dart';
import '../../../../../../features/presentation/pages/history/order_book_screen.dart';
import '../../../../../../features/presentation/pages/profile/profile_page.dart';
import '../../about_app/about_app_screen.dart';
import 'map_drawer_item.dart';

class MapDrawer extends StatelessWidget {
  final VoidCallback? onClose;

  const MapDrawer({Key? key, this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SPadding.all8(
      child: Column(
        children: [
          Expanded(
            child: SSizedBox(
              width: .7 * context.width,
              child: ListView(
                reverse: false,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: kPRIMARY,
                    child: MapDrawerItem(
                      icon: Icons.account_circle_outlined,
                      title: 'الملف الشخصي ',
                      leadingText: const SizedBox.shrink(),
                      color: Colors.white,
                      textColor: Colors.white,
                      onTap: () => Get.to(() => const ProfilePage()),
                    ),
                  ),
                  const SSizedBox.v4(),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
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
                            icon: Icons.event_available,
                            title: 'الطلبات المتاحة ',
                            leadingText: const SizedBox.shrink(),
                            onTap: () =>
                                Get.to(() => const AvailableDeliveries())),
                        MapDrawerItem(
                            icon: Icons.account_balance_wallet,
                            title: 'الرصيد',
                            leadingText: const SizedBox.shrink(),
                            onTap: () => Get.to(() => const BalanceScreen())),
                        MapDrawerItem(
                            icon: Icons.help,
                            title: 'الدعم والشكوى',
                            leadingText: const SizedBox.shrink(),
                            onTap: () => Get.to(() => const SupportScreen())),
                        MapDrawerItem(
                          icon: Icons.logout,
                          title: 'تسجيل الخروج',
                          leadingText: const Text(''),
                          onTap: () {
                            try {
                              //   Geofire.removeLocation(currentfirebaseUser!.uid);
                              // rideRequestRef?.onDisconnect();
                              // rideRequestRef?.remove();
                              // rideRequestRef = null;
                              FirebaseAuth.instance.signOut();
                            } catch (_) {}
                            Navigator.pushNamedAndRemoveUntil(context,
                                LoginScreen.idScreen, (route) => false);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SSizedBox.v4(),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
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
          SPadding.all8(
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
