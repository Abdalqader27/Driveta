import 'package:design/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../libraries/el_widgets/widgets/material_text.dart';
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
    return SPadding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialText.button(title),
            CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                borderRadius: BorderRadius.circular(30),
                color: kPRIMARY.withOpacity(.1),
                onPressed: onPressed,
                child: MaterialText.button(
                  buttonText,
                  style: Theme.of(context).textTheme.button!.copyWith(color: kPRIMARY),
                ))
          ],
        ));
  }
}
