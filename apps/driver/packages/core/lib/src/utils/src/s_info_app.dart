/// File created by/// Abed <Abed-supy-io>/// on 28 /Apr/2022part of '../utils.dart';class SInfoApp {  final PackageInfo packageInfo;  SInfoApp(this.packageInfo);  String get appName => packageInfo.appName;  String get packageName => packageInfo.packageName;  String get appVersion => packageInfo.version;  String get buildNumber => packageInfo.buildNumber;  Version get semVersion => Version.parse(packageInfo.version);}