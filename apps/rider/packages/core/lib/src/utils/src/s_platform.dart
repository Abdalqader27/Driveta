/// File created by
/// Abed <Abed-supy-io>
/// on 27 /Apr/2022

part of '../utils.dart';

final _isIOS = Platform.isIOS;
final _isAndroid = Platform.isAndroid;
final _isLinux = Platform.isLinux;
final _isWindows = Platform.isWindows;
final _isMacOS = Platform.isMacOS;
final _isMobile = (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia);
final _isComputer = (Platform.isLinux || Platform.isMacOS || Platform.isWindows);
const _isWeb = kIsWeb;

bool get isIOS => _isIOS;

bool get isAndroid => _isAndroid;

bool get isLinux => _isLinux;

bool get isWindows => _isWindows;

bool get isMacOS => _isMacOS;

bool get isMobile => _isMobile;

bool get isComputer => _isComputer;

bool get isWeb => _isWeb;

extension SPlatform on Object {
  bool isAndroid() {
    return Platform.isAndroid;
  }

  bool isIOS() {
    return Platform.isIOS;
  }

  bool isLinux() {
    return Platform.isLinux;
  }

  bool isWindows() {
    return Platform.isWindows;
  }

  bool isMacOS() {
    return Platform.isMacOS;
  }

  bool isWeb() {
    return kIsWeb;
  }

  bool isMobile() {
    return (Platform.isAndroid || Platform.isIOS || Platform.isFuchsia);
  }

  bool isComputer() {
    return (Platform.isLinux || Platform.isMacOS || Platform.isWindows);
  }
}
