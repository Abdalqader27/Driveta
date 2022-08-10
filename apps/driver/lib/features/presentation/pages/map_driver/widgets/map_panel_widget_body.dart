import 'package:design/design.dart';
import 'package:driver/features/presentation/manager/container.dart';
import 'package:driver/features/presentation/manager/event.dart';
import 'package:driver/features/presentation/pages/history/widgets/order_book_item.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../../common/config/theme/colors.dart';
import '../../../../../../features/presentation/pages/balance/widgets/balance_transaction.dart';
import '../../../../../../features/presentation/pages/history/order_book_screen.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../app_injection.dart';
import '../../../manager/bloc.dart';
import '../../../widgets/show_more_widget.dart';

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
                  si<DriverBloc>().add(GetStatisticsEvent());
                  si<DriverBloc>().add(GetHistoriesEvent());
                  si<DriverBloc>().add(GetInvoicesEvent());

                  panelController.open();
                }
              },
              child: Material(
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SSizedBox.v4(),
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
              child: StatisticsContainer(builder: (context, data) {
                return Row(
                  children: <Widget>[
                    _PanelItem(
                      title: 'الإيرادات',
                      subtitle: data.totalAmount.toStringAsFixed(2),
                      path: Assets.iconsMoney,
                    ),
                    _PanelItem(
                      title: 'تقييمك',
                      subtitle: data.rateAvg.toStringAsFixed(2),
                      path: Assets.iconsRate,
                    ),
                    _PanelItem(
                      title: 'اجمالي الرحلات',
                      subtitle: data.deliveryCount.toStringAsFixed(0),
                      path: Assets.iconsPayment,
                    ),
                  ],
                );
              }),
            ),
            // InvoiceContainer(builder: (context, data) {
            //   return BalanceItem(
            //     index: 1,
            //     invoiceMoney: data.invoices?.first.total.toString() ?? '0',
            //     invoiceNumber: data.invoices?.first.invoiceNumber ?? '',
            //   );
            // }),
            // ShowMoreWidget(
            //   onPressed: () {
            //     Get.to(() => const BalanceScreen());
            //   },
            //   title: 'اخر المعاملات',
            //   buttonText: 'عرض الكل',
            // ),
            HistoryContainer(builder: (context, data) {
              return OrderBookItem(
                index: 0,
                history: data.first,
              );
            }),
            ShowMoreWidget(
              onPressed: () {
                Get.to(() => const OrderBookScreen());
              },
              title: 'اخر التوصيلات',
              buttonText: 'عرض الكل',
            ),
            InvoiceContainer(builder: (context, data) {
              return BalanceTransactionWidget(
                salary: data.totalAmount!.toStringAsFixed(2),
                total: data.monthAmount!.toStringAsFixed(2),
              );
            }),
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
