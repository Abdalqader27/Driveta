import 'package:design/design.dart';
import 'package:driver/features/presentation/widgets/painter/app_bar_shape.dart';
import 'package:driver/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'circle_button.dart';

class RoundedAppBar extends StatelessWidget {
  final Function? onTapLeading;
  final String title;
  final String? subTitle;
  final Color? color;
  const RoundedAppBar({
    Key? key,
    this.onTapLeading,
        this.color,

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
          size: Size(context.width, 105.5),
          painter: AppBarCustomPainterShape(color??colors.primary),
        ),
        CustomPaint(
          size: Size(context.width, 100.0),
          painter: AppBarCustomPainterShape(themeData.scaffoldBackgroundColor),
        ),
        SPadding.all8(
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                      child: ListTile(
                    title: SText.bodyMedium(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: SText.bodyMedium(
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
