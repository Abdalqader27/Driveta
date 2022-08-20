import 'package:flutter/material.dart';
import 'package:rider/common/config/theme/colors.dart';

import '../../../generated/assets.dart';

class PrimaryBackground extends StatelessWidget {
  final Widget child;

  const PrimaryBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          child,
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              Assets.imagesSignupTop,
              width: size.width * 0.35,
              color: kSecondary,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              Assets.imagesMainBottom,
              width: size.width * 0.25,
              color: kPRIMARY,
            ),
          ),
        ],
      ),
    );
  }
}
