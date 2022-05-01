import 'package:driver/common/config/theme/colors.dart';
import 'package:flutter/material.dart';

class ElAppTheme {
  ElAppTheme({
    this.primaryColor,
    this.accentColor,
    this.prefixIconColor = kPRIMARY,
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
