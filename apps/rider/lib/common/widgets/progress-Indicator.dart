import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rider/common/config/theme/colors.dart';

class ProgressIndicatorLoading extends StatelessWidget {
  final Color? color;

  const ProgressIndicatorLoading({Key? key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) => Center(
        child: SpinKitDualRing(
          lineWidth: 3.5,
          color: color == null
              ? Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : kPRIMARY
              : color!,
          size: (30),
        ),
      );
}
