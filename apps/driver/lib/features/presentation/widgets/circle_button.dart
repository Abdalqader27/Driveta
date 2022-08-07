import 'package:driver/common/animations/bouncing_animation.dart';
import 'package:driver/common/config/theme/colors.dart';
import 'package:flutter/material.dart';

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
        padding: EdgeInsets.all(contentPadding),
        height: height,
        width: width,
        child: Icon(
          iconData,
          color: kPRIMARY,
        ),
      ),
    );
  }
}
