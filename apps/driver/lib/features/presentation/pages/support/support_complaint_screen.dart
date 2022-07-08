import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:design/design.dart';
import 'package:driver/features/presentation/manager/event.dart';
import 'package:driver/features/presentation/widgets/src/material_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/config/theme/colors.dart';
import '../../widgets/round_app_bar.dart';
import '../../../../generated/assets.dart';
import '../../manager/bloc.dart';
import '../../manager/container.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  _StateSupportScreen createState() => _StateSupportScreen();
}

class _StateSupportScreen extends State<SupportScreen> {
  bool sendingReportBool = false;
  final TextEditingController _reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            const RoundedAppBar(
                title: 'المساعدة والدعم',
                subTitle: 'اذا كنت تعاني من اي مشكلة '
                    'دعنا '),
            Expanded(
              child: SupportContainer(builder: (context, _) {
                _reportController.clear();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: SvgPicture.asset(
                        Assets.iconsGroup5,
                        width: 200,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'سعيدون للتواصل معك',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0, left: 30.0),
                      child: TextField(
                        controller: _reportController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: kPRIMARY, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        maxLines: null,
                      ),
                    ),
                    const SSizedBox.v16(),
                    Center(
                        child: CupertinoButton(
                      color: kPRIMARY,
                      borderRadius: BorderRadius.circular(30),
                      child: MaterialText.button(
                        'ارسال',
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_reportController.text.isNotEmpty) {
                          context
                              .read<DriverBloc>()
                              .add(PostSupportEvent(_reportController.text));
                        } else {
                          BotToast.showText(text: 'الحقل فارغ');
                        }
                      },
                    )),
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
