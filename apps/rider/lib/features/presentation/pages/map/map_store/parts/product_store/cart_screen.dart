import 'package:design/design.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:rider/features/data/models/store.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../common/widgets/round_app_bar.dart';
import '../../../../../../../common/widgets/svg_icon.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../../../libraries/el_widgets/widgets/material_text.dart';

class CartScreen extends StatefulWidget {
  final StoreDetails store;
  final Map<String, num> productMap;

  const CartScreen({Key? key, required this.productMap, required this.store})
      : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              const RoundedAppBar(
                title: 'السلة  ',
                subTitle: 'اهلا وسهلا بك ',
              ),
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(30),
                      itemCount: widget.store.products!.length,
                      itemBuilder: (context, i) {
                        final product = widget.store.products![i];
                        final item = {
                          "id": product.id,
                          "price": product.defaultPrice,
                          "name": product.name,
                          "qty": widget.productMap[product.id] ?? 0,
                        };
                        if (item["qty"] == 0) return SizedBox.shrink();
                        return Card(
                          margin: const EdgeInsets.all(5),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "${item['name']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                        )),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Text(
                                          "${item["price"]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10,
                                                  color: kGrey4),
                                        )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      borderRadius: BorderRadius.circular(11),
                                      child: const SVGIcon(Assets.iconsPlus),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          '${item['qty']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                        )),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(11),
                                      child: const SVGIcon(Assets.iconsMinice),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                        ;
                      })),
              DottedLine(
                dashColor: kGrey3,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                        title: MaterialText.bodyText1(
                          'الكلفة',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 20.sp),
                        ),
                        trailing: MaterialText.headLine6(
                            "${widget.productMap.keys.map((e) {
                                  return widget.productMap[e]! *
                                      double.parse(widget.store.products!
                                          .firstWhere((element) {
                                            return element.id == e;
                                          })
                                          .defaultPrice
                                          .toString());
                                }).toList().reduce((a, b) => a + b)}"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
