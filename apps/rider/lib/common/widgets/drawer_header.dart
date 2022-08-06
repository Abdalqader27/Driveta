import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rider/common/config/theme/colors.dart';
import 'package:rider/common/widgets/painter/header_cliper.dart';

import '../../features/data/models/user.dart';
import '../../generated/assets.dart';
import '../../libraries/el_widgets/widgets/material_text.dart';

class DrawerHeaderClipper extends StatelessWidget {
  final User data;
  const DrawerHeaderClipper({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderClipper(),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            color: kPRIMARY,
            child: ListTile(
              title: MaterialText(
                '${data.name}',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white),
              ),
              // subtitle: Text(
              //   "رصيدك : ${data.balance}  ",
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context)
              //       .textTheme
              //       .caption!
              //       .copyWith(color: Colors.white),
              // ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              leading: SvgPicture.asset(Assets.iconsUser),
            ),
          ),
        ],
      ),
    );
  }
}
