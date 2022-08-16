import 'package:design/design.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../../../../../generated/assets.dart';
import '../../../../data/models/delivers.dart';
import 'chip_item.dart';
import 'header_item.dart';

class OrderBookItem extends StatelessWidget {
  final Delivers history;
  final int index;
  final GestureTapCallback? onTap;

  const OrderBookItem(
      {Key? key, this.onTap, required this.history, required this.index})
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
            title: RichText(
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(
                text: 'تاريخ الرحلة :',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            subtitle: Wrap(
              children: [
                Text(
                    history.startDate != null
                        ? DateFormat('yyyy-MM-dd – hh:mm')
                            .format(DateTime.parse(history.startDate))
                        : '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w400, color: kGrey4)),
              ],
            ),
            leading: CircleAvatar(child: Center(child: Text('${index + 1}'))),
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
                        subtitle: '${history.pickUp}'),
                    DottedLine(
                      dashColor: Colors.grey.withOpacity(.5),
                    ),
                    HeaderItem(
                        context: context,
                        title: ' الوجهة',
                        subtitle: '${history.dropOff} '),
                  ],
                ),
              ),
            ],
          ),
          Wrap(
            children: [
              // TODO add time and distance and money
              ChipItem(
                iconData: Icons.access_time,
                title: '${history.expectedTime?.replaceAll('mins', 'د  ')}',
              ),
              ChipItem(
                iconData: Icons.add_road_rounded,
                title: '${history.distance}  متر ',
              ),
              ChipItem(
                iconData: Icons.account_balance_wallet_outlined,
                title: '${history.price} ل.س',
              ),
            ],
          ),
          const SSizedBox.v12(),
        ],
      ),
    );
  }
}
