import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../configs_models.dart';
import '../../../flutter_screenutil/flutter_screenutil.dart';

///  Which is similar to [WidgetBuilder] but also takes an [ThemeData].
typedef WidgetThemeBuilder = Widget Function(BuildContext context, ThemeData theme);

class ThemeProviderInitializer extends StatelessWidget {
  ///This widget built over [ThemeProvider] and  FlutterScreenUtils
  /// to set app theme and build responsive text styles and other responsive widgets
  /// Refer to [_buildResponsiveTheme]
  const ThemeProviderInitializer({Key? key, required this.builder, required this.themeProviderConfig})
      : super(key: key);

  final WidgetThemeBuilder builder;

  final ThemeProviderConfig themeProviderConfig;

  @override
  Widget build(BuildContext context) {
    final themes = themeProviderConfig.themes;
    return ThemeProvider(
      saveThemesOnChange: true,
      onInitCallback: _onInit,
      themes: themes,
      child: Builder(
        builder: (context) {
          final theme = ThemeProvider.themeOf(context).data;
          final textTheme = theme.textTheme;
          return ThemeConsumer(
            child: builder(context, _buildResponsiveTheme(theme, textTheme)),
          );
        },
      ),
    );
  }

  /// Refactor [TextTheme] typography to be responsive
  ThemeData _buildResponsiveTheme(ThemeData theme, TextTheme textTheme) {
    return theme.copyWith(textTheme: _textTheme(textTheme));
  }

  TextTheme _textTheme(TextTheme textTheme) {
    final headline1 = textTheme.headline1;
    final headline2 = textTheme.headline2;
    final headline3 = textTheme.headline3;
    final headline4 = textTheme.headline4;
    final headline5 = textTheme.headline5;
    final headline6 = textTheme.headline6;
    final subtitle1 = textTheme.subtitle1;
    final subtitle2 = textTheme.subtitle2;
    final bodyText1 = textTheme.bodyText1;
    final bodyText2 = textTheme.bodyText2;
    final button = textTheme.button;
    final caption = textTheme.caption;
    final overline = textTheme.overline;
    return textTheme.copyWith(
      headline1: headline1?.copyWith(fontSize: headline1.fontSize?.sp),
      headline2: headline2?.copyWith(fontSize: headline2.fontSize?.sp),
      headline3: headline3?.copyWith(fontSize: headline3.fontSize?.sp),
      headline4: headline4?.copyWith(fontSize: headline4.fontSize?.sp),
      headline5: headline5?.copyWith(fontSize: headline5.fontSize?.sp),
      headline6: headline6?.copyWith(fontSize: headline6.fontSize?.sp),
      bodyText1: bodyText1?.copyWith(fontSize: bodyText1.fontSize?.sp),
      bodyText2: bodyText2?.copyWith(fontSize: bodyText2.fontSize?.sp),
      subtitle1: subtitle1?.copyWith(fontSize: subtitle1.fontSize?.sp),
      subtitle2: subtitle2?.copyWith(fontSize: subtitle2.fontSize?.sp),
      caption: caption?.copyWith(fontSize: caption.fontSize?.sp),
      button: button?.copyWith(fontSize: button.fontSize?.sp),
      overline: overline?.copyWith(fontSize: overline.fontSize?.sp),
    );
  }

  _onInit(ThemeController controller, Future<String?> previouslySavedThemeFuture) async {
    final savedTheme = await previouslySavedThemeFuture;
    if (savedTheme != null) {
      // If previous theme saved, use saved theme
      controller.setTheme(savedTheme);
    } else {
      final defaultTheme = themeProviderConfig.defaultTheme;

      if (defaultTheme != null) {
        controller.setTheme(defaultTheme.id);
      } else {
        Brightness? platformBrightness = SchedulerBinding.instance.window.platformBrightness;
        controller.setTheme(_getBrightnessTheme(platformBrightness));
      }
      // Forget the saved theme(which were saved just now by previous lines)
      controller.forgetSavedTheme();
    }
  }

  String _getBrightnessTheme(Brightness brightness) {
    final themes = themeProviderConfig.themes;
    final theme = themes.firstWhere(
      (element) => element.data.brightness == brightness,
      orElse: () => themes.first,
    );
    return theme.id;
  }
}
