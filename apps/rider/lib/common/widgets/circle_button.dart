import 'package:flutter/material.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../animations/bouncing_animation.dart';
import '../config/theme/colors.dart';

class CircleButton extends StatelessWidget {
  final void Function() onTap;
  final String? svgIcon;
  final IconData? iconData;
  final double height, width;
  final double contentPadding;

  const CircleButton(
      {Key? key,
      required this.onTap,
      this.svgIcon,
      this.height = 45.5,
      this.width = 45.5,
      this.contentPadding = 10.0,
      this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingAnimation(
      onPressed: onTap,
      child: Container(
        // decoration: kBoxRoundRec,
        padding: EdgeInsets.all(contentPadding.sp),
        height: height.w,
        width: width.w,
        child: Icon(
          iconData,
          color: kPRIMARY,
        ),
      ),
    );
  }
}
