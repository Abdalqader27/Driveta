import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:driver/common/utils/connectivity.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:network/network.dart';
import 'package:retry_bot/retry_bot.dart';

import '../../app_injection.dart';

const kBaseUrl = 'http://drivetaplatform-001-site1.etempurl.com/';

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
        baseUrl: kBaseUrl,
        interceptors: [
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
