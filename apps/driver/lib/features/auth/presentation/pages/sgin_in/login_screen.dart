import 'package:driver/features/map_driver/presentation/pages/map_driver/map_driver.dart';
import 'package:driver/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver/features/auth/presentation/pages/sgin_up/registeration_screen.dart';
import 'package:driver/common/widgets/progress_dialog.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/main.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/config/theme/colors.dart';
import '../../../../../common/widgets/background/primary_background.dart';
import '../../../../../generated/assets.dart';
import '../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../../libraries/el_widgets/widgets/responsive_padding.dart';

class LoginScreen extends StatefulWidget {
  static const String idScreen = "login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PrimaryBackground(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 35.0,
                  ),
                  RPadding.all4(
                    child: Lottie.asset(
                      Assets.lottieCarAnim,
                      width: 200.w,
                    ),
                  ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  const MaterialText.headLine6(
                    "تطبيق السائق",
                    style: TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                  const MaterialText.bodyText2(
                    "قم بتسجيل الدخول من فضلك",
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 1.0,
                        ),
                        TextField(
                          controller: emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "الايميل",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(
                          height: 1.0,
                        ),
                        TextField(
                          controller: passwordTextEditingController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "كلمة المرور ",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(
                          height: 60.0,
                        ),
                        Center(
                            child: CupertinoButton(
                          color: kPRIMARY,
                          borderRadius: BorderRadius.circular(30.r),
                          child: MaterialText.button(
                            'تسجيل الدخول',
                            style: Theme.of(context).textTheme.button!.copyWith(color: kWhite),
                          ),
                          onPressed: () {
                            if (!emailTextEditingController.text.contains("@")) {
                              displayToastMessage("الايميل ليس صحيحا.", context);
                            } else if (passwordTextEditingController.text.isEmpty) {
                              displayToastMessage("كلمة المرور الزامية.", context);
                            } else {
                              loginAndAuthenticateUser(context);
                            }
                          },
                        )),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, RegisterationScreen.idScreen, (route) => false);
                    },
                    child: const Text(
                      "ليس لديك حساب ؟ قم بتسجيل من هنا ",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "جاري المزامنة ، يرجى الانتظار...",
          );
        });

    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text, password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      driversRef.child(firebaseUser.uid).once().then((s) {
        DataSnapshot snap = s.snapshot;
        if (snap.value != null) {
          currentfirebaseUser = firebaseUser;
          Navigator.pushNamedAndRemoveUntil(context, MapDriverScreen.idScreen, (route) => false);
          displayToastMessage("انت مسجل دخول الان", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage(" لايوجد حساب ، يرجى انشاء حساب جديد", context);
        }
      });
    } else {
      Navigator.pop(context);
      displayToastMessage("حدث خطآ ما ", context);
    }
  }
}
