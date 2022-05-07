import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:rider/AllScreens/loginScreen.dart';
import 'package:rider/AllScreens/mainscreen.dart';
import 'package:rider/AllScreens/registerationScreen.dart';
import 'package:rider/DataHandler/appData.dart';

import '_injections.dart';
import 'libraries/el_theme/app_theme.dart';
import 'libraries/flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();

  runApp(MyApp());
}

DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
DatabaseReference rideRequestRef = FirebaseDatabase.instance.ref().child("Ride Requests");

class MyApp extends StatelessWidget {
  final botToastBuilder = BotToastInit(); //1. call BotToastInit

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: ScreenUtilInit(builder: () {
        return GetMaterialApp(
          title: 'Taxi Driver App',
          theme: kLightMod,
          locale: const Locale('ar'),
          builder: (context, child) {
            child = botToastBuilder(context, child);
            return child;
          },
          navigatorObservers: [BotToastNavigatorObserver()],
          initialRoute: FirebaseAuth.instance.currentUser == null ? LoginScreen.idScreen : MainScreen.idScreen,
          routes: {
            RegisterationScreen.idScreen: (context) => RegisterationScreen(),
            LoginScreen.idScreen: (context) => LoginScreen(),
            MainScreen.idScreen: (context) => MainScreen(),
          },
          debugShowCheckedModeBanner: false,
        );
      }),
    );
  }
}
