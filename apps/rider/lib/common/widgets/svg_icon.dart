import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGIcon extends StatelessWidget {
  const SVGIcon(this.assetName, {Key? key, this.size, this.color})
      : super(key: key);
  final String assetName;
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: size,
      width: size,
      color: color,
    );
  }
}
