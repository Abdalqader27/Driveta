// File created by
// Abd Alqader  Alnajjar
// on 19/11/2021
import 'package:design/design.dart';
import 'package:driver/common/theme/src/app_bar_theme.dart';
import 'package:driver/common/theme/src/bottom_navigation_bar_theme.dart';
import 'package:driver/common/theme/src/bottom_sheet_Theme.dart';
import 'package:driver/common/theme/src/button_theme.dart';
import 'package:driver/common/theme/src/color_scheme.dart';
import 'package:driver/common/theme/src/elevated_button_theme.dart';
import 'package:driver/common/theme/src/input_Decoration_Theme.dart';
import 'package:driver/common/theme/src/text_theme.dart';
import 'package:flutter/foundation.dart';

final kEnTheme = ThemeData(
  bottomSheetTheme: kBottomSheetTheme,
  colorScheme: kColorSchemeLight,
  //colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
  appBarTheme: kAppBarTheme,
  scaffoldBackgroundColor: kBackground,
  textTheme: kTextTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: kPrimaryColor,
  brightness: Brightness.light,
  useMaterial3: true,
  // colorSchemeSeed: kPrimaryColor,
  backgroundColor: kWhite,
  fontFamily: 'sst-arabic',
  elevatedButtonTheme: kElevatedButtonTheme,
  buttonTheme: kButtonTheme,
  bottomNavigationBarTheme: kBottomNavigationBarThemeData,
  inputDecorationTheme: kInputDecorationTheme,
  iconTheme: const IconThemeData(color: kPrimaryColor),
  primaryIconTheme: const IconThemeData(color: kPrimaryColor),
  primaryTextTheme: Typography.material2014(
    platform: defaultTargetPlatform,
  ).black.apply(bodyColor: kPrimaryColor),
);
