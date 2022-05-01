import 'dart:io';

mixin GoogleApiKey {
  String getApiKey() {
    return Platform.isAndroid
        ? "AIzaSyCeL6NXSWQJcyl0SjF3CZ0-3vN3q90aGc8"
        : "AIzaSyCeL6NXSWQJcyl0SjF3CZ0-3vN3q90aGc8";
  }
}

const kMapKey = 'AIzaSyCeL6NXSWQJcyl0SjF3CZ0-3vN3q90aGc8';
