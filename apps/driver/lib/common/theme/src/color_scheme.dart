import 'package:design/design.dart';

const _colorSchemeLight = ColorScheme.light(
  primary: kPrimaryColor,
  secondary: kPrimaryColor,
  onSecondary: kWhite,
  onPrimary: kBlack,
);
const _colorSchemeDark = ColorScheme.dark(
  primary: kPrimaryColor,
  secondary: kPrimaryColor,
  onSecondary: kWhite,
  onPrimary: kBlack,
);

ColorScheme get kColorSchemeLight => _colorSchemeLight;

ColorScheme get kColorSchemeDark => _colorSchemeDark;
