import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:dio_refresh_bot/dio_refresh_bot.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:network/network.dart';
import 'package:retry_bot/retry_bot.dart';

import '../../common/utils/connectivity.dart';
import '../../common/utils/storage/token_imp.dart';
import '../../main.dart';

///
class NetworkInjection {
  ///
  static void dependencies() async {
    si.registerLazySingleton(
      InternetConnectionChecker.new,
    );

    si.registerSingleton(
      SConnectivity(
        internetChecker: si<InternetConnectionChecker>(),
      ),
    );

    si.registerLazySingleton(
      () => Dio(),
    );
    si.registerLazySingleton(
      () => Connectivity(),
    );

    si.registerLazySingleton(
      () => DioConnectivityRequest(
        connectivity: si<Connectivity>(),
        dio: si<Dio>(),
      ),
    );
    si.registerLazySingleton(
      () => OnRetryConnection(
        request: si<DioConnectivityRequest>(),
        onTimeOut: () {
          BotToast.showText(
              text:
                  'Your connection timed-out. Please make sure you have good internet.');
        },
      ),
    );
    si.registerLazySingleton<RefreshBotMixin>(() => TokenStorageImpl());

    si.registerLazySingleton(
      () => RefreshTokenInterceptor<AuthToken>(
        dio: si<Dio>(),
        tokenStorage: si<RefreshBotMixin>(),
        refreshToken: (token, tokenDio) async {
          final response = await tokenDio.post(
            '/auth/refresh-token',
            data: {'refreshToken': token.refreshToken},
          );

          return AuthToken(
            accessToken: si<SStorage>().get(
              key: kAccessToken,
              type: ValueType.string,
            ),
            refreshToken: si<SStorage>().get(
              key: kRefreshToken,
              type: ValueType.string,
            ),
          );
        },
      ),
    );
    si.registerLazySingleton(() {
      return SHttpClient(
        dio: si<Dio>(),
        exceptionMapper: <T>(Response<T> response, exception) {
          final data = response.data;
          if (data != null && data is Map<String, dynamic>) {
            log('$exception');
            // We only map 418 responses that have json response data:
            return SResponseException(
              message: mapOfType(data['message']),
              error: "${data['error']}",
              exception: exception,
            );
          }
          return null;
        },
        // baseUrl: FlavorConfig.instance.variables["baseUrl"],
        baseUrl: kBase,
        interceptors: [
          si<RefreshTokenInterceptor>(),
          si<OnRetryConnection>(),
        ],
      );
    });
  }

  static String mapOfType(dynamic message) {
    String result = "";
    if (message is List) {
      for (String word in message) {
        result += word;
        result += "\n";
      }
    } else if (message is String) {
      result = message;
    } else {
      result = "An error occurred.";
    }
    return result;
  }
}

const kBase = 'http://driveta2-001-site1.itempurl.com/';
