import 'package:design/design.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/config/theme/colors.dart';

class MapDrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final GestureTapCallback? onTap;
  final Widget? leadingText;
  final Color? color;
  final Color? textColor;

  const MapDrawerItem(
      {Key? key, required this.icon, required this.title, this.onTap, this.leadingText, this.color, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? kPRIMARY,
      ),
      title: SText.bodyMedium(
        title,
        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 13, color: textColor),
      ),
      onTap: onTap,
      trailing: leadingText,
    );
  }
}
