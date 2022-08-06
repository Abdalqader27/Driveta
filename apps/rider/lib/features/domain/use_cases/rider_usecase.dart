import 'package:core/core.dart';import 'package:image_picker/image_picker.dart';import 'package:network/network.dart';import '../../../common/utils/helper_method.dart';import '../../../main.dart';import '../../data/models/delivers.dart';import '../../data/models/delivers_product.dart';import '../../data/models/store.dart';import '../../data/models/user.dart';import '../../data/repositories/rider_repository.dart';import '../../presentation/pages/map/widgets/choice_cars.dart';class RiderUseCase {  RiderUseCase({required RiderRepository repository})      : _repository = repository;  final RiderRepository _repository;  Future<ApiResult<dynamic>> addSupport(String text) async {    return onResult<dynamic>(      await _repository.addSupport(text),      onData: (data) {},    );  }  Future<ApiResult<dynamic>> removeDelivery() async {    return onResult<dynamic>(      await _repository.removeDelivery(),      onData: (data) {},    );  }  Future<ApiResult<List<CarDetails>>> getVehicleTypes() async {    return onResult<List<CarDetails>>(      await _repository.getVehicleTypes(),      onData: (data) {},    );  }  Future<ApiResult<User>> profile() async {    return onResult<User>(      await _repository.profile(),      onData: (data) {},    );  }  Future<ApiResult<List<Delivers>>> getDeliveries() async {    return onResult<List<Delivers>>(      await _repository.getDeliveries(),      onData: (data) {},    );  }  Future<ApiResult<List<DeliversProduct>>> getProductDeliveries() async {    return onResult<List<DeliversProduct>>(      await _repository.getProductDeliveries(),      onData: (data) {},    );  }  Future<ApiResult<List<Store>>> getStores() async {    return onResult<List<Store>>(      await _repository.getStores(),      onData: (data) {},    );  }  Future<ApiResult<StoreDetails>> getStoreDetails(id) async {    return onResult<StoreDetails>(      await _repository.getStoreDetails(id),      onData: (data) {},    );  }  Future<ApiResult<dynamic>> login({    required String email,    required String password,    required String deviceToken,    bool rememberMe = true,  }) async {    return onResult<dynamic>(      await _repository.login(        username: email,        password: password,        deviceToken: deviceToken,        rememberMe: rememberMe,      ),      onData: (data) {        print("sss $data");        si<SStorage>().set(key: kAccessToken, value: data.token);      },    );  }  Future<ApiResult<dynamic>> signUp({    String? userName,    String? name,    String? phoneNumber,    String? email,    String? password,    int? sexType,    int? bloodType,    String? dob,    XFile? personalImageFile,    XFile? idPhotoFile,    XFile? drivingCertificateFile,  }) async {    return onResult<dynamic>(      await _repository.signUp(        userName: userName,        name: name,        phoneNumber: phoneNumber,        email: email,        password: password,        sexType: sexType,        bloodType: bloodType,        dob: dob,        personalImageFile: personalImageFile,        idPhotoFile: idPhotoFile,        drivingCertificateFile: drivingCertificateFile,      ),      onData: (data) {        print("sss $data");        si<SStorage>().set(key: kAccessToken, value: data.token);      },    );  }}