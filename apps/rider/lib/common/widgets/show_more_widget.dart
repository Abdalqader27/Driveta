import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../libraries/el_widgets/widgets/material_text.dart';
import '../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../config/theme/colors.dart';

class ShowMoreWidget extends StatelessWidget {
  final String title;
  final String buttonText;
  final Function() onPressed;

  const ShowMoreWidget({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RPadding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialText.button(title),
            CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                borderRadius: BorderRadius.circular(30),
                color: kPRIMARY.withOpacity(.1),
                child: MaterialText.button(
                  buttonText,
                  style: Theme.of(context).textTheme.button!.copyWith(color: kPRIMARY),
                ),
                onPressed: onPressed)
          ],
        ));
  }
}
