import 'package:core/core.dart';
import 'package:design/design.dart';
import 'package:driver/features/presentation/manager/bloc.dart';
import 'package:driver/features/presentation/widgets/background/primary_background.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/config/theme/colors.dart';
import '../../../../../generated/assets.dart';
import '../../manager/container.dart';
import '../../manager/event.dart';
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
    return PrimaryBackground(
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 35.0),
                  SPadding.all4(
                    child: Lottie.asset(
                      Assets.lottieCarAnim,
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 1.0),
                  LoginContainer(builder: (context, _) {
                    return Column(
                      children: [
                        const SText.titleLarge(
                          "تطبيق السائق",
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                        const SText.bodyMedium(
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
                              TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: "اسم المستخدم",
                                  labelStyle: TextStyle(fontSize: 14.0),
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'الحقل فارغ ';
                                  }
                                  return null;
                                },
                                style: const TextStyle(fontSize: 14.0),
                              ),
                              const SizedBox(
                                height: 1.0,
                              ),
                              TextFormField(
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
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'الحقل فارغ ';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 60.0,
                              ),
                              Center(
                                  child: CupertinoButton(
                                color: kPRIMARY,
                                borderRadius: BorderRadius.circular(30),
                                child: SText.titleMedium(
                                  'تسجيل الدخول',
                                  style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    context.read<DriverBloc>().add(
                                          LoginEvent(
                                            context,
                                            email: email.text,
                                            password: password.text,
                                            deviceToken: await FirebaseMessaging.instance.getToken() ?? '',
                                            rememberMe: true,
                                          ),
                                        );
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
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
