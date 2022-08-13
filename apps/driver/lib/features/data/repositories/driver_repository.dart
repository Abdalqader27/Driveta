import 'package:driver/features/data/data_sources/driver_api.dart';
import 'package:driver/features/data/models/delivers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network/network.dart';

import '../../../common/utils/connectivity.dart';
import '../../../common/utils/helper_method.dart';
import '../models/invoices.dart';
import '../models/statistics.dart';

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

  Future<ApiResult<List<Delivers>>> getAvailableDelivers() async {
    return await fetchApiResult<List<Delivers>>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getAvailableDeliveries(),
    );
  }

  Future<ApiResult<Statistics>> getStatistics() async {
    return await fetchApiResult<Statistics>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getStatistics(),
    );
  }

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

  Future<ApiResult<dynamic>> signUp({
    String? userName,
    String? name,
    String? phoneNumber,
    String? email,
    String? password,
    int? sexType,
    int? bloodType,
    String? dob,
    XFile? personalImageFile,
    XFile? idPhotoFile,
    XFile? drivingCertificateFile,
  }) async {
    return await fetchApiResult(
      isConnected: _connectivity.isConnected,
      fetch: _remote.signUp(
        userName: userName,
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        sexType: sexType,
        bloodType: bloodType,
        dob: dob,
        personalImageFile: personalImageFile,
        idPhotoFile: idPhotoFile,
        drivingCertificateFile: drivingCertificateFile,
      ),
    );
  }
}
