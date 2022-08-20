import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:lottie/lottie.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';
import 'package:search_choices/search_choices.dart';

import '../../../../../../../../common/config/theme/colors.dart';
import '../../../../../../../../generated/assets.dart';
import '../../../../../../../../libraries/el_widgets/widgets/material_text.dart';
import '../../../../../../../../libraries/el_widgets/widgets/responsive_padding.dart';
import '../../../../common/widgets/background/primary_background.dart';
import '../../manager/bloc.dart';
import '../../manager/container.dart';
import '../../manager/event.dart';
import '../sgin_in/loginScreen.dart';

class RegisterationScreen extends StatefulWidget {
  static const String idScreen = "register";

  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

enum sex { boy, girl }

class _RegisterationScreenState extends State<RegisterationScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController userNameTextEditingController =
      TextEditingController();

  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController phoneTextEditingController =
      TextEditingController();

  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController dob = TextEditingController();
  var bloodSelected;
  var selectedGender = sex.boy;
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryBackground(
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
                      height: 20.0,
                    ),
                    if (selectedGender == sex.girl)
                      RPadding.all4(
                        child: Lottie.asset(
                          Assets.girl,
                          width: 100.w,
                        ),
                      )
                    else
                      RPadding.all4(
                        child: Lottie.asset(
                          Assets.boy,
                          width: 100.w,
                        ),
                      ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    SignUpContainer(builder: (context, state) {
                      return Column(
                        children: [
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
                                Row(
                                  children: [
                                    Flexible(
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
                                    Flexible(
                                        child: RadioListTile(
                                      value: selectedGender == sex.girl,
                                      selected: selectedGender == sex.girl,
                                      groupValue: true,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGender = sex.girl;
                                        });
                                      },
                                      title: const Text("انثى"),
                                    )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 1.0,
                                ),
                                TextFormField(
                                  controller: nameTextEditingController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person_remove_alt_1),
                                    labelText: "الاسم الكامل",
                                    labelStyle: TextStyle(fontSize: 14.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10.0),
                                  ),
                                  style: const TextStyle(fontSize: 14.0),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "الرجاء ادخال الاسم الكامل";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: userNameTextEditingController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\s')),
                                  ],
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.account_circle),
                                    labelText: "اسم المستخدم",
                                    labelStyle: TextStyle(fontSize: 14.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10.0),
                                  ),
                                  style: const TextStyle(fontSize: 14.0),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "الرجاء ادخال الاسم";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 1.0),
                                TextFormField(
                                  controller: emailTextEditingController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.email_outlined),
                                    labelText: "الايميل",
                                    labelStyle: TextStyle(fontSize: 14.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10.0),
                                  ),
                                  style: const TextStyle(fontSize: 14.0),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "الرجاء ادخال الايميل";
                                    }
                                    if (!(value?.contains("@") ?? true)) {
                                      return "الرجاء ادخال الايميل بشكل صحيح";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 1.0),
                                TextFormField(
                                  controller: phoneTextEditingController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: "الهاتف",
                                    icon: Icon(Icons.mobile_friendly),
                                    labelStyle: TextStyle(fontSize: 14.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10.0),
                                  ),
                                  style: const TextStyle(fontSize: 14.0),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "الرجاء ادخال الهاتف";
                                    }
                                    if (value?.length != 10) {
                                      return "الرجاء ادخال الهاتف بشكل صحيح";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 1.0,
                                ),
                                TextFormField(
                                  controller: dob,
                                  onTap: () async {
                                    final datePick = await showDatePicker(
                                        locale: const Locale('ar'),
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1990),
                                        lastDate: DateTime.now());

                                    if (datePick != null) {
                                      setState(() {
                                        dob.text = DateFormat('yyyy-MM-dd').format(
                                            datePick); // "${datePick.month}/${datePick.day}/${datePick.year}";
                                        // put it here
                                      });
                                    }
                                    //
                                  },
                                  keyboardType: TextInputType.datetime,
                                  decoration: const InputDecoration(
                                    labelText: "تاريخ الميلاد",
                                    icon: Icon(Icons.calendar_today),
                                    labelStyle: TextStyle(fontSize: 14.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10.0),
                                  ),
                                  style: const TextStyle(fontSize: 14.0),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "الرجاء ادخال تاريخ الميلاد";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 1.0,
                                ),
                                TextFormField(
                                  controller: passwordTextEditingController,
                                  obscureText: !_passwordVisible,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    labelText: "كلمة المرور",
                                    labelStyle: const TextStyle(
                                      fontSize: 14.0,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    icon: const Icon(
                                      Icons.password_outlined,
                                    ),
                                    hintStyle: const TextStyle(
                                        color: Colors.grey, fontSize: 10.0),
                                  ),
                                  style: const TextStyle(fontSize: 14.0),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "الرجاء ادخال كلمة المرور";
                                    }
                                    if (value!.length < 6) {
                                      return "الرجاء ادخال كلمة المرور بشكل صحيح";
                                    }
                                    return null;
                                  },
                                ),
                                SearchChoices.single(
                                  items: blood
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Center(
                                              child: Text(
                                                e['name'],
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 14.0),
                                                textDirection:
                                                    TextDirection.ltr,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: bloodSelected,
                                  hint: "حدد الزمرة الدم",
                                  searchHint: null,
                                  onChanged: (value) {
                                    setState(() {
                                      bloodSelected = value;
                                    });
                                  },
                                  dialogBox: true,
                                  isExpanded: false,
                                  // menuConstraints: BoxConstraints.tight(
                                  //     const Size.fromHeight(350)),
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
                                    if (formKey.currentState!.validate()) {
                                      if (bloodSelected == null) {
                                        BotToast.showText(
                                            text: 'الرجاء اختيار الزمرة الدم');
                                      } else {
                                        context.read<RiderBloc>().add(
                                              SignUPEvent(
                                                context,
                                                email:
                                                    emailTextEditingController
                                                        .text,
                                                password:
                                                    passwordTextEditingController
                                                        .text,
                                                phoneNumber:
                                                    phoneTextEditingController
                                                        .text,
                                                name: nameTextEditingController
                                                    .text,
                                                userName:
                                                    userNameTextEditingController
                                                        .text,
                                                sexType: selectedGender.index,
                                                dob: dob.text,
                                                bloodType: int.parse(
                                                    bloodSelected['id']),
                                              ),
                                            );
                                      }
                                    }
                                  },
                                )),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  LoginScreen.idScreen, (route) => false);
                            },
                            child: const Text(
                              "هل لديك حساب مسبق ؟ سجل من هنا!",
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

  List<Map<String, dynamic>> blood = [
    {'id': '0', 'name': 'APositive', 'category': 'A+'},
    {'id': '1', 'name': 'ANegative', 'category': 'A-'},
    {'id': '2', 'name': 'BPositive', 'category': 'B+'},
    {'id': '3', 'name': 'BNegative', 'category': 'B-'},
    {'id': '4', 'name': 'ABPositive', 'category': 'AB+'},
    {'id': '5', 'name': 'ABNegative', 'category': 'AB-'},
    {'id': '6', 'name': 'OPositive', 'category': 'O+'},
    {'id': '7', 'name': 'ONegative', 'category': 'O-'},
  ];
}

displayToastMessage(String? message, BuildContext context) {
  BotToast.showText(text: message ?? '', duration: Duration(seconds: 10));
}
