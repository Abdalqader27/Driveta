import 'package:flutter/material.dart';

class HeaderItem extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String subtitle;

  const HeaderItem({Key? key, required this.context, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: RichText(
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
              text: '$title :',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600),
              children: [
                TextSpan(
                  text: subtitle,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
