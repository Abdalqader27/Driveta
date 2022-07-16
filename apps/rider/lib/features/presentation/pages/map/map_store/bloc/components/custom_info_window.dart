import 'package:clippy_flutter/triangle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rider/common/config/theme/colors.dart';

import '../../../../../../data/database/app_db.dart';
import '../../map_store_screen_details.dart';

class CustomInfoWidget extends StatelessWidget {
  final Shop shop;

  const CustomInfoWidget({Key? key, required this.shop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => MapStoreScreenDetails(
              id: shop.id,
            ));
      },
      child: Column(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: kPRIMARY,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    '${shop.name}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(color: kWhite),
                  )),
            ),
          ),
          Triangle.isosceles(
            edge: Edge.BOTTOM,
            child: Container(
              color: kPRIMARY,
              width: 20.0,
              height: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}
