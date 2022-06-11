import 'package:design/design.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../common/config/theme/colors.dart';
import '../features/presentation/pages/map_driver/map_driver.dart';
import '../features/presentation/pages/sgin_up/registeration_screen.dart';
import '../generated/assets.dart';

class CarInfoScreen extends StatefulWidget {
  static const String idScreen = "carinfo";

  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  _CarInfoScreenState createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();

  TextEditingController carNumberTextEditingController = TextEditingController();

  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> carTypesList = ['uber-x', 'uber-go', 'bike'];

  String? selectedCarType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 35.0,
              ),
              SPadding.all4(
                child: Lottie.asset(
                  Assets.carInfo,
                  width: context.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 32.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text("ادخال تفاصيل سيارتك"),
                    const SizedBox(
                      height: 26.0,
                    ),
                    TextField(
                      controller: carModelTextEditingController,
                      decoration: const InputDecoration(
                        labelText: "موديل السيارة",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: carNumberTextEditingController,
                      decoration: const InputDecoration(
                        labelText: "رقم السيارة",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: carColorTextEditingController,
                      decoration: const InputDecoration(
                        labelText: "لون السيارة",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: const TextStyle(fontSize: 15.0),
                    ),
                    const SizedBox(
                      height: 26.0,
                    ),
                    DropdownButton(
                      iconSize: 40,
                      hint: const Text('الرجاء اختيار توع سيارتك'),
                      value: selectedCarType,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCarType = newValue as String;
                          displayToastMessage(selectedCarType, context);
                        });
                      },
                      items: carTypesList.map((car) {
                        return DropdownMenuItem(
                          child: Text(car),
                          value: car,
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 42.0,
                    ),
                    Center(
                        child: CupertinoButton(
                      color: kPRIMARY,
                      borderRadius: BorderRadius.circular(30),
                      child: Text(
                        'التالي',
                        style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
                      ),
                      onPressed: () {
                        if (carModelTextEditingController.text.isEmpty) {
                          displayToastMessage("الرجاء تحديد موديل السيارة.", context);
                        } else if (carNumberTextEditingController.text.isEmpty) {
                          displayToastMessage("الرجاء تحديد رقم السيارة.", context);
                        } else if (carColorTextEditingController.text.isEmpty) {
                          displayToastMessage("الرجاء تحديد لون السيازة.", context);
                        } else if (selectedCarType == null) {
                          displayToastMessage("الرجاء تحديد نوع السيارة.", context);
                        } else {
                          saveDriverCarInfo(context);
                        }
                      },
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveDriverCarInfo(context) {
    String userId = currentfirebaseUser!.uid;

    Map carInfoMap = {
      "car_color": carColorTextEditingController.text,
      "car_number": carNumberTextEditingController.text,
      "car_model": carModelTextEditingController.text,
      "type": selectedCarType,
    };

    driversRef.child(userId).child("car_details").set(carInfoMap);

    Navigator.pushNamedAndRemoveUntil(context, MapDriverScreen.idScreen, (route) => false);
  }
}
