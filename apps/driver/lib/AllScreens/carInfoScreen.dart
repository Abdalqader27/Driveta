import 'package:driver/AllScreens/registeration_screen.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/features/map_driver/presentation/pages/map_driver/map_driver.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';

class CarInfoScreen extends StatefulWidget {
  static const String idScreen = "carinfo";

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
              SizedBox(
                height: 22.0,
              ),
              Image.asset(
                "images/logo.png",
                width: 390.0,
                height: 250.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 32.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Enter Car Details",
                      style: TextStyle(fontFamily: "Brand Bold", fontSize: 24.0),
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    TextField(
                      controller: carModelTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Model",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: carNumberTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Number",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: carColorTextEditingController,
                      decoration: InputDecoration(
                        labelText: "Car Color",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                      ),
                      style: TextStyle(fontSize: 15.0),
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    DropdownButton(
                      iconSize: 40,
                      hint: Text('Please choose Car Type'),
                      value: selectedCarType,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCarType = newValue as String;
                          displayToastMessage(selectedCarType, context);
                        });
                      },
                      items: carTypesList.map((car) {
                        return DropdownMenuItem(
                          child: new Text(car),
                          value: car,
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 42.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          if (carModelTextEditingController.text.isEmpty) {
                            displayToastMessage("please write Car Model.", context);
                          } else if (carNumberTextEditingController.text.isEmpty) {
                            displayToastMessage("please write Car Number.", context);
                          } else if (carColorTextEditingController.text.isEmpty) {
                            displayToastMessage("please write Car Color.", context);
                          } else if (selectedCarType == null) {
                            displayToastMessage("please choose Car Type.", context);
                          } else {
                            saveDriverCarInfo(context);
                          }
                        },
                        color: Colors.black54,
                        child: Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "NEXT",
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 26.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
