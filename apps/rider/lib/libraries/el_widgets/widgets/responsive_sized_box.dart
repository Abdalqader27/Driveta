import 'package:flutter/material.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

class RSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;

  const RSizedBox({Key? key, this.height, this.width, this.child}) : super(key: key);

  /// Vertical
  const RSizedBox.v2({Key? key})
      : height = 2,
        width = null,
        child = null,
        super(key: key);

  const RSizedBox.v4({Key? key})
      : height = 4,
        width = null,
        child = null,
        super(key: key);

  const RSizedBox.v8({Key? key})
      : height = 8,
        width = null,
        child = null,
        super(key: key);

  const RSizedBox.v12({Key? key})
      : height = 12,
        width = null,
        child = null,
        super(key: key);

  const RSizedBox.v16({Key? key})
      : height = 16,
        width = null,
        child = null,
        super(key: key);

  const RSizedBox.v24({Key? key})
      : height = 24,
        width = null,
        child = null,
        super(key: key);

  const RSizedBox.v32({Key? key})
      : height = 32,
        width = null,
        child = null,
        super(key: key);

  const RSizedBox.v42({Key? key})
      : height = 42,
        width = null,
        child = null,
        super(key: key);

  const RSizedBox.v64({Key? key})
      : height = 64,
        width = null,
        child = null,
        super(key: key);

  /// horizontal
  const RSizedBox.h2({Key? key})
      : width = 2,
        height = null,
        child = null,
        super(key: key);

  const RSizedBox.h4({Key? key})
      : width = 4,
        height = null,
        child = null,
        super(key: key);

  const RSizedBox.h8({Key? key})
      : width = 8,
        height = null,
        child = null,
        super(key: key);

  const RSizedBox.h12({Key? key})
      : width = 12,
        height = null,
        child = null,
        super(key: key);

  const RSizedBox.h16({Key? key})
      : width = 16,
        height = null,
        child = null,
        super(key: key);

  const RSizedBox.h24({Key? key})
      : width = 24,
        height = null,
        child = null,
        super(key: key);

  const RSizedBox.h32({Key? key})
      : width = 32,
        height = null,
        child = null,
        super(key: key);

  const RSizedBox.h42({Key? key})
      : width = 42,
        height = null,
        child = null,
        super(key: key);

  const RSizedBox.h64({Key? key})
      : width = 64,
        height = null,
        child = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
      child: child,
    );
  }
}
