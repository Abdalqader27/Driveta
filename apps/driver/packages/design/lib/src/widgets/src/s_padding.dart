part of widgets;

/// TODO add const of padding values
class SPadding extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const SPadding({
    Key? key,
    required this.child,
    required this.padding,
  }) : super(key: key);

  const SPadding.all64({
    Key? key,
    required this.child,
  })  : padding = const SEdgeInsets.all64(),
        super(key: key);

  const SPadding.all32({
    Key? key,
    required this.child,
  })  : padding = const SEdgeInsets.all32(),
        super(key: key);

  const SPadding.all16({
    Key? key,
    required this.child,
  })  : padding = const SEdgeInsets.all16(),
        super(key: key);

  const SPadding.all12({
    Key? key,
    required this.child,
  })  : padding = const SEdgeInsets.all12(),
        super(key: key);

  const SPadding.all8({
    Key? key,
    required this.child,
  })  : padding = const SEdgeInsets.all8(),
        super(key: key);

  const SPadding.all4({
    Key? key,
    required this.child,
  })  : padding = const SEdgeInsets.all4(),
        super(key: key);

  const SPadding.all2({
    Key? key,
    required this.child,
  })  : padding = const SEdgeInsets.all2(),
        super(key: key);

  const SPadding.v10({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.symmetric(vertical: 10),
        super(key: key);

  const SPadding.trl8({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.only(top: 8, left: 8, right: 8),
        super(key: key);

  const SPadding.trl20({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.only(top: 20, left: 20, right: 20),
        super(key: key);

  const SPadding.brl8({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        super(key: key);

  const SPadding.trl16({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.only(top: 16, left: 16, right: 16),
        super(key: key);

  const SPadding.tr24({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.only(right: 4, top: 2),
        super(key: key);

  const SPadding.tl24({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.only(left: 4, top: 2),
        super(key: key);

  const SPadding.v4({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.symmetric(vertical: 4.0),
        super(key: key);

  const SPadding.v8({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.symmetric(vertical: 8.0),
        super(key: key);
  const SPadding.v14({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.symmetric(vertical: 14.0),
        super(key: key);
  const SPadding.v12({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.symmetric(vertical: 12.0),
        super(key: key);

  const SPadding.v10h25({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        super(key: key);

  const SPadding.h30v5({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        super(key: key);

  const SPadding.h15({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.symmetric(horizontal: 15),
        super(key: key);

  const SPadding.h5({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.symmetric(horizontal: 5),
        super(key: key);

  const SPadding.h8({
    Key? key,
    required this.child,
  })  : padding = const EdgeInsets.symmetric(horizontal: 8),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding is SEdgeInsets ? padding : padding,
      child: child,
    );
  }
}

/// [SEdgeInsets] extends form [EdgeInsets]  to make  EdgeInsets values
/// responsive using Flutter ScreenUtil
class SEdgeInsets extends EdgeInsets {
  const SEdgeInsets.fromLTRB(double left, double top, double right, double bottom)
      : super.fromLTRB(left, top, right, bottom);

  const SEdgeInsets.all(double value) : super.all(value);

  const SEdgeInsets.symmetric({
    double vertical = 0,
    double horizontal = 0,
  }) : super.symmetric(vertical: vertical, horizontal: horizontal);

  const SEdgeInsets.only({
    double bottom = 0,
    double right = 0,
    double left = 0,
    double top = 0,
  }) : super.only(
          bottom: bottom,
          right: right,
          left: left,
          top: top,
        );

  const SEdgeInsets.all64() : super.all(64);

  const SEdgeInsets.all32() : super.all(32);

  const SEdgeInsets.all16() : super.all(16);

  const SEdgeInsets.all12() : super.all(12);

  const SEdgeInsets.all8() : super.all(8);

  const SEdgeInsets.all4() : super.all(4);

  const SEdgeInsets.all2() : super.all(2);
}

extension SPaddingEx on Widget {
  /// Text("Nonstop").paddingAll(8),
  /// Text("IO").paddingAll(8),
  /// Text("Technologies Pvt Ltd").paddingAll(8),
  Widget sPaddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget sPaddingH(double horizontal) => Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontal),
        child: this,
      );

  Widget sPaddingV(double vertical) => Padding(
        padding: EdgeInsets.symmetric(vertical: vertical),
        child: this,
      );

  Widget sPaddingOnly({
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left ?? 0,
          right: right ?? 0,
          top: top ?? 0,
          bottom: bottom ?? 0,
        ),
        child: this,
      );

  Padding sPaddingLTRB(
    double left,
    double top,
    double right,
    double bottom, {
    Key? key,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: this,
      );
}

extension EdgeInsetsExtension on EdgeInsets {
  EdgeInsets get r => copyWith(
        top: top,
        bottom: bottom,
        right: right,
        left: left,
      );
}
