import 'package:driver/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/config/theme/colors.dart';
import '../../../../../../libraries/el_widgets/widgets/material_text.dart';

class MapDrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final GestureTapCallback? onTap;
  final Widget? leadingText;

  const MapDrawerItem({Key? key, required this.icon, required this.title, this.onTap, this.leadingText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: kPRIMARY,
      ),
      title: MaterialText.subTitle2(
        title,
        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 13.sp),
      ),
      onTap: onTap,
      trailing: leadingText,
    );
  }
}
