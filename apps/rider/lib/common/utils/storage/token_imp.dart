import 'dart:async';

import 'package:core/core.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart';

import '../../../main.dart';

class TokenStorageImpl extends BotMemoryTokenStorage<AuthToken>
    with RefreshBotMixin {
  final sStorage = si<SStorage>();

  @override
  FutureOr<void> delete([String? message]) {
    super.delete(message);
    sStorage.set(key: kAccessToken, value: null);
    sStorage.set(key: kRefreshToken, value: null);
    return null;
  }

  @override
  AuthToken? get initValue {
    if (sStorage.get(key: kAccessToken, type: ValueType.string).isEmpty) {
      return null;
    }
    return AuthToken(
      accessToken: sStorage.get(
        key: kAccessToken,
        type: ValueType.string,
      ),
      refreshToken: sStorage.get(
        key: kRefreshToken,
        type: ValueType.string,
      ),
    );
  }

  @override
  Future<void> write(AuthToken? value) async {
    await super.write(value);
    sStorage.set(
      key: kAccessToken,
      value: value?.accessToken ?? '',
    );
    si<SStorage>().set(
      key: kRefreshToken,
      value: value?.refreshToken ?? '',
    );
  }
}
