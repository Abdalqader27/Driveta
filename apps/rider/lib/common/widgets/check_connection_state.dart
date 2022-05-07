import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';
import '../../libraries/el_theme/colors.dart';
import '../../libraries/el_widgets/widgets/material_text.dart';
import '../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../libraries/el_widgets/widgets/responsive_sized_box.dart';

class ConnectStateWidget extends StatelessWidget {
  final bool? isConnected;

  const ConnectStateWidget({Key? key, this.isConnected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: !isConnected! ? Tween(begin: 0.0, end: 1.0) : Tween(begin: 1.0, end: 0.0),
      duration: const Duration(milliseconds: 300),
      builder: (_, animation, __) => Visibility(
        visible: animation > 0,
        child: ClipRect(
          child: Align(
            heightFactor: max(animation, 0.0),
            child: Column(
              children: [
                const RSizedBox.v4(),
                RPadding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 5.5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.iconsDisconnected,
                        width: 20.0.r,
                        height: 20.0.r,
                        color: kPRIMARY,
                      ),
                      SizedBox(
                        width: 10.0.w,
                      ),
                      MaterialText.bodyText2(
                        'انت غير متصل بالإنترنت',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: kPRIMARY, fontWeight: FontWeight.w600, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
