import 'package:design/design.dart';

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    onPrimary: kWhite,
    minimumSize: const Size.fromHeight(44.0),
    elevation: 0.0,
    textStyle: const TextStyle(fontSize: 15.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
  ),
);
ElevatedButtonThemeData get kElevatedButtonTheme => _elevatedButtonTheme;
