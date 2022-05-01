import 'package:theme_provider/theme_provider.dart';

class ThemeProviderConfig {
  final List<AppTheme> themes;
  final AppTheme? defaultTheme;

  ThemeProviderConfig({
    required this.themes,
    required this.defaultTheme,
  }) : assert(themes.isNotEmpty);
}
