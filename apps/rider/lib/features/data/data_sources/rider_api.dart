import 'dart:convert';import 'package:core/core.dart';import 'package:dio/dio.dart';import 'package:either_dart/either.dart';import 'package:http_parser/http_parser.dart';import 'package:image_picker/image_picker.dart';import 'package:network/network.dart';import 'package:rider/features/data/models/delivers.dart';import 'package:rider/features/data/models/store.dart';import '../../../common/utils/helper_method.dart';import '../../presentation/pages/map/widgets/choice_cars.dart';import '../models/user.dart';class RiderApi {  RiderApi({required SHttpClient api}) : _api = api;  final SHttpClient _api;  Future<Either<SResponseException, dynamic>> addSupportText(String text) {    return fetch(call: () async {      final response = await _api.post<dynamic>(        'api/CustomerApp/AddSupport',        data: {'description': text},      );      (json.encode(response.data)).log();      return response.data;    });  }  Future<Either<SResponseException, dynamic>> removeDelivery() {    return fetch(call: () async {      final response = await _api.delete<dynamic>(        'api/CustomerApp/RemoveDelivery',      );      (json.encode(response.data)).log();      return response.data;    });  }  Future<Either<SResponseException, List<CarDetails>>> getVehicleTypes() {    return fetch(call: () async {      final response = await _api.get(        'api/CustomerApp/GetVehicleTypes',      );      final List<CarDetails> list =          List.from((response.data).map((i) => CarDetails.fromJson(i)));      return list;    });  }  Future<Either<SResponseException, User>> profile() {    return fetch(call: () async {      final response = await _api.get(        'api/CustomerApp/Profile',      );      (json.encode(response.data)).log();      return User.fromJson(response.data);    });  }  Future<Either<SResponseException, List<Store>>> getStores() {    return fetch(call: () async {      final response = await _api.get(        'api/CustomerApp/GetStores',      );      (json.encode(response.data)).log();      final List<Store> list =          List.from((response.data).map((i) => Store.fromJson(i)));      return list;    });  }  Future<Either<SResponseException, StoreDetails>> getStoreDetails(id) {    return fetch(call: () async {      final response = await _api.get(        'api/CustomerApp/GetStoreDetails?id=$id',      );      (json.encode(response.data)).log();      return StoreDetails.fromJson(response.data);    });  }  Future<Either<SResponseException, List<Delivers>>> getDeliveries() {    return fetch(call: () async {      final response = await _api.get(        'api/CustomerApp/GetDeliveries',      );      (json.encode(response.data)).log();      final List<Delivers> list =          List.from((response.data).map((i) => Delivers.fromJson(i)));      return List.from(list);    });  }  Future<Either<SResponseException, String>> signUp({    String? userName,    String? name,    String? phoneNumber,    String? email,    String? password,    int? sexType,    int? bloodType,    DateTime? dob,    XFile? personalImageFile,    XFile? idPhotoFile,    XFile? drivingCertificateFile,  }) async {    return fetch(      call: () async {        await _api.post(          'api/DriverApp/SignUp',          data: {            'userName': userName,            'name': name,            'phoneNumber': phoneNumber,            'email': email,            'password': password,            'sexType': sexType,            'bloodType': bloodType,            'dob': dob?.toIso8601String(),            'personalImageFile': personalImageFile != null                ? FormData.fromMap(<String, dynamic>{                    'file': await MultipartFile.fromFile(                      personalImageFile.path,                      filename: personalImageFile.name,                      contentType: MediaType('image', 'png'),                    ),                  })                : null,            'idPhotoFile': idPhotoFile != null                ? FormData.fromMap(<String, dynamic>{                    'file': await MultipartFile.fromFile(                      idPhotoFile.path,                      filename: idPhotoFile.name,                      contentType: MediaType('image', 'png'),                    ),                  })                : null,            'drivingCertificateFile': drivingCertificateFile != null                ? FormData.fromMap(<String, dynamic>{                    'file': await MultipartFile.fromFile(                      drivingCertificateFile.path,                      filename: drivingCertificateFile.name,                      contentType: MediaType('image', 'png'),                    ),                  })                : null,          },        );        return 'Verification Code sent';      },    );  }  Future<Either<SResponseException, dynamic>> signIn({    required String username,    required String password,    required String deviceToken,    bool rememberMe = true,  }) async {    return fetch(      call: () async {        final response = await _api.post(          'api/CustomerApp/SignIn',          data: {            'username': username,            'password': password,            'deviceToken': deviceToken,            'rememberMe': rememberMe          },        );        (json.encode(response.data)).log();        return User.fromJson(response.data);      },    );  }//CustomerApp/EndDelivery// EndDelivery(Guid id, double rate)  /// Real time invoke replaced// Future<Either<SResponseException, dynamic>> addDelivery({//   required String startLat,//   required String startLong,//   required String endLat,//   required String endLong,//   required int distance,//   required String expectedTime,//   required int price,//   required String pickUp,//   required String dropOff,// }) {//   print("AddDelivery is fired ");////   return fetch(call: () async {//     final response = await _api.post<dynamic>(//       'api/SignalR/AddDelivery',//       data: {//         'startLat': startLat.toString(),//         'startLong': startLong.toString(),//         'endLat': endLat.toString(),//         'endLong': endLong.toString(),//         'distance': distance,//         'price': price,//         'expectedTime': expectedTime,//         'pickUp': pickUp.toString(),//         'dropOff': dropOff.toString(),//       },//     );//     print("AddDelivery is sending data ${json.encode({//           'startLat': startLat.toString(),//           'startLong': startLong.toString(),//           'endLat': endLat.toString(),//           'endLong': endLong.toString(),//           'distance': distance,//           'price': price,//           'expectedTime': expectedTime,//           'pickUp': pickUp.toString(),//           'dropOff': dropOff.toString(),//         })} ");//     return response.data;//   });// }//// Future<Either<SResponseException, dynamic>> endDeliveryCustomer(//     {required num price,//     required String id,//     required String endLat,//     required String endLong,//     required num distance,//     required String dropOff,//     required String expectedTime}) {//   print("EndDeliveryCustomer is fired ");//   return fetch(call: () async {//     final response = await _api.put<dynamic>(//       'api/SignalR/EndDeliveryCustomer',//       data: {//         'price': price,//         'id': id,//         'endLat': endLat,//         'endLong': endLong,//         'distance': distance,//         'expectedTime': expectedTime,//         'dropOff': dropOff//       },//     );//     print("EndDeliveryCustomer is sending data ${json.encode({//           'price': price,//           'id': id,//           'endLat': endLat,//           'endLong': endLong,//           'distance': distance,//           'expectedTime': expectedTime,//           'dropOff': dropOff//         })} ");//     return response.data;//   });// }}