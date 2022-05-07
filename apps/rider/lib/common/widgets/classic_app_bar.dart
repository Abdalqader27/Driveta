import 'package:flutter/material.dart';

import '../../libraries/el_widgets/widgets/material_text.dart';
import '../../libraries/el_widgets/widgets/responsive_sized_box.dart';
import 'close_widget.dart';

class ClassicAppBar extends StatelessWidget {
  final String title;
  final String? subTitle;

  const ClassicAppBar({Key? key, required this.title, this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CloseWidget(icon: Icons.arrow_back_ios_sharp),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [MaterialText.headLine5(title), if (subTitle != null) MaterialText.subTitle1(subTitle ?? "")],
          ),
        ),
        const RSizedBox.h42(),

        // AppBackButton(),
      ],
    );
  }
}
