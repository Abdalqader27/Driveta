import 'package:flutter/material.dart';

class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController? controller;
  final Widget? child;

  const CustomOffsetAnimation({Key? key, this.controller, this.child})
      : super(key: key);

  @override
  State<CustomOffsetAnimation> createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  late Tween<Offset> tweenOffset;
  late Tween<double> tweenScale;

  late Animation<double> animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.8),
      end: Offset.zero,
    );
    tweenScale = Tween<double>(begin: 0.3, end: 1.0);
    animation =
        CurvedAnimation(parent: widget.controller!, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller!,
      builder: (BuildContext context, Widget? child) {
        return FractionalTranslation(
            translation: tweenOffset.evaluate(animation),
            child: ClipRect(
              child: Transform.scale(
                scale: tweenScale.evaluate(animation),
                child: Opacity(
                  opacity: animation.value,
                  child: child,
                ),
              ),
            ));
      },
      child: widget.child,
    );
  }
}
