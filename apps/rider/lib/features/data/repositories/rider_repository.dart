import 'package:image_picker/image_picker.dart';
import 'package:network/network.dart';
import 'package:rider/features/data/data_sources/rider_api.dart';
import 'package:rider/features/data/models/delivers_product.dart';
import 'package:rider/features/data/models/driver.dart';
import 'package:rider/features/data/models/store.dart';

import '../../../common/utils/connectivity.dart';
import '../../../common/utils/helper_method.dart';
import '../../presentation/pages/map/widgets/choice_cars.dart';
import '../models/delivers.dart';
import '../models/user.dart';

class RiderRepository {
  final SConnectivity _connectivity;
  final RiderApi _remote;
  RiderRepository({
    required SConnectivity connectivity,
    required RiderApi remote,
  })  : _connectivity = connectivity,
        _remote = remote;
  Future<ApiResult<dynamic>> addSupport(String text) async {
    return await fetchApiResult<dynamic>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.addSupportText(text),
    );
  }

  // Future<ApiResult<dynamic>> endDelivery(
  //     {required String rate, required String id}) async {
  //   return await fetchApiResult<dynamic>(
  //     isConnected: _connectivity.isConnected,
  //     fetch: _remote.endDeliveryCustomer(rate: rate, id: id),
  //   );
  // }

  Future<ApiResult<dynamic>> removeDelivery() async {
    return await fetchApiResult<dynamic>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.removeDelivery(),
    );
  }

  Future<ApiResult<List<CarDetails>>> getVehicleTypes() async {
    return await fetchApiResult<List<CarDetails>>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getVehicleTypes(),
    );
  }

  Future<ApiResult<User>> profile() async {
    return await fetchApiResult<User>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.profile(),
    );
  }

  Future<ApiResult<List<Delivers>>> getDeliveries() async {
    return await fetchApiResult<List<Delivers>>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getDeliveries(),
    );
  }

  Future<ApiResult<List<DeliversProduct>>> getProductDeliveries() async {
    return await fetchApiResult<List<DeliversProduct>>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getProductDeliveries(),
    );
  }

  Future<ApiResult<DeliversProduct>> getDelivery() async {
    return await fetchApiResult<DeliversProduct>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getDelivery(),
    );
  }

  Future<ApiResult<List<Store>>> getStores() async {
    return await fetchApiResult<List<Store>>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getStores(),
    );
  }

  Future<ApiResult<StoreDetails>> getStoreDetails(id) async {
    return await fetchApiResult<StoreDetails>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getStoreDetails(id),
    );
  }

  Future<ApiResult<Driver>> getDriver(id) async {
    return await fetchApiResult<Driver>(
      isConnected: _connectivity.isConnected,
      fetch: _remote.getDriver(id),
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
      fetch: _remote.signIn(
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
