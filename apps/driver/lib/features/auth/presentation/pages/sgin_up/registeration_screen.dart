import 'package:bot_toast/bot_toast.dart';
import 'package:driver/AllScreens/carInfoScreen.dart';
import 'package:driver/common/widgets/background/primary_background.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:driver/features/auth/presentation/pages/sgin_in/login_screen.dart';
import 'package:driver/common/widgets/progress_dialog.dart';
import 'package:driver/main.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/config/theme/colors.dart';
import '../../../../../generated/assets.dart';
import '../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../../libraries/el_widgets/widgets/responsive_padding.dart';

class RegisterationScreen extends StatelessWidget {
  static const String idScreen = "register";

  final TextEditingController nameTextEditingController = TextEditingController();
  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final TextEditingController passwordTextEditingController = TextEditingController();

  RegisterationScreen({Key? key}) : super(key: key);

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
                    height: 20.0,
                  ),
                  RPadding.all4(
                    child: Lottie.asset(
                      Assets.newUser,
                      width: 200.w,
                    ),
                  ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  const MaterialText.headLine6(
                    " ?????????? ????????  ",
                    style: TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                  const MaterialText.bodyText2(
                    "???? ???????????? ???????? ???? ????????",
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
                          controller: nameTextEditingController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: "??????????",
                            labelStyle: TextStyle(fontSize: 14.0),
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 1.0),
                        TextField(
                          controller: emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "??????????????",
                            labelStyle: TextStyle(fontSize: 14.0),
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 1.0),
                        TextField(
                          controller: phoneTextEditingController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "????????????",
                            labelStyle: TextStyle(fontSize: 14.0),
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
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
                            labelText: "???????? ????????????",
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Center(
                            child: CupertinoButton(
                          color: kPRIMARY,
                          borderRadius: BorderRadius.circular(30.r),
                          child: MaterialText.button(
                            '?????????? ????????',
                            style: Theme.of(context).textTheme.button!.copyWith(color: kWhite),
                          ),
                          onPressed: () {
                            if (nameTextEditingController.text.length < 3) {
                              displayToastMessage("name must be atleast 3 Characters.", context);
                            } else if (!emailTextEditingController.text.contains("@")) {
                              displayToastMessage("Email address is not Valid.", context);
                            } else if (phoneTextEditingController.text.isEmpty) {
                              displayToastMessage("Phone Number is mandatory.", context);
                            } else if (passwordTextEditingController.text.length < 6) {
                              displayToastMessage("Password must be atleast 6 Characters.", context);
                            } else {
                              registerNewUser(context);
                            }
                          },
                        )),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                    },
                    child: const Text(
                      "???? ???????? ???????? ???????? ?? ?????? ???? ??????!",
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

  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const ProgressDialog(
            message: "???????? ?????????????? ....",
          );
        });

    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text, password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) //user created
    {
      //save user info to database
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      driversRef.child(firebaseUser.uid).set(userDataMap);

      currentfirebaseUser = firebaseUser;

      displayToastMessage("Congratulations, your account has been created.", context);

      Navigator.pushNamed(context, CarInfoScreen.idScreen);
    } else {
      Navigator.pop(context);
      //error occurred - display error msg
      displayToastMessage("New user account has not been Created.", context);
    }
  }
}

displayToastMessage(String? message, BuildContext context) {
  BotToast.showText(text: message ?? '');
}
