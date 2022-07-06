import 'package:design/design.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:driver/common/utils/signal_r_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:units_converter/models/extension_converter.dart';
import 'package:units_converter/properties/length.dart';
import 'package:driver/features/data/models/delivers.dart';

import '../../../../../common/config/theme/colors.dart';
import '../../../../../generated/assets.dart';
import '../../history/widgets/chip_item.dart';
import '../../history/widgets/header_item.dart';

class AvailableDeliveriesItem extends StatelessWidget {
  final Delivers delivers;
  final GestureTapCallback? onTap;

  const AvailableDeliveriesItem({Key? key, this.onTap, required this.delivers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: kPRIMARY,
              child: Icon(Icons.person),
            ),
            title: SText.bodyMedium(
              delivers.customerName,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: SPadding.v10(
              child: Wrap(
                children: [
                  // TODO add time and distance and money
                  ChipItem(
                    iconData: Icons.access_time,
                    title: delivers.expectedTime ?? '',
                  ),
                  ChipItem(
                    iconData: Icons.add_road_rounded,
                    title:
                        '${delivers.distance.convertFromTo(LENGTH.meters, LENGTH.kilometers)} KM',
                  ),
                  ChipItem(
                    iconData: Icons.account_balance_wallet_outlined,
                    title: '${delivers.distance}',
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SPadding.all16(
                child: SvgPicture.asset(
                  Assets.iconsIcRoute,
                  height: 80,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HeaderItem(
                        context: context,
                        title: 'المكان الانطلاق',
                        subtitle: delivers.pickUp),
                    DottedLine(
                      dashColor: Colors.grey.withOpacity(.5),
                    ),
                    HeaderItem(
                        context: context,
                        title: ' الوجهة',
                        subtitle: delivers.dropOff),
                  ],
                ),
              ),
            ],
          ),
          SPadding.h15(
              child: CupertinoButton(
            color: kPRIMARY,
            borderRadius: BorderRadius.circular(30),
            onPressed: onTap,
            child: Center(
              child: Text(
                'قبول ',
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Colors.white),
              ),
            ),
          )),
          const SSizedBox.v12()
        ],
      ),
    );
  }
}