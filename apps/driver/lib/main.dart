import 'dart:async';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:design/design.dart';
import 'package:driver/AllScreens/carInfoScreen.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/features/history/presentation/manager/history/bloc.dart';
import 'package:driver/features/map_driver/presentation/pages/map_driver/map_driver.dart';
import 'package:driver/features/map_driver/presentation/pages/map_driver/provider/panel_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:driver/features/auth/presentation/pages/sgin_in/login_screen.dart';
import 'package:driver/features/auth/presentation/pages/sgin_up/registeration_screen.dart';
import 'package:driver/DataHandler/appData.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'app_injection.dart';
import 'common/config/theme/theme.dart';
import 'features/auth/presentation/manager/auth/bloc.dart';
import 'features/profile/presentation/manager/profile/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Injections.init();

  currentfirebaseUser = FirebaseAuth.instance.currentUser;

  await runZonedGuarded(() async {
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => si<AuthBloc>()),
        BlocProvider(create: (_) => si<ProfileBloc>()),
        BlocProvider(create: (_) => si<HistoryBloc>()),
      ],
      child: const MyApp(),
    ));
  }, (exception, stackTrace) async {
    log(exception.toString(), stackTrace: stackTrace);
  });
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

    return GetMaterialApp(
      title: 'Taxi Driver App',
      theme: kLightMod,
      locale: const Locale('ar'),
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: si<SStorage>().get(key: kAccessToken, type: ValueType.string).toString().isEmpty
          ? LoginScreen.idScreen
          : MapDriverScreen.idScreen,
      routes: {
        RegisterationScreen.idScreen: (context) => RegisterationScreen(),
        LoginScreen.idScreen: (context) => const LoginScreen(),
        MapDriverScreen.idScreen: (context) => const MapDriverScreen(),
        CarInfoScreen.idScreen: (context) => const CarInfoScreen(),
      },
      builder: (context, navigator) {
        navigator = ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, navigator!),
          mediaQueryData: context.mq,
          debugLog: true,
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        );
        navigator = botToastBuilder(context, navigator);
        return navigator;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
