import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rider/common/widgets/background/second_background.dart';
import 'package:rider/common/widgets/background/welcome_background.dart';
import 'package:rider/features/presentation/manager/bloc.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:rider/main.dart';

import '../../../../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../manager/container.dart';
import '../../manager/event.dart';
import '../../widgets/progressDialog.dart';
import '../../../../common/config/theme/colors.dart';
import '../../../../common/widgets/background/primary_background.dart';
import '../../../../generated/assets.dart';
import '../../../../mainscreen.dart';
import '../sgin_up/registeration_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String idScreen = "login";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SecondBackground(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Center(
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
                    LoginContainer(builder: (context, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const MaterialText.headLine6(
                            "تطبيق المستخدم",
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
                                  controller: email,
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
                                  controller: password,
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
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      context.read<RiderBloc>().add(
                                            LoginEvent(
                                              context,
                                              email: email.text,
                                              password: password.text,
                                              deviceToken: await FirebaseMessaging.instance.getToken() ?? '',
                                              rememberMe: true,
                                            ),
                                          );
                                      loginAndAuthenticateUser(context);
                                    }

                                    // if (!emailTextEditingController.text.contains("@")) {
                                    //   displayToastMessage("الايميل ليس صحيحا.", context);
                                    // } else if (passwordTextEditingController.text.isEmpty) {
                                    //   displayToastMessage("كلمة المرور الزامية.", context);
                                    // } else {
                                    //   loginAndAuthenticateUser(context);
                                    // }
                                  },
                                )),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, RegisterationScreen.idScreen, (route) => false);
                            },
                            child: const Text(
                              "ليس لديك حساب ؟ قم بتسجيل من هنا ",
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    final User? firebaseUser =
        (await _firebaseAuth.signInWithEmailAndPassword(email: 'abed@supy.io', password: '123456').catchError((errMsg) {
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
            .user;

    if (firebaseUser != null) {
      usersRef.child(firebaseUser.uid).once().then((s) {
        DataSnapshot snap = s.snapshot;
        if (snap.value != null) {
        } else {
          _firebaseAuth.signOut();
          displayToastMessage(" لايوجد حساب ، يرجى انشاء حساب جديد", context);
        }
      });
    } else {
      displayToastMessage("حدث خطآ ما ", context);
    }
  }
}