// Created By Abd Alqader Alnajjar
// // 2021 / 11 / 19
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'easy_localization_config.dart';

class EasyLocalizationInitializer extends EasyLocalization {
  ///[EasyLocalizationInitializer] using [EasyLocalization] package.
  ///For more info visit https://pub.dev/packages/easy_localization.
  EasyLocalizationInitializer({
    Key? key,
    required Widget app,
    required EasyLocalizationConfig config,
  }) : super(
          key: key,
          child: app,
          startLocale: config.startLocale,
          path: config.translationsPath,
          supportedLocales: config.supportedLocales,
          fallbackLocale: config.fallbackLocale,
        );
}
