import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:design/design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/features/presentation/manager/bloc.dart';

import '../../../../common/config/theme/colors.dart';
import '../../../../common/widgets/round_app_bar.dart';
import '../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../manager/container.dart';
import '../../manager/event.dart';

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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const RoundedAppBar(
                  title: 'المساعدة والدعم',
                  subTitle: 'اذا كنت تعاني من اي مشكلة '
                      'دعنا '),
              SupportContainer(builder: (context, _) {
                _reportController.clear();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Lottie.asset(
                          'lotti_files/16766-forget-password-animation.json',
                          height: 300),
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
                              .read<RiderBloc>()
                              .add(PostSupportEvent(_reportController.text));
                        } else {
                          BotToast.showText(text: 'الحقل فارغ');
                        }
                      },
                    )),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
