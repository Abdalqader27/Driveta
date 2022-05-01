import 'package:flutter/services.dart';
import 'package:moor/moor.dart';

import 'easy_localization_config.dart';

class AppConfig {
  final List<DeviceOrientation>? orientations;
  final bool enableEasyLocalization;
  final bool enableMoorInspector;
  final bool enableBlocObserver;
  final bool enableFirebase;
  final bool enableDevicePreview;
  final EasyLocalizationConfig? easyLocalizationConfig;
  final List<int> flags;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final GeneratedDatabase? moorDatabase;

  const AppConfig({
    this.orientations,
    this.flags = const [],
    this.moorDatabase,
    this.enableEasyLocalization = false,
    this.enableMoorInspector = false,
    this.enableBlocObserver = false,
    this.enableFirebase = false,
    this.enableDevicePreview = false,
    this.easyLocalizationConfig,
    this.systemUiOverlayStyle,
  });
}
