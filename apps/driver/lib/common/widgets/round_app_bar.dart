import 'package:driver/generated/assets.dart';
import 'package:driver/libraries/el_widgets/el_widgets.dart';
import 'package:driver/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'circle_button.dart';
import 'painter/app_bar_shape.dart';

class RoundedAppBar extends StatelessWidget {
  final Function? onTapLeading;
  final String title;
  final String? subTitle;

  const RoundedAppBar({
    Key? key,
    this.onTapLeading,
    required this.title,
    this.subTitle,
  }) : super(key: key);

  // final text;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colors = themeData.colorScheme;
    return Stack(
      children: [
        CustomPaint(
          size: Size(1.sw, 105.5.h),
          painter: AppBarCustomPainterShape(colors.primary),
        ),
        CustomPaint(
          size: Size(1.sw, 100.0.h),
          painter: AppBarCustomPainterShape(themeData.scaffoldBackgroundColor),
        ),
        RPadding.all8(
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                      child: ListTile(
                    title: MaterialText.bodyText1(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 15.sp),
                    ),
                    subtitle: MaterialText.subTitle2(
                      subTitle ?? "",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  )),
                ),
                CircleButton(
                  onTap: () => Get.back(),
                  iconData: Icons.arrow_forward_ios,
                  svgIcon: Assets.iconsFiArrowUp,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
