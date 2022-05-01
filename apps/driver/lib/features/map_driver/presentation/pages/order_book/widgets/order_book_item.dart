import 'package:dotted_line/dotted_line.dart';
import 'package:driver/generated/assets.dart';
import 'package:driver/libraries/el_widgets/el_widgets.dart';
import 'package:driver/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'chip_item.dart';
import 'header_item.dart';

class OrderBookItem extends StatelessWidget {
  final GestureTapCallback? onTap;

  const OrderBookItem({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RPadding.all16(
                child: SvgPicture.asset(
                  Assets.iconsIcRoute,
                  height: 80.r,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeaderItem(
                        context: context,
                        title: 'المكان الحالي',
                        subtitle:
                            'حلب - الميرديانالميرديانالميرديانالميرديانالميرديانالميرديانالميرديانالميرديانالميرديان'),
                    DottedLine(
                      dashColor: Colors.grey.withOpacity(.5),
                    ),
                    HeaderItem(context: context, title: ' الوجهة', subtitle: 'المحافظة '),
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            children: const [
              ChipItem(
                iconData: Icons.access_time,
                title: '30 min',
              ),
              ChipItem(
                iconData: Icons.add_road_rounded,
                title: '30 KM',
              ),
              ChipItem(
                iconData: Icons.account_balance_wallet_outlined,
                title: '10000 SP',
              ),
            ],
          ),
          const RSizedBox.v12(),
        ],
      ),
    );
  }
}
