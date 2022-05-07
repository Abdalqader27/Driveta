import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider/common/widgets/painter/header_cliper.dart';

import '../../generated/assets.dart';
import '../../libraries/el_theme/colors.dart';
import '../../libraries/el_widgets/widgets/material_text.dart';

class DrawerHeaderClipper extends StatelessWidget {
  const DrawerHeaderClipper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderClipper(),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              onTap: () {},
              title: MaterialText(
                'عبد القادر النجار',
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "2000 / 01/ 01 ",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.white),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              leading: SvgPicture.asset(Assets.iconsUser),
            ),
            color: kPRIMARY,
          ),
        ],
      ),
    );
  }
}
