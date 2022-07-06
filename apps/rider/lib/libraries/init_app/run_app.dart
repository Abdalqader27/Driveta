import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../configs_models.dart';
import 'initializers/easy_localization/easy_localization_initializer.dart';
import 'initializers/run_app/init_app.dart';

///* 1- device preview
/// 2- easy localization
/// 3- catcher
///  Config = > { moor inspector - color - logs  . .... . .}
final si = GetIt.instance;

runApplication({
  required Widget app,
  AppConfig appConfig = const AppConfig(),
}) async {
  await InitApp.init(appConfig: appConfig);
  final easyLocalizationConfig = appConfig.easyLocalizationConfig;

  if (easyLocalizationConfig != null) {
    app = _easyLocalization(app: app, config: easyLocalizationConfig);
  }

  runApp(app);
}

Widget _easyLocalization({required Widget app, required EasyLocalizationConfig config}) {
  return EasyLocalizationInitializer(
    config: config,
    app: app,
  );
}
