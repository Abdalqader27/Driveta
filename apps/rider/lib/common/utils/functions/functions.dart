import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../features/injection/injection_network.dart';

class Functions {
  static Future<String> getFileData(String path) async =>
      await rootBundle.loadString(path);

  static String getImagePath(String path, {Size? size}) {
    if (size != null) {
      final List<String> list = path.split('/');
      String tempPath = list.join('%2f');
      tempPath = tempPath.replaceFirst('~', '$kBase/image/');
      tempPath =
          '${tempPath.trim()}?width=${size.width.toInt()}&height=${size.height.toInt()}';
      log(tempPath);
      return tempPath;
    } else {
      return path.replaceFirst('~', kBase);
    }
  }

  static String? getSearchText(String? string) {
    return string
        ?.trim()
        .replaceAll('أ', 'ا')
        .replaceAll('إ', 'ا')
        .toLowerCase();
  }
}
