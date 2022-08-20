import 'package:design/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:rider/common/config/theme/colors.dart';
import 'package:rider/features/data/database/app_db.dart';
import 'package:rider/features/presentation/manager/container.dart';
import 'package:rider/features/presentation/pages/map/map_store/parts/main_store/main_store.dart';
import 'package:rider/features/presentation/pages/map/map_store/parts/product_store/product_store.dart';

import '../../../../../common/widgets/custom_tab_indicator.dart';
import '../../../../../common/widgets/round_app_bar.dart';
import '../../../../../libraries/el_widgets/widgets/material_text.dart';

class MapStoreScreenDetails extends StatefulWidget {
  final Shop shop;

  const MapStoreScreenDetails({Key? key, required this.shop}) : super(key: key);

  @override
  State<MapStoreScreenDetails> createState() => _MapStoreScreenDetailsState();
}

class _MapStoreScreenDetailsState extends State<MapStoreScreenDetails> {
  int index = 0;

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
              RoundedAppBar(
                title: 'متجر ${widget.shop.name}',
                subTitle: 'اهلا وسهلا بك ',
              ),
              Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: DefaultTabController(
                    initialIndex: index,
                    length: 2,
                    child: TabBar(
                        labelPadding: const EdgeInsets.all(10),
                        indicatorPadding: const EdgeInsets.all(0),
                        isScrollable: true,
                        onTap: (index) {
                          setState(() => this.index = index);
                        },
                        labelStyle: const TextStyle(
                            fontSize: 25,
                            color: kBlack,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'sst-arabic'),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 11,
                          color: kGrey6,
                          fontFamily: 'sst-arabic',
                          fontWeight: FontWeight.w600,
                        ),
                        indicator: RoundedRectangleTabIndicator(
                            weight: 3, width: 20, color: kPRIMARY),
                        tabs: [
                          Tab(
                            child: Container(
                              margin: const EdgeInsets.only(right: 23),
                              child: MaterialText(
                                ' المتجر  ',
                                style: TextStyle(
                                    color: index == 0 ? kPRIMARY : kGrey3),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              margin: const EdgeInsets.only(right: 23),
                              child: MaterialText(
                                'المنتجات ',
                                style: TextStyle(
                                    color: index == 1 ? kPRIMARY : kGrey3),
                              ),
                            ),
                          ),
                        ]),
                  )),
              Expanded(
                child: GetStoreContainer(
                  id: widget.shop.id,
                  builder: (context, storeDetails) {
                    if (index == 0) {
                      return StoreMain(
                        storeDetails: storeDetails,
                      );
                    }
                    return StoreProduct(
                      storeDetails: storeDetails,
                    );
                  },
                ),
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
}
