import 'color_scheme.dart';
import 'package:design/design.dart';

final _buttonTheme = ButtonThemeData(
  height: 44.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(14.0),
  ),
  buttonColor: kPrimaryColor,
  textTheme: ButtonTextTheme.primary,
  colorScheme: kColorSchemeLight,
);
ButtonThemeData get kButtonTheme => _buttonTheme;
