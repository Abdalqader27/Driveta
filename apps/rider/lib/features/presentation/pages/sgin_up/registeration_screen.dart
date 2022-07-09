import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/features/presentation/pages/map/main_screen/mainscreen.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../common/config/theme/colors.dart';
import '../../../../../../../../generated/assets.dart';
import '../../../../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../../../common/widgets/background/primary_background.dart';
import '../../widgets/progressDialog.dart';
import '../sgin_in/loginScreen.dart';

class RegisterationScreen extends StatefulWidget {
  static const String idScreen = "register";

  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

enum sex { boy, girl }

class _RegisterationScreenState extends State<RegisterationScreen> {
  final TextEditingController nameTextEditingController =
      TextEditingController();

  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController phoneTextEditingController =
      TextEditingController();

  final TextEditingController passwordTextEditingController =
      TextEditingController();

  var selectedGender = sex.boy;

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
                  if (selectedGender == sex.girl)
                    RPadding.all4(
                      child: Lottie.asset(
                        Assets.girl,
                        width: 200.w,
                      ),
                    )
                  else
                    RPadding.all4(
                      child: Lottie.asset(
                        Assets.boy,
                        width: 200.w,
                      ),
                    ),
                  const SizedBox(
                    height: 1.0,
                  ),
                  const MaterialText.headLine6(
                    " انشاء حساب  ",
                    style: TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),
                  const MaterialText.bodyText2(
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
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0),
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
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0),
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
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0),
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
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0),
                          ),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: RadioListTile(
                                value: selectedGender == sex.boy,
                                groupValue: true,
                                selected: selectedGender == sex.boy,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = sex.boy;
                                  });
                                },
                                title: const Text("ذكر"),
                              ),
                            ),
                            Expanded(
                                child: RadioListTile(
                              value: selectedGender == sex.girl,
                              selected: selectedGender == sex.girl,
                              groupValue: true,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = sex.girl;
                                });
                              },
                              title: const Text("مؤنث"),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Center(
                            child: CupertinoButton(
                          color: kPRIMARY,
                          borderRadius: BorderRadius.circular(30.r),
                          child: MaterialText.button(
                            'انشاء حساب',
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: kWhite),
                          ),
                          onPressed: () {
                            if (nameTextEditingController.text.length < 3) {
                              displayToastMessage(
                                  "name must be atleast 3 Characters.",
                                  context);
                            } else if (!emailTextEditingController.text
                                .contains("@")) {
                              displayToastMessage(
                                  "Email address is not Valid.", context);
                            } else if (phoneTextEditingController
                                .text.isEmpty) {
                              displayToastMessage(
                                  "Phone Number is mandatory.", context);
                            } else if (passwordTextEditingController
                                    .text.length <
                                6) {
                              displayToastMessage(
                                  "Password must be atleast 6 Characters.",
                                  context);
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
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.idScreen, (route) => false);
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
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
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

      displayToastMessage(
          "Congratulations, your account has been created.", context);

      Navigator.pushNamed(context, MainScreen.idScreen);
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
