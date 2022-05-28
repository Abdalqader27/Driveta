import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../../common/config/theme/colors.dart';
import '../../../generated/assets.dart';
import '../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../../libraries/el_widgets/widgets/responsive_sized_box.dart';

class NoDriverAvailableDialog extends StatelessWidget {
  const NoDriverAvailableDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                RPadding.all4(
                  child: Lottie.asset(
                    Assets.lottieCarAnim,
                    width: 100.w,
                  ),
                ),
                const Text(
                  'غير متوفر حاليا',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'لم يتم العثور على سائق متوفر في الجوار ، نقترح عليك المحاولة مرة أخرى بعد قليل',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CupertinoButton(
                  onPressed: () => Navigator.pop(context),
                  child: Center(
                    child: Card(
                      color: kPRIMARY,
                      child: Center(
                        child: RPadding(
                          padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 10.r),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const RSizedBox.h16(),
                              Text("اغلاق", style: Theme.of(context).textTheme.button!.copyWith(color: kWhite)),
                            ],
                          ),
                        ),
                      ),
                    ),
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
