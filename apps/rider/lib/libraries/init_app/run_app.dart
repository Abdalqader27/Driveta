import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../configs_models.dart';
import 'initializers/easy_localization/easy_localization_initializer.dart';
import 'initializers/run_app/init_app.dart';

///* 1- device preview
/// 2- easy localization
/// 3- catcher
///  Config = > { moor inspector - color - logs  . .... . .}
final inj = GetIt.instance;

runApplication({
  required Widget app,
  AppConfig appConfig = const AppConfig(),
}) async {
  await InitApp.init(appConfig: appConfig);
  // Widget app =
  //     _devicePreview(builder: builder, enable: appConfig.enableDevicePreview);

  final easyLocalizationConfig = appConfig.easyLocalizationConfig;

  if (easyLocalizationConfig != null) {
    app = _easyLocalization(app: app, config: easyLocalizationConfig);
  }

  runApp(app);


}

// Widget _devicePreview(
//     {required Widget Function() builder, required bool enable}) {
//   return DevicePreview(
//     builder: (context) => builder(),
//     enabled: enable,
//   );
// }

Widget _easyLocalization({required Widget app, required EasyLocalizationConfig config}) {
  return EasyLocalizationInitializer(
    config: config,
    app: app,
  );
}

