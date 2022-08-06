import 'package:design/design.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../common/config/theme/colors.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../../../../../libraries/el_widgets/widgets/responsive_sized_box.dart';

class TitleAppBar extends StatelessWidget {
  final String title;
  final String titleSpan;
  final String durationText;
  final String driverName;
  final String driverPhone;
  final Function()? onPhoneTap;

  const TitleAppBar(
      {Key? key,
      required this.title,
      required this.titleSpan,
      required this.durationText,
      required this.driverName,
      required this.driverPhone,
      this.onPhoneTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(),
            gradient: LinearGradient(
                colors: [
                  const Color(0xfffbfbfb),
                  const Color(0xfffbfbfb),
                  Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).primaryColor
                      : const Color(0xfffbfbfb),
                  Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).primaryColor.withOpacity(.0001)
                      : const Color(0xfffbfbfb).withOpacity(.2),
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                tileMode: TileMode.clamp)),
        child: RPadding.all12(
          child: Column(
            children: <Widget>[
              const RSizedBox.v32(),
              RichText(
                text: TextSpan(
                    text: title,
                    children: [
                      TextSpan(
                          text: titleSpan,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'sst-arabic',
                              color: kPRIMARY)),
                    ],
                    style: TextStyle(
                      color: Theme.of(context).brightness != Brightness.dark
                          ? Colors.black
                          : const Color(0xfffbfbfb),
                      fontSize: 20,
                      fontFamily: 'sst-arabic',
                      fontWeight: FontWeight.bold,
                    )),
                textAlign: TextAlign.center,
              ),
              const RSizedBox.v16(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    MaterialText.subTitle2(
                      "المدة المتوقعة للوصول خلال :",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              MaterialText.subTitle2(
                durationText,
                style: const TextStyle(
                    color: kBlack, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Divider(),
                  ),
                  ListTile(
                    leading: SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipOval(
                        child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: SvgPicture.asset(Assets.iconsUser)),
                      ),
                    ),
                    title: Text(
                      '$driverName',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.green)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const <Widget>[
                          Text(
                            'اتصال ',
                            style: TextStyle(color: Colors.green, fontSize: 13),
                          ),
                          Icon(
                            Icons.call,
                            color: Colors.green,
                            size: 17,
                          ),
                        ],
                      ),
                      onPressed: () {
                        launchUrlString(
                            'tel:00${driverPhone.replaceAll(' ', '')}');

                        if (onPhoneTap != null) {
                          onPhoneTap!();
                        }
                        // UrlLauncer.launch('tel:00${snapshot.data.captainNumber}');
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
