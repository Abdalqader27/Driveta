// Created By Abd Alqader Alnajjar
// 2021 / 11 / 19
import 'package:flutter/material.dart';

const kEasyLocalizationConfig = EasyLocalizationConfig(
  fallbackLocale: Locale('en'),
  startLocale: Locale('en'),
  supportedLocales: [Locale('en'), Locale('ar')],
  translationsPath: 'res/translation',
);

class EasyLocalizationConfig {
  /// App Locales
  final List<Locale> supportedLocales;

  /// This locale will be used when one of locale translate is missing
  final Locale fallbackLocale;

  /// This locale will be used when one of locale translate is missing
  final Locale startLocale;

  /// Translations files path (json files)
  final String translationsPath;

  const EasyLocalizationConfig({
    required this.supportedLocales,
    required this.fallbackLocale,
    required this.startLocale,
    required this.translationsPath,
  });
}
