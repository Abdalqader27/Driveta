import 'package:design/design.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rider/features/presentation/manager/container.dart';
import 'package:rider/features/presentation/pages/orders_history/widget/header_item.dart';

import '../../../../../common/widgets/round_app_bar.dart';
import '../../../../../generated/assets.dart';
import '../../../../data/models/delivers_product.dart';
import '../../orders_history/widget/chip_item.dart';
import 'map_store_record_details.dart';

class MapStoreRecordScreen extends StatefulWidget {
  const MapStoreRecordScreen({Key? key}) : super(key: key);

  @override
  State<MapStoreRecordScreen> createState() => _MapStoreRecordScreenState();
}

class _MapStoreRecordScreenState extends State<MapStoreRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetDeliveriesProductContainer(
            builder: (context, List<DeliversProduct> data) {
          return Column(
            children: [
              RoundedAppBar(
                color: kGrey2,
                title: 'سجل الطلبات',
                subTitle: 'لديك ${data.length} طلب ',
              ),
              Expanded(
                  child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, i) {
                  final history = data[i];
                  return GestureDetector(
                    onTap: () => Get.to(() => MapStoreRecordDetails(
                          delivers: history,
                        )),
                    child: OrderRecordItem(
                      index: i,
                      history: history,
                    ),
                  );
                },
              ))
            ],
          );
        }),
      ),
    );
  }
}

class OrderRecordItem extends StatelessWidget {
  final DeliversProduct history;
  final int index;
  final GestureTapCallback? onTap;

  const OrderRecordItem(
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
                text: 'رقم الرحلة :',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            subtitle: Text(history.id ?? ''),
            leading: CircleAvatar(
                backgroundColor: kGrey2,
                child: Center(child: Text('${index + 1}'))),
          ),
          DottedLine(
            dashColor: Colors.grey.withOpacity(.5),
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
                    HeaderItem(
                        context: context,
                        title: ' الوجهة',
                        subtitle: '${history.dropOff} '),
                  ],
                ),
              ),
            ],
          ),
          DottedLine(
            dashColor: Colors.grey.withOpacity(.5),
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: RichText(
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: TextSpan(
                      text: 'اسم السائق :',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  subtitle: Text(history.driverName ?? ''),
                  leading: const CircleAvatar(
                      backgroundColor: kGrey2,
                      child: Center(child: Icon(Icons.perm_contact_cal))),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: RichText(
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: TextSpan(
                      text: 'رقم المركبة :',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  subtitle: Text(history.vehicleNumber),
                  leading: const CircleAvatar(
                      backgroundColor: kGrey2,
                      child: Center(child: Icon(Icons.numbers))),
                ),
              ),
            ],
          ),
          ListTile(
            title: RichText(
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(
                text: 'معرف المركبة :',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            subtitle: Text(
              history.vehicleId ?? '',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
            leading: const CircleAvatar(
                backgroundColor: kGrey2,
                child: Center(child: Icon(Icons.numbers))),
          ),
          DottedLine(
            dashColor: Colors.grey.withOpacity(.5),
          ),
          const SizedBox(height: 10),
          Wrap(
            children: [
              // TODO add time and distance and money
              ChipItem(
                iconData: Icons.access_time,
                title: history.expectedTime,
              ),
              ChipItem(
                iconData: Icons.add_road_rounded,
                title: '${history.distance}',
              ),
              ChipItem(
                iconData: Icons.account_balance_wallet_outlined,
                title: '${history.price}',
              ),
            ],
          ),
          const SSizedBox.v12(),
        ],
      ),
    );
  }
}
