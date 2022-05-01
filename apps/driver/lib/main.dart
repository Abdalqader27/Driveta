import 'package:bot_toast/bot_toast.dart';
import 'package:driver/AllScreens/carInfoScreen.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/features/map_driver/presentation/pages/map_driver/map_driver.dart';
import 'package:driver/features/map_driver/presentation/pages/map_driver/provider/panel_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:driver/features/auth/presentation/pages/sgin_in/login_screen.dart';
import 'package:driver/features/auth/presentation/pages/sgin_up/registeration_screen.dart';
import 'package:driver/DataHandler/appData.dart';

import 'common/config/theme/theme.dart';
import 'libraries/flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  currentfirebaseUser = FirebaseAuth.instance.currentUser;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PanelProvider()),
      ChangeNotifierProvider(create: (context) => AppData())
    ],
    child: const MyApp(),
  ));
}

DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
DatabaseReference newRequestsRef = FirebaseDatabase.instance.ref().child("Ride Requests");
DatabaseReference? rideRequestRef =
    FirebaseDatabase.instance.ref().child("drivers").child(currentfirebaseUser!.uid).child("newRide");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit(); //1. call BotToastInit

    return ScreenUtilInit(builder: () {
      return GetMaterialApp(
        title: 'Taxi Driver App',
        theme: kLightMod,
        locale: const Locale('ar'),
        builder: (context, child) {
          child = botToastBuilder(context, child);
          return child;
        },
        navigatorObservers: [BotToastNavigatorObserver()],
        initialRoute: FirebaseAuth.instance.currentUser == null ? LoginScreen.idScreen : MapDriverScreen.idScreen,
        routes: {
          RegisterationScreen.idScreen: (context) => RegisterationScreen(),
          LoginScreen.idScreen: (context) => const LoginScreen(),
          MapDriverScreen.idScreen: (context) => const MapDriverScreen(),
          CarInfoScreen.idScreen: (context) => CarInfoScreen(),
        },
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
