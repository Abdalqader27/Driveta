import 'dart:math';

import 'package:design/design.dart';
import 'package:driver/common/config/theme/colors.dart';
import 'package:driver/generated/assets.dart';
import 'package:driver/libraries/el_widgets/el_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                const SSizedBox.v4(),
                SPadding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.iconsDisconnected,
                        width: 20.0,
                        height: 20.0,
                        color: kPRIMARY,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      MaterialText.bodyText2(
                        'انت غير متصل بالإنترنت',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: kPRIMARY, fontWeight: FontWeight.w600, fontSize: 14),
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
