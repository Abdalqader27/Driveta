import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:rider/features/presentation/manager/bloc.dart';
import 'package:rider/features/presentation/pages/sgin_in/loginScreen.dart';
import 'package:rider/mainscreen.dart';
import 'package:rider/features/presentation/pages/sgin_up/registeration_screen.dart';
import 'package:rider/DataHandler/appData.dart';

import '_injections.dart';
import 'libraries/el_theme/app_theme.dart';
import 'libraries/flutter_screenutil/flutter_screenutil.dart';
import 'libraries/init_app/run_app.dart';

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
  final botToastBuilder = BotToastInit();

  MyApp({Key? key}) : super(key: key); //1. call BotToastInit

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: BlocProvider(
        create: (context) => si<RiderBloc>(),
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
              RegisterationScreen.idScreen: (context) => const RegisterationScreen(),
              LoginScreen.idScreen: (context) => const LoginScreen(),
              MainScreen.idScreen: (context) => const MainScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        }),
      ),
    );
  }
}
