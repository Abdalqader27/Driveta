import 'dart:async';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:design/design.dart';
import 'package:driver/configMaps.dart';
import 'package:driver/features/presentation/manager/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'app_injection.dart';
import 'common/config/theme/theme.dart';
import 'features/presentation/pages/map_driver/map_driver.dart';
import 'features/presentation/pages/sgin_in/login_screen.dart';
import 'features/presentation/pages/sgin_up/registeration_screen.dart';

void main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Injections.init();

  currentfirebaseUser = FirebaseAuth.instance.currentUser;

  await runZonedGuarded(() async {
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => si<DriverBloc>()),
      ],
      child: const MyApp(),
    ));
  }, (exception, stackTrace) async {
    log(exception.toString(), stackTrace: stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit(); //1. call BotToastInit

    return GetMaterialApp(
      title: 'Taxi Driver App',
      theme: kLightMod,
      locale: const Locale('ar'),
      navigatorObservers: [BotToastNavigatorObserver()],
      initialRoute: si<SStorage>()
              .get(key: kAccessToken, type: ValueType.string)
              .toString()
              .isEmpty
          ? LoginScreen.idScreen
          : MapDriverScreen.idScreen,
      routes: {
        RegisterationScreen.idScreen: (context) => RegisterationScreen(),
        LoginScreen.idScreen: (context) => const LoginScreen(),
        MapDriverScreen.idScreen: (context) => const MapDriverScreen(),
      },
      builder: (context, navigator) {
        navigator = ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, navigator!),
          mediaQueryData: context.mq,
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
