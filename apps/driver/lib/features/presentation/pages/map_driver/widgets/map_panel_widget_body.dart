import 'package:design/design.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../../common/config/theme/colors.dart';
import '../../../widgets/show_more_widget.dart';
import '../../../../../../features/presentation/pages/balance/balance_screen.dart';
import '../../../../../../features/presentation/pages/balance/widgets/balance_item.dart';
import '../../../../../../features/presentation/pages/balance/widgets/balance_transaction.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../../features/presentation/pages/history/order_book_screen.dart';

class MapPanelWidgetBody extends StatelessWidget {
  final PanelController panelController;

  const MapPanelWidgetBody({Key? key, required this.panelController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          children: <Widget>[
            InkWell(
              onTap: () {
                if (panelController.isPanelOpen) panelController.close();
                if (panelController.isPanelClosed) {
                  // Provider.of<PanelProvider>(context, listen: false)
                  //     .reBuildWidget();
                  panelController.open();
                }
              },
              child: Material(
                clipBehavior: Clip.antiAlias,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SSizedBox.v4(),
                    const SSizedBox.v4(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                        ),
                      ],
                    ),
                    const SSizedBox.v12(),
                  ],
                ),
              ),
            ),
            SPadding.all8(
              child: Row(
                children: <Widget>[
                  _PanelItem(
                    title: 'الإيرادات',
                    subtitle: '1000',
                    path: Assets.iconsMoney,
                  ),
                  _PanelItem(
                    title: 'تقييمك',
                    subtitle: '1000',
                    path: Assets.iconsRate,
                  ),
                  _PanelItem(
                    title: 'اجمالي الرحلات',
                    subtitle: '123',
                    path: Assets.iconsRate,
                  ),
                ],
              ),

              // Consumer<PanelProvider>(
              //   builder: (context, provider, child) {
              //     return FutureBuilder<ApiResult<DriverPanel>>(
              //         future: provider.future,
              //         builder: (context, snapshot) {
              //           if (snapshot.data == null || !snapshot.hasData || snapshot.connectionState != ConnectionState.done) {
              //             return RPadding.all16(
              //               child: Center(
              //                 child: SizedBox(width: 35.r, height: 35.r, child: const CircularProgressIndicator()),
              //               ),
              //             );
              //           }
              //           return snapshot.data!.when(success: (data) {
              //             return Row(
              //               children: <Widget>[
              //                 _PanelItem(
              //                   title: 'الإيرادات',
              //                   subtitle: data.result.revenues.toString(),
              //                   path: Assets.iconsMoney,
              //                 ),
              //                 _PanelItem(
              //                   title: 'تقييمك',
              //                   subtitle: data.result.rateAvg.toString(),
              //                   path: Assets.iconsRate,
              //                 ),
              //                 _PanelItem(
              //                   title: 'اجمالي الرحلات',
              //                   subtitle: data.result.deliveryCount.toString(),
              //                   path: Assets.iconsCarspeed,
              //                 ),
              //               ],
              //             );
              //           }, failure: (error) {
              //             return MaterialText.subTitle2(error.toString());
              //           }, empty: () {
              //             return const MaterialText.subTitle2('لايوجد بيانات ');
              //           }, loading: () {
              //             return RPadding.all16(
              //               child: Center(
              //                 child: SizedBox(width: 35.r, height: 35.r, child: const CircularProgressIndicator()),
              //               ),
              //             );
              //           });
              //         });
              //   },
              // ),
            ),
            const BalanceItem(
              index: 10,
              invoiceMoney: '12000',
              invoiceNumber: '#123213',
            ),
            ShowMoreWidget(
              onPressed: () {
                Get.to(() => const BalanceScreen());
              },
              title: 'اخر المعاملات',
              buttonText: 'عرض الكل',
            ),
            //const OrderBookItem(),
            ShowMoreWidget(
              onPressed: () {
                Get.to(() => const OrderBookScreen());
              },
              title: 'اخر التوصيلات',
              buttonText: 'عرض الكل',
            ),
            BalanceTransactionWidget(
              salary: 12.31232.toString(),
              total: 222222.toString(),
            ),
          ]),
    );
  }
}

class _PanelItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String path;

  const _PanelItem(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SPadding.all8(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                path,
                width: 35,
                height: 35,
                color: kPRIMARY,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: SText.bodyMedium(title, textAlign: TextAlign.center),
                ),
              ),
              const Divider(),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child:
                      SText.bodyMedium(subtitle, textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
