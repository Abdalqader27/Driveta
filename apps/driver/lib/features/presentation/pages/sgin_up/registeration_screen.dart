import 'package:bot_toast/bot_toast.dart';
import 'package:design/design.dart';
import 'package:driver/AllScreens/carInfoScreen.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/features/presentation/widgets/background/primary_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:driver/features/presentation/widgets/progress_dialog.dart';
import 'package:driver/main.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/config/theme/colors.dart';
import '../../../../../generated/assets.dart';
import '../sgin_in/login_screen.dart';

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
                  SPadding.all4(
                    child: Lottie.asset(
                      Assets.newUser,
                      width: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  const SText.headlineMedium(
                    " انشاء حساب  ",
                    style: TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                  const SText.bodyMedium(
                    "قم بانشاء حساب من فضلك",
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
                            labelText: "الاسم",
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
                            labelText: "الايميل",
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
                            labelText: "الهاتف",
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
                            labelText: "كلمة المرور",
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
                          borderRadius: BorderRadius.circular(30),
                          child: SText.titleMedium(
                            'انشاء حساب',
                            style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
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
                      "هل لديك حساب مسبق ؟ سجل من هنا!",
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
            message: "جاري التسجيل ....",
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
