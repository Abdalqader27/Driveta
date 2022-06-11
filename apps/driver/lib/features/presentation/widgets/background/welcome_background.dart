import 'package:driver/generated/assets.dart';
import 'package:flutter/material.dart';

class WelcomeBackground extends StatelessWidget {
  final Widget child;

  const WelcomeBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              Assets.imagesMainTop,
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              Assets.imagesMainBottom,
              width: size.width * 0.2,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
