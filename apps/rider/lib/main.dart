import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:rider/features/data/database/app_db.dart';
import 'package:rider/features/presentation/manager/bloc.dart';
import 'package:rider/features/presentation/pages/map/main_screen/mainscreen.dart';
import 'package:rider/features/presentation/pages/sgin_in/loginScreen.dart';
import 'package:rider/features/presentation/pages/sgin_up/registeration_screen.dart';

import '_injections.dart';
import 'common/config/theme/theme.dart';
import 'common/utils/signal_r.dart';
import 'features/presentation/pages/map/map_trip_product/provider/map_trip_provider.dart';
import 'libraries/flutter_screenutil/flutter_screenutil.dart';

final si = GetIt.instance;
final appDatabase = AppDatabase();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();

  await SignalRRider().openConnection();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final botToastBuilder = BotToastInit();

  MyApp({Key? key}) : super(key: key); //1. call BotToastInit

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => si<RiderBloc>(),
      child: ChangeNotifierProvider(
        create: (BuildContext context) => si<MapTripProvider>(),
        child: ScreenUtilInit(builder: () {
          return GetMaterialApp(
            title: 'Taxi rider App',
            theme: kLightMod,
            locale: const Locale('ar'),
            builder: (context, child) {
              child = botToastBuilder(context, child);
              return child;
            },
            navigatorObservers: [BotToastNavigatorObserver()],
            initialRoute:
                si<SStorage>().get(key: kAccessToken, type: ValueType.string) ==
                            null ||
                        si<SStorage>()
                            .get(key: kAccessToken, type: ValueType.string)
                            .toString()
                            .isEmpty
                    ? LoginScreen.idScreen
                    : MainScreen.idScreen,
            routes: {
              RegisterationScreen.idScreen: (context) =>
                  const RegisterationScreen(),
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
