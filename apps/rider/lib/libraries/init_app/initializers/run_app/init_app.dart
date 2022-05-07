import 'package:flutter/material.dart';

import '../../../configs_models.dart';
import '../flags.dart';
import 'export_packages.dart';

class InitApp {
  static Future<void> init({
    AppConfig appConfig = const AppConfig(),
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initAppConfig(appConfig);
  }

  static Future<void> _initAppConfig(AppConfig appConfig) async {
    await _setSystemChrome(
      systemUiOverlayStyle: appConfig.systemUiOverlayStyle,
      orientations: appConfig.orientations,
    );
    await _setAndroidFlags(appConfig.flags);
    if (appConfig.enableEasyLocalization) {
      easyLocalizationEnabled = true;
      await _initEasyLocalization();
    } else {
      easyLocalizationEnabled = false;
    }
    if (appConfig.enableMoorInspector) {
      assert(appConfig.moorDatabase != null);
      await _initMoorInspector(appConfig.moorDatabase!);
    }

    if (appConfig.enableFirebase) {
      await _initFirebase();
    }
  }

  static Future<void> _setSystemChrome(
      {List<DeviceOrientation>? orientations, SystemUiOverlayStyle? systemUiOverlayStyle}) async {
    if (orientations != null) {
      await SystemChrome.setPreferredOrientations(orientations);
    }
    if (systemUiOverlayStyle != null) {
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  static Future<void> _setAndroidFlags(List<int> flags) async {
    if (kReleaseMode && flags.isNotEmpty) {
      for (final flag in flags) {
        await FlutterWindowManager.addFlags(flag);
      }
    }
  }

  static Future<void> _initMoorInspector(GeneratedDatabase database) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (!kReleaseMode) {
      final moorInspectorBuilder = MoorInspectorBuilder()
        ..bundleId = packageInfo.packageName
        ..icon = 'flutter'
        ..addDatabase('AppDatabase', database);
      final inspector = moorInspectorBuilder.build();
      await inspector.start();
    }
  }

  static Future<void> _initFirebase() async {
    await Firebase.initializeApp();
  }

  static Future<void> _initEasyLocalization() async {
    await EasyLocalization.ensureInitialized();
  }
}
