import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:design/design.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/features/presentation/pages/sgin_up/widgets/selected_image.dart';
import 'package:driver/features/presentation/widgets/background/primary_background.dart';
import 'package:driver/features/presentation/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:search_choices/search_choices.dart';

import '../../../../../common/config/theme/colors.dart';
import '../../../../../generated/assets.dart';
import '../../manager/bloc.dart';
import '../../manager/container.dart';
import '../../manager/event.dart';
import '../../widgets/src/material_text.dart';
import '../sgin_in/login_screen.dart';

class RegisterationScreen extends StatefulWidget {
  static const String idScreen = "register";

  RegisterationScreen({Key? key}) : super(key: key);

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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController userNameTextEditingController =
      TextEditingController();
  final TextEditingController dob = TextEditingController();
  var bloodSelected;
  var selectedGender = sex.boy;
  late bool _passwordVisible;
  List<XFile> imageList = [];

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
                    SPadding.all4(
                      child: Lottie.asset(
                        Assets.lottieNewUser,
                        width: 200,
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
                                const SizedBox(
                                  height: 1.0,
                                ),
                                TextFormField(
                                  controller: nameTextEditingController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
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
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: userNameTextEditingController,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\s')),
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
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
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: emailTextEditingController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
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
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: phoneTextEditingController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
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
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: dob,
                                  onTap: () async {
                                    final datePick = await showDatePicker(
                                        // locale: const Locale('ar'),
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1990),
                                        lastDate: DateTime.now());

                                    if (datePick != null) {
                                      setState(() {
                                        dob.text = DateFormat('yyyy-MM-dd')
                                            .format(datePick);
                                        // "${datePick.month}/${datePick.day}/${datePick.year}";
                                        // put it here
                                      });
                                    }
                                    //
                                  },
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    labelText: "تاريخ الميلاد",
                                    icon: Icon(Icons.calendar_today),
                                    labelStyle: TextStyle(fontSize: 14.0),
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10.0),
                                  ),
                                  readOnly: true,
                                  style: const TextStyle(fontSize: 14.0),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "الرجاء ادخال تاريخ الميلاد";
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: passwordTextEditingController,
                                  obscureText: !_passwordVisible,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
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
                                const SizedBox(height: 20),
                                ListTile(
                                  title: Text('الجنس'),
                                  subtitle: Row(
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
                                ),
                                ListTile(
                                  title: Text('المستندات'),
                                  subtitle: Column(
                                    children: [
                                      SelectedImage(
                                        builder: (context, value, child) {
                                          imageList = value;
                                          return child!;
                                        },
                                      ),
                                    ],
                                  ),
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
                                  borderRadius: BorderRadius.circular(30),
                                  child: MaterialText.button(
                                    'انشاء حساب',
                                    style: Theme.of(context)
                                        .textTheme
                                        .button!
                                        .copyWith(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      if (bloodSelected == null) {
                                        BotToast.showText(
                                            text: 'الرجاء اختيار الزمرة الدم');
                                      } else {
                                        if (imageList.length != 3) {
                                          BotToast.showText(
                                              text: 'الرجاء إضافة المستندات ');
                                        } else {
                                          context.read<DriverBloc>().add(
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
                                                  name:
                                                      nameTextEditingController
                                                          .text,
                                                  userName:
                                                      userNameTextEditingController
                                                          .text,
                                                  sexType: selectedGender.index,
                                                  dob: dob.text,
                                                  idPhotoFile: imageList[0],
                                                  personalImageFile:
                                                      imageList[1],
                                                  drivingCertificateFile:
                                                      imageList[2],
                                                  bloodType: int.parse(
                                                      bloodSelected['id']),
                                                ),
                                              );
                                        }
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

      // driversRef.child(firebaseUser.uid).set(userDataMap);

      currentfirebaseUser = firebaseUser;

      displayToastMessage(
          "Congratulations, your account has been created.", context);
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
