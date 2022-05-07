import 'package:flutter/material.dart';

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
