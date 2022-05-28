import 'package:flutter/material.dart';

class HeaderItem extends StatelessWidget {
  final bool loading;
  final BuildContext context;
  final String title;
  final String subtitle;
  final bool checkValue;

  const HeaderItem(
      {Key? key,
      required this.loading,
      required this.context,
      required this.title,
      required this.subtitle,
      required this.checkValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //   leading: const Icon(Icons.place),
      title: Visibility(
        visible: loading,
        child: const SizedBox(
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ),
        replacement: RichText(
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          maxLines: 2,
          text: TextSpan(
            text: '$title :',
            style: Theme.of(context).textTheme.bodyText1,
            children: [
              TextSpan(
                text: subtitle,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
      // trailing: GFCheckbox(
      //   size: GFSize.SMALL,
      //   activeBgColor: kPRIMARY,
      //   type: GFCheckboxType.circle,
      //   value: checkValue,
      //   onChanged: (value) => {},
      // )
    );
  }
}
