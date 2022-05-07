import 'package:flutter/material.dart';
import 'package:rider/common/config/theme/colors.dart';

import '../../../generated/assets.dart';

class SecondBackground extends StatelessWidget {
  final Widget child;

  const SecondBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              Assets.imagesMainTop,
              color: kSecondary.withOpacity(.5),
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              Assets.imagesLoginBottom,
              color: kPRIMARY.withOpacity(.2),
              width: size.width * 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
