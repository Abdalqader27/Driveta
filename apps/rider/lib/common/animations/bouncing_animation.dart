import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class BouncingAnimation extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const BouncingAnimation({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
        duration: const Duration(milliseconds: 250),
        onPressed: onPressed,
        child: child);
  }
}
