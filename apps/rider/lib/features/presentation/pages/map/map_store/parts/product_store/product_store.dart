import 'package:design/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/features/presentation/pages/map/map_store/parts/product_store/cart_screen.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../common/config/theme/colors.dart';
import '../../../../../../../common/widgets/svg_icon.dart';
import '../../../../../../../generated/assets.dart';
import '../../../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../../../data/models/store.dart';
import '../../order_delivery_details.dart';

class StoreProduct extends StatefulWidget {
  final StoreDetails storeDetails;

  const StoreProduct({Key? key, required this.storeDetails}) : super(key: key);

  @override
  State<StoreProduct> createState() => _StoreProductState();
}

class _StoreProductState extends State<StoreProduct> {
  Map<String, num> productMap = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var element in widget.storeDetails.products!) {
      productMap[element.id!] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            physics: const BouncingScrollPhysics(),
            itemCount: widget.storeDetails.products!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .9, crossAxisCount: 3),
            itemBuilder: (BuildContext context, int i) {
              final item = widget.storeDetails.products![i];
              return Card(
                margin: const EdgeInsets.all(5),
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          item.name!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
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
                          "${item.defaultPrice}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: kGrey4),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          '${productMap[item.id]}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(11),
                          onTap: productMap[item.id]! <= 20
                              ? () {
                                  setState(() => productMap[item.id!] =
                                      productMap[item.id]! + 1);
                                }
                              : null,
                          child: const SVGIcon(Assets.iconsPlus),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(11),
                          onTap: productMap[item.id]! > 0
                              ? () {
                                  setState(() => productMap[item.id!] =
                                      productMap[item.id]! - 1);
                                }
                              : null,
                          child: const SVGIcon(Assets.iconsMinice),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Card(
          shape: const RoundedRectangleBorder(),
          child: ListTile(
            leading: InkWell(
              child: Lottie.asset("lotti_files/61342-shopping-basket.json"),
              onTap: () {
                Get.to(() => CartScreen(
                    productMap: productMap, store: widget.storeDetails));
              },
            ),
            title: MaterialText.bodyText1(
              'الكلفة',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 15.sp),
            ),
            subtitle: Text("${productMap.keys.map((e) {
                  return productMap[e]! *
                      double.parse(widget.storeDetails.products!
                          .firstWhere((element) {
                            return element.id == e;
                          })
                          .defaultPrice
                          .toString());
                }).toList().fold(0, (num a, num b) => a + b)}"),
            trailing: SizedBox(
                width: 120,
                child: CupertinoButton(
                  color: kPRIMARY,
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(30.r),
                  onPressed: productMap.keys
                              .map((e) {
                                return productMap[e]! *
                                    double.parse(widget.storeDetails.products!
                                        .firstWhere((element) {
                                          return element.id == e;
                                        })
                                        .defaultPrice
                                        .toString());
                              })
                              .toList()
                              .fold(0, (num a, num b) => a + b) !=
                          0.0
                      ? () {
                          Get.to(() => OrderDeliveryDetails(
                              storeDetails: widget.storeDetails,
                              productMap: productMap));
                        }
                      : null,
                  child: MaterialText.button(
                    'مراجعة الطلب',
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
