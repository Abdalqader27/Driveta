import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:rider/libraries/el_theme/styles/card_styles.dart';
import 'package:rider/libraries/el_theme/text_theme.dart';
import 'package:theme_provider/theme_provider.dart';

import 'colors.dart';

class ElAppTheme {
  ElAppTheme({
    this.primaryColor,
    this.accentColor,
    this.prefixIconColor,
    this.cardTheme = const CardTheme(),
    this.inputTheme = const InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
    ),
    this.buttonTheme = const ElevatedButtonThemeData(),
    this.titleStyle,
    this.bodyStyle,
    this.textFieldStyle,
  });

  /// The background color of major parts of the widget like the login screen
  /// and buttons
  final Color? primaryColor;

  /// The secondary color, used for title text color, loading icon, etc. Should
  /// be contrast with the [primaryColor]
  final Color? accentColor;

  /// color the prefix icon in [TextField] input
  final Color? prefixIconColor;

  /// The colors and styles used to render auth [Card]
  final CardTheme cardTheme;

  /// Defines the appearance of all [TextField]s
  final InputDecorationTheme inputTheme;

  /// A theme for customizing the shape, elevation, and color of the submit
  /// button
  final ElevatedButtonThemeData buttonTheme;

  /// Text style for the big title,The default style is [headline5]
  final TextStyle? titleStyle;

  /// Text style for small text like the recover password description, The default style is [subtitle1]
  final TextStyle? bodyStyle;

  /// Text style for [TextField] input text
  final TextStyle? textFieldStyle;
}

/// Light theme
final kLightMod = ThemeData(
  primaryColor: kPRIMARY,
  brightness: Brightness.light,
  backgroundColor: kWhite,
  scaffoldBackgroundColor: kWhite,
  textTheme: textTheme,
  fontFamily: 'sst-arabic',
  iconTheme: const IconThemeData(color: kPRIMARY),
  primaryIconTheme: const IconThemeData(color: kPRIMARY),
  cardTheme: kCardStyle1,
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: kPRIMARY,
        secondary: kSecondary,
      ),
);

/// Dark theme
final kDarkMod = ThemeData(
  primaryColor: kPRIMARY,
  fontFamily: 'sst-arabic',
  brightness: Brightness.dark,
  textTheme: textTheme,
  cardTheme: kCardStyle1,
  primaryIconTheme: const IconThemeData(color: kPRIMARY),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: kPRIMARY,
        secondary: kSecondary,
      ),
);

final appDarkTheme = AppTheme(id: 'dark_id', data: kDarkMod, description: 'dark mode');
final appLightTheme = AppTheme(id: 'light_id', data: kLightMod, description: 'dark mode');

final List<AppTheme> themes = [
  appDarkTheme,
  appLightTheme,
];
