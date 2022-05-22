import 'package:design/design.dart';
import 'package:driver/common/config/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../../../../../libraries/el_widgets/el_widgets.dart';

class ChipItem extends StatelessWidget {
  const ChipItem({Key? key, required this.title, required this.iconData}) : super(key: key);
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kGREY.withOpacity(.4),
      child: SPadding.all4(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SSizedBox.h4(),
          Icon(iconData),
          const SSizedBox.h4(),
          MaterialText.caption(
            title,
            style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold, color: kPRIMARY),
          ),
          const SSizedBox.h4(),
        ],
      )),
    );
  }
}
