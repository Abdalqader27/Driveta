import 'package:flutter/material.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

class RPadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const RPadding({
    Key? key,
    required this.child,
    required this.padding,
  }) : super(key: key);

  const RPadding.all32({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.all(32),
        super(key: key);

  const RPadding.all16({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.all(16),
        super(key: key);
  const RPadding.all24({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.all(24),
        super(key: key);

  const RPadding.all12({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.all(12),
        super(key: key);

  const RPadding.all8({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.all(8),
        super(key: key);

  const RPadding.all4({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.all(4),
        super(key: key);

  const RPadding.all2({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.all(2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding is REdgeInsets ? padding : padding.r,
      child: child,
    );
  }
}

/// [REdgeInsets] extends form [EdgeInsets]  to make  EdgeInsets values
/// responsive using Flutter ScreenUtil
class REdgeInsets extends EdgeInsets {
  REdgeInsets.fromLTRB(double left, double top, double right, double bottom)
      : super.fromLTRB(left.r, top.r, right.r, bottom.r);

  REdgeInsets.all(double value) : super.all(value.r);

  REdgeInsets.symmetric({
    double vertical = 0,
    double horizontal = 0,
  }) : super.symmetric(vertical: vertical.r, horizontal: horizontal.r);

  REdgeInsets.only({
    double bottom = 0,
    double right = 0,
    double left = 0,
    double top = 0,
  }) : super.only(
          bottom: bottom.r,
          right: right.r,
          left: left.r,
          top: top.r,
        );

  REdgeInsets.all32() : super.all(32.r);

  REdgeInsets.all16() : super.all(16.r);

  REdgeInsets.all12() : super.all(12.r);

  REdgeInsets.all8() : super.all(8.r);

  REdgeInsets.all4() : super.all(4.r);

  REdgeInsets.all2() : super.all(2.r);
}

extension EdgeInsetsExtension on EdgeInsets {
  EdgeInsets get r => copyWith(
        top: top.r,
        bottom: bottom.r,
        right: right.r,
        left: left.r,
      );
}
