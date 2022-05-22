import 'package:design/design.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:driver/Models/history.dart';
import 'package:driver/generated/assets.dart';
import 'package:driver/libraries/el_widgets/el_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'chip_item.dart';
import 'header_item.dart';

class OrderBookItem extends StatelessWidget {
  final History history;
  final GestureTapCallback? onTap;

  const OrderBookItem({Key? key, this.onTap, required this.history}) : super(key: key);

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
                    HeaderItem(context: context, title: 'المكان الانطلاق', subtitle: '${history.pickup}'),
                    DottedLine(
                      dashColor: Colors.grey.withOpacity(.5),
                    ),
                    HeaderItem(context: context, title: ' الوجهة', subtitle: '${history.dropOff} '),
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              // TODO add time and distance and money
              const ChipItem(
                iconData: Icons.access_time,
                title: '30 min',
              ),
              const ChipItem(
                iconData: Icons.add_road_rounded,
                title: '30 KM',
              ),
              ChipItem(
                iconData: Icons.account_balance_wallet_outlined,
                title: '${history.paymentMethod}',
              ),
            ],
          ),
          const SSizedBox.v12(),
        ],
      ),
    );
  }
}
