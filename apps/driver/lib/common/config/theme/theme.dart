import 'package:flutter/material.dart';

import '../styles/card_styles.dart';
import 'colors.dart';
import 'text_theme.dart';

/// Light theme
final kLightMod = ThemeData(
  primaryColor: kPRIMARY,
  brightness: Brightness.light,
  backgroundColor: kWhite,
  useMaterial3: true,
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
