import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/common/utils/signal_r.dart';
import 'package:rider/common/widgets/round_app_bar.dart';
import 'package:rider/features/presentation/pages/map/map_trip_product/provider/map_trip_provider.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../../../../common/assistants/assistantMethods.dart';
import '../../../../../common/config/theme/colors.dart';
import '../../../../../common/widgets/svg_icon.dart';
import '../../../../../generated/assets.dart';
import '../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../../main.dart';
import '../../../../data/models/delivers_product.dart';
import '../../../../data/models/direct_details.dart';
import '../../../../data/models/store.dart';
import '../../orders_history/widget/header_item.dart';
import '../map_trip_live/widget/location_granted_widget.dart';
import '../widgets/choice_cars.dart';

late Timer orderDeliveryTimer;

class OrderDeliveryDetails extends StatefulWidget {
  final StoreDetails storeDetails;
  final Map<String, num> productMap;

  const OrderDeliveryDetails(
      {Key? key, required this.storeDetails, required this.productMap})
      : super(key: key);

  @override
  State<OrderDeliveryDetails> createState() => _OrderDeliveryDetailsState();
}

class _OrderDeliveryDetailsState extends State<OrderDeliveryDetails> {
  XData data = XData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data.storeDetails = widget.storeDetails;
    data.productMap = widget.productMap;
  }

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
                title: 'تفاصيل الطلب',
                subTitle: 'اهلا وسهلا بك ',
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: FutureBuilder<LocationData>(
                    future: location.getLocation(),
                    builder: (context, point) {
                      if (!point.hasData || point.data == null) {
                        return const CircularProgressIndicator();
                      }
                      data.start =
                          LatLng(point.data!.latitude!, point.data!.longitude!);
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
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
                                        FutureBuilder<String>(
                                            future: AssistantMethods
                                                .searchCoordinateAddress(LatLng(
                                                    point.data!.latitude!,
                                                    point.data!.longitude!)),
                                            builder: (context, snap) {
                                              if (!snap.hasData) {
                                                return const Padding(
                                                  padding: EdgeInsets.all(28.0),
                                                  child: Center(
                                                    child: Text(
                                                        '....جاري التحميل'),
                                                  ),
                                                );
                                              }
                                              return HeaderItem(
                                                  context: context,
                                                  title: 'المكان الانطلاق',
                                                  subtitle: data.pickText =
                                                      snap.data!);
                                            }),
                                        DottedLine(
                                          dashColor:
                                              Colors.grey.withOpacity(.5),
                                        ),
                                        FutureBuilder<String>(
                                            future: AssistantMethods
                                                .searchCoordinateAddress(
                                              LatLng(
                                                  double.parse(
                                                      widget.storeDetails.lat!),
                                                  double.parse(widget
                                                      .storeDetails.long!)),
                                            ),
                                            builder: (context, snap) {
                                              if (!snap.hasData) {
                                                return const Padding(
                                                  padding: EdgeInsets.all(28.0),
                                                  child: Center(
                                                    child: Text(
                                                        '....جاري التحميل'),
                                                  ),
                                                );
                                              }
                                              return HeaderItem(
                                                  context: context,
                                                  title: 'االوجهة',
                                                  subtitle: data.dropText =
                                                      snap.data!);
                                            }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: FutureBuilder<DirectionDetails?>(
                                  future: AssistantMethods
                                      .obtainPlaceDirectionDetails(
                                          LatLng(point.data!.latitude!,
                                              point.data!.longitude!),
                                          LatLng(
                                              double.parse(
                                                  widget.storeDetails.lat!),
                                              double.parse(
                                                  widget.storeDetails.long!))),
                                  builder: (context, snap) {
                                    if (!snap.hasData || snap.data == null) {
                                      return const Padding(
                                        padding: EdgeInsets.all(28.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                    data.details = snap.data;
                                    return ChoiceCarsWidget(
                                      isChosen: true,
                                      height: 250,
                                      directionDetails: snap.data!,
                                      onTap: (carDetails) {
                                        setState(() {
                                          data.carDetails = carDetails;
                                        });
                                      },
                                    );
                                  }),
                            ),
                            Card(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    MaterialText.subTitle1('المنتجات '),
                                    GridView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: filter2().length,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: .9,
                                              crossAxisCount: 3),
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        final item = filter2()[i];
                                        return Card(
                                          margin: const EdgeInsets.all(5),
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    item.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                  )),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  child: Text(
                                                    "${item.price}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 10,
                                                            color: kGrey4),
                                                  )),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    '${widget.productMap[item.id]}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 20),
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    onTap: widget.productMap[
                                                                item.id]! <=
                                                            20
                                                        ? () {
                                                            setState(() => widget
                                                                    .productMap[
                                                                item.id] = widget
                                                                        .productMap[
                                                                    item.id]! +
                                                                1);
                                                          }
                                                        : null,
                                                    child: const SVGIcon(
                                                        Assets.iconsPlus),
                                                  ),
                                                  InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    onTap: widget.productMap[
                                                                item.id]! >
                                                            0
                                                        ? () {
                                                            setState(() => widget
                                                                    .productMap[
                                                                item.id] = widget
                                                                        .productMap[
                                                                    item.id]! -
                                                                1);
                                                          }
                                                        : null,
                                                    child: const SVGIcon(
                                                        Assets.iconsMinice),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Card(
                              shape: const RoundedRectangleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: InkWell(
                                    child: Lottie.asset(
                                        "lotti_files/61342-shopping-basket.json"),
                                    onTap: () {},
                                  ),
                                  title: MaterialText.bodyText1(
                                    'الكلفة الكلية',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 18.sp),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.storefront),
                                          SizedBox(width: 5),
                                          Text("${(widget.productMap.keys.map((e) {
                                                return widget.productMap[e]! *
                                                    double.parse(widget
                                                        .storeDetails.products!
                                                        .firstWhere((element) {
                                                          return element.id ==
                                                              e;
                                                        })
                                                        .defaultPrice
                                                        .toString());
                                              }).toList().fold(0, (num a, num b) => a + b).toDouble())}"),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          data.carDetails != null &&
                                                  data.carDetails!.item1 ==
                                                      'دراجة'
                                              ? Icon(Icons.delivery_dining)
                                              : Icon(Icons.local_taxi_outlined),
                                          SizedBox(width: 5),
                                          Text("${calcPrice(
                                            start: data.carDetails?.item2 ?? 0,
                                            distance:
                                                data.details?.distanceValue ??
                                                    0,
                                          ).toDouble()}"),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(width: 80, child: DottedLine()),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${data.price = (widget.productMap.keys.map((e) {
                                                  return widget.productMap[e]! *
                                                      double.parse(widget
                                                          .storeDetails
                                                          .products!
                                                          .firstWhere(
                                                              (element) {
                                                            return element.id ==
                                                                e;
                                                          })
                                                          .defaultPrice
                                                          .toString());
                                                }).toList().fold(0, (num a, num b) => a + b) + calcPrice(
                                              start:
                                                  data.carDetails?.item2 ?? 0,
                                              distance:
                                                  data.details?.distanceValue ??
                                                      0,
                                            ))} ل.س",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  trailing: SizedBox(
                                      width: 120,
                                      child: CupertinoButton(
                                        color: kPRIMARY,
                                        padding: EdgeInsets.zero,
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        onPressed: data.carDetails == null
                                            ? null
                                            : () {
                                                orderDeliveryTimer = Timer(
                                                    const Duration(seconds: 30),
                                                    () {
                                                  BotToast.closeAllLoading();
                                                  BotToast.showText(
                                                      text:
                                                          'لايوجد سائقين متاحين');
                                                });
                                                BotToast.showLoading();
                                                final delivery =
                                                    DeliversProduct(
                                                        pickUp: data.pickText!,
                                                        startLat: data
                                                            .start!.latitude
                                                            .toString(),
                                                        startLong: data
                                                            .start!.longitude
                                                            .toString(),
                                                        price:
                                                            data.price!.toInt(),
                                                        dropOff: data.dropText!,
                                                        endLat: data
                                                            .storeDetails!.lat!,
                                                        distance: data.details!
                                                            .distanceValue,
                                                        endLong: data
                                                            .storeDetails!
                                                            .long!,
                                                        expectedTime:
                                                            data.details!
                                                                .durationText
                                                                .toString(),
                                                        vehicleType: data
                                                            .carDetails!.item2,
                                                        details: filter());
                                                si<MapTripProductProvider>()
                                                        .setDeliversProduct =
                                                    delivery;
                                                SignalRRider()
                                                    .addDeliveryProduct(
                                                        deliverProduct:
                                                            delivery);

                                                print(
                                                    "orderee ${delivery.expectedTime}");
                                              },
                                        child: MaterialText.button(
                                          'طلب',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button!
                                              .copyWith(color: Colors.white),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
          Positioned(
              left: 20,
              top: 80,
              child: Lottie.asset("lotti_files/22193-partly-cloudy.json",
                  height: 70)),
        ],
      ),
    );
  }

  List<Detail> filter() {
    List<Detail> list = [];
    widget.productMap.forEach((key, value) {
      if (widget.productMap[key]! > 0) {
        list.add(Detail(
          productId: key,
          quantity: value,
        ));
      }
    });
    return list;
  }

  List<XData2> filter2() {
    List<XData2> list = [];
    widget.productMap.forEach((key, value) {
      if (widget.productMap[key]! > 0) {
        list.add(XData2(
            id: key,
            quantity: value,
            name: widget.storeDetails.products!
                .firstWhere((element) => element.id == key)
                .name!,
            price: widget.storeDetails.products!
                .firstWhere((element) => element.id == key)
                .defaultPrice!));
      }
    });
    return list;
  }

  int calcPrice({required int distance, required int start}) {
    int factor = start ~/ 2;
    var temp = (distance / 250.0).round();
    return start + temp * factor;
  }
}

class XData {
  String? pickText;
  String? dropText;
  LatLng? start;
  num? price;
  DirectionDetails? details;
  StoreDetails? storeDetails;
  CarDetails? carDetails;
  Map<String, num>? productMap;
  Map<String, num>? filteredProductMap;
}

class XData2 {
  final String id;
  final String name;
  final num quantity;
  final num? price;

  XData2(
      {required this.price,
      required this.id,
      required this.name,
      required this.quantity});
}
