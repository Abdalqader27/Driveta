import 'package:core/core.dart';
import 'package:driver/features/data/repositories/driver_repository.dart';
import 'package:network/network.dart';

import '../../../app_injection.dart';
import '../../../common/utils/helper_method.dart';
import '../../data/models/driver_info.dart';

class DriverUseCase {
  DriverUseCase({required DriverRepository repository})
      : _repository = repository;

  final DriverRepository _repository;

  Future<ApiResult<dynamic>> addSupport(String text) async {
    return onResult<dynamic>(
      await _repository.addSupport(text),
      onData: (data) {},
    );
  }

  Future<ApiResult<dynamic>> getProfile() async {
    return onResult<dynamic>(
      await _repository.getProfile(),
      onData: (data) {},
    );
  }

  Future<ApiResult<dynamic>> changeDeliveryStatue(
      {required String id, required String statue}) async {
    return onResult<dynamic>(
      await _repository.changeDeliveryStatue(id: id, statue: statue),
      onData: (data) {},
    );
  }

  Future<ApiResult<dynamic>> endDelivery(
      {required String id, required int payingValue}) async {
    return onResult<dynamic>(
      await _repository.endDelivery(id: id, payingValue: payingValue),
      onData: (data) {},
    );
  }

  // Future<ApiResult<dynamic>> getAvailableDeliveries() async {
  //   return onResult<dynamic>(
  //     await _repository.getAvailableDeliveries(),
  //     onData: (data) {},
  //   );
  // }

  Future<ApiResult<dynamic>> getInvoices() async {
    return onResult<dynamic>(
      await _repository.getInvoices(),
      onData: (data) {},
    );
  }

  Future<ApiResult<dynamic>> getStatistics() async {
    return onResult<dynamic>(
      await _repository.getStatistics(),
      onData: (data) {},
    );
  }

  Future<ApiResult<dynamic>> getHistories() async {
    return onResult<dynamic>(
      await _repository.getHistories(),
      onData: (data) {},
    );
  }

  Future<ApiResult<dynamic>> login({
    required String email,
    required String password,
    required String deviceToken,
    bool rememberMe = true,
  }) async {
    return onResult<dynamic>(
      await _repository.login(
        username: email,
        password: password,
        deviceToken: deviceToken,
        rememberMe: rememberMe,
      ),
      onData: (data) {
        si<SStorage>().set(key: kAccessToken, value: data.token);
      },
    );
  }
}
