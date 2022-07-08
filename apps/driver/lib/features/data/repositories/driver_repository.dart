import 'package:driver/features/data/data_sources/driver_api.dart';
import 'package:driver/features/data/models/delivers.dart';
import 'package:network/network.dart';

import '../../../common/utils/connectivity.dart';
import '../../../common/utils/helper_method.dart';
import '../models/invoices.dart';

class DriverRepository {
  final SConnectivity _connectivity;
  final DriverApi _remote;

  DriverRepository({
    required SConnectivity connectivity,
    required DriverApi remote,
  })  : _connectivity = connectivity,
        _remote = remote;

  Future<ApiResult<dynamic>> addSupport(String text) async {
    return await fetchApiResult<dynamic>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.addSupportText(text),
    );
  }

  Future<ApiResult> getProfile() async {
    return await fetchApiResult<dynamic>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getProfile(),
    );
  }

  Future<ApiResult> changeDeliveryStatue(
      {required String id, required String statue}) async {
    return await fetchApiResult<dynamic>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.changeDeliveryStatue(id: id, statue: statue),
    );
  }

  Future<ApiResult> endDelivery(
      {required String id, required int payingValue}) async {
    return await fetchApiResult<dynamic>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.endDelivery(id: id, payingValue: payingValue),
    );
  }

  Future<ApiResult<Invoices>> getInvoices() async {
    return await fetchApiResult<Invoices>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getInvoices(),
    );
  }

  Future<ApiResult> getStatistics() async {
    return await fetchApiResult<dynamic>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getStatistics(),
    );
  }

  // Future<ApiResult> getAvailableDeliveries() async {
  //   return await fetchApiResult<dynamic>(
  //     isConnected: _connectivity.isConnected,
  //     fetch: _remote.getAvailableDeliveries(),
  //   );
  // }

  Future<ApiResult<List<Delivers>>> getHistories() async {
    return await fetchApiResult<List<Delivers>>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getHistories(),
    );
  }

  Future<ApiResult<dynamic>> login({
    required String username,
    required String password,
    required String deviceToken,
    bool rememberMe = true,
  }) async {
    return await fetchApiResult<dynamic>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.login(
        username: username,
        password: password,
        deviceToken: deviceToken,
        rememberMe: rememberMe,
      ),
    );
  }

  Future<ApiResult<String>> signUp({
    required String email,
    required String password,
    required String deviceToken,
    bool rememberMe = true,
  }) async {
    return await fetchApiResult<String>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.signUP(),
    );
  }
}
