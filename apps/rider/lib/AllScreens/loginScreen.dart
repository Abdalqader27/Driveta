import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/AllScreens/registerationScreen.dart';
import 'package:rider/common/widgets/background/second_background.dart';
import 'package:rider/common/widgets/background/welcome_background.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/main.dart';

import '../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../AllWidgets/progressDialog.dart';
import '../common/config/theme/colors.dart';
import '../common/widgets/background/primary_background.dart';
import '../generated/assets.dart';
import 'mainscreen.dart';

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
    return SecondBackground(
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
                      Assets.login,
                      width: 400.w,
                    ),
                  ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  const MaterialText.headLine6(
                    "?????????? ????????????????",
                    style: TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                  const MaterialText.bodyText2(
                    "???? ???????????? ???????????? ???? ????????",
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
                            labelText: "??????????????",
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
                            labelText: "???????? ???????????? ",
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
                            '?????????? ????????????',
                            style: Theme.of(context).textTheme.button!.copyWith(color: kWhite),
                          ),
                          onPressed: () {
                            if (!emailTextEditingController.text.contains("@")) {
                              displayToastMessage("?????????????? ?????? ??????????.", context);
                            } else if (passwordTextEditingController.text.isEmpty) {
                              displayToastMessage("???????? ???????????? ??????????????.", context);
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
                      "?????? ???????? ???????? ?? ???? ???????????? ???? ?????? ",
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
            message: "???????? ???????????????? ?? ???????? ????????????????...",
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
      usersRef.child(firebaseUser.uid).once().then((s) {
        DataSnapshot snap = s.snapshot;
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          displayToastMessage("?????? ???????? ???????? ????????", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage(" ???????????? ???????? ?? ???????? ?????????? ???????? ????????", context);
        }
      });
    } else {
      Navigator.pop(context);
      displayToastMessage("?????? ?????? ???? ", context);
    }
  }
}
