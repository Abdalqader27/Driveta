import 'dart:convert';import 'package:core/core.dart';import 'package:dio/dio.dart';import 'package:either_dart/either.dart';import 'package:firebase_messaging/firebase_messaging.dart';import 'package:http_parser/http_parser.dart';import 'package:image_picker/image_picker.dart';import 'package:network/network.dart';import 'package:rider/features/data/models/delivers.dart';import 'package:rider/features/data/models/store.dart';import '../../../common/utils/helper_method.dart';import '../../../main.dart';import '../../presentation/pages/map/widgets/choice_cars.dart';import '../models/delivers_product.dart';import '../models/user.dart';class RiderApi {  RiderApi({required SHttpClient api}) : _api = api;  final SHttpClient _api;  Future<Either<dynamic, dynamic>> addSupportText(String text) {    return fetch(call: () async {      final response = await _api.post(        'api/CustomerApp/AddSupport',        data: {'description': text},        options: Options(          headers: {            'Content-Type': 'application/json',            'Accept': 'application/json',            'Authorization': 'Bearer ${si<SStorage>().get(              key: kAccessToken,              type: ValueType.string,            )}',          },        ),      );      (json.encode(response.data)).log();      return response.data;    });  }  Future<Either<dynamic, dynamic>> rateDelivery(    String deliveryId,    double rate,  ) {    return fetch(call: () async {      final response = await _api.put(        'api/CustomerApp/RateDelivery?id=$deliveryId&rate=$rate',        options: Options(          headers: {            'Content-Type': 'application/json',            'Accept': 'application/json',            'Authorization': 'Bearer ${si<SStorage>().get(              key: kAccessToken,              type: ValueType.string,            )}',          },        ),      );      (json.encode(response.data)).log();      return response.data;    });  }  Future<Either<dynamic, dynamic>> removeDelivery() {    return fetch(call: () async {      final response = await _api.delete<dynamic>(        'api/CustomerApp/RemoveDelivery',        options: Options(          headers: {            'Content-Type': 'application/json',            'Accept': 'application/json',            'Authorization': 'Bearer ${si<SStorage>().get(              key: kAccessToken,              type: ValueType.string,            )}',          },        ),      );      (json.encode(response.data)).log();      return response.data;    });  }  Future<Either<dynamic, List<CarDetails>>> getVehicleTypes() {    return fetch(call: () async {      final response = await _api.get(        'api/CustomerApp/GetVehicleTypes',        options: Options(          headers: {            'Content-Type': 'application/json',            'Accept': 'application/json',            'Authorization': 'Bearer ${si<SStorage>().get(              key: kAccessToken,              type: ValueType.string,            )}',          },        ),      );      final List<CarDetails> list =          List.from((response.data).map((i) => CarDetails.fromJson(i)));      return list;    });  }  Future<Either<dynamic, User>> profile() {    return fetch(call: () async {      final response = await _api.get(        'api/CustomerApp/Profile',        options: Options(          headers: {            'Content-Type': 'application/json',            'Accept': 'application/json',            'Authorization': 'Bearer ${si<SStorage>().get(              key: kAccessToken,              type: ValueType.string,            )}',          },        ),      );      (json.encode(response.data)).log();      return User.fromJson(response.data);    });  }  Future<Either<dynamic, List<Store>>> getStores() {    return fetch(call: () async {      final response = await _api.get(        'api/CustomerApp/GetStores',        options: Options(          headers: {            'Content-Type': 'application/json',            'Accept': 'application/json',            'Authorization': 'Bearer ${si<SStorage>().get(              key: kAccessToken,              type: ValueType.string,            )}',          },        ),      );      (json.encode(response.data)).log();      final List<Store> list =          List.from((response.data).map((i) => Store.fromJson(i)));      return list;    });  }  Future<Either<dynamic, List<DeliversProduct>>> getProductDeliveries() {    return fetch(call: () async {      final response = await _api.get(        'api/CustomerApp/GetProductDeliveries',        options: Options(          headers: {            'Content-Type': 'application/json',            'Accept': 'application/json',            'Authorization': 'Bearer ${si<SStorage>().get(              key: kAccessToken,              type: ValueType.string,            )}',          },        ),      );      (json.encode(response.data)).log();      final List<DeliversProduct> list =          List.from((response.data).map((i) => DeliversProduct.fromJson(i)));      return list;    });  }  Future<Either<dynamic, StoreDetails>> getStoreDetails(id) {    return fetch(call: () async {      final response = await _api.get(        'api/CustomerApp/GetStoreDetails?id=$id',        options: Options(          headers: {            'Content-Type': 'application/json',            'Accept': 'application/json',            'Authorization': 'Bearer ${si<SStorage>().get(              key: kAccessToken,              type: ValueType.string,            )}',          },        ),      );      (json.encode(response.data)).log();      return StoreDetails.fromJson(response.data);    });  }  Future<Either<dynamic, List<Delivers>>> getDeliveries() {    return fetch(call: () async {      final response = await _api.get(        'api/CustomerApp/GetDeliveries',        options: Options(          headers: {            'Content-Type': 'application/json',            'Accept': 'application/json',            'Authorization': 'Bearer ${si<SStorage>().get(              key: kAccessToken,              type: ValueType.string,            )}',          },        ),      );      (json.encode(response.data)).log();      final List<Delivers> list =          List.from((response.data).map((i) => Delivers.fromJson(i)));      return List.from(list);    });  }  Future<Either<dynamic, dynamic>> signUp({    String? userName,    String? name,    String? phoneNumber,    String? email,    String? password,    int? sexType,    int? bloodType,    String? dob,    XFile? personalImageFile,    XFile? idPhotoFile,    XFile? drivingCertificateFile,  }) async {    return fetch(      call: () async {        FormData formData = FormData.fromMap({          'userName': userName,          'name': name,          'phoneNumber': jsonEncode({            "countryCode": "SY",            "isValid": true,            "phoneNumber": "$phoneNumber",            "countryCallingCode": "963",            "formattedNumber": " + 963$phoneNumber",            "nationalNumber": "$phoneNumber",            "formatInternational": " + 963$phoneNumber",            "formatNational": ""          }),          'email': email,          'password': password,          'sexType': sexType,          'bloodType': bloodType,          'dob': dob,          'personalImageFile': personalImageFile != null              ? FormData.fromMap(<String, dynamic>{                  'file': await MultipartFile.fromFile(                    personalImageFile.path,                    filename: personalImageFile.name,                    contentType: MediaType('image', 'png'),                  ),                })              : null,          'idPhotoFile': idPhotoFile != null              ? FormData.fromMap(<String, dynamic>{                  'file': await MultipartFile.fromFile(                    idPhotoFile.path,                    filename: idPhotoFile.name,                    contentType: MediaType('image', 'png'),                  ),                })              : null,        });        await _api.post(          'api/CustomerApp/SignUp',          data: formData,        );        return signIn(          username: userName!,          password: password!,          deviceToken: await FirebaseMessaging.instance.getToken() ?? '',        );      },    );  }  Future<Either<dynamic, dynamic>> signIn({    required String username,    required String password,    required String deviceToken,    bool rememberMe = true,  }) async {    return fetch(      call: () async {        final response = await _api.post(          'api/CustomerApp/SignIn',          data: {            'username': username,            'password': password,            'deviceToken': deviceToken,            'rememberMe': rememberMe          },        );        (json.encode(response.data)).log();        return User.fromJson(response.data);      },    );  } //CustomerApp/EndDelivery // EndDelivery(Guid id, double rate) /// Real time invoke replaced // Future<Either<SResponseException, dynamic>> addDelivery({ //   required String startLat, //   required String startLong, //   required String endLat, //   required String endLong, //   required int distance, //   required String expectedTime, //   required int price, //   required String pickUp, //   required String dropOff, // }) { //   print("AddDelivery is fired "); // //   return fetch(call: () async { //     final response = await _api.post<dynamic>( //       'api/SignalR/AddDelivery', //       data: { //         'startLat': startLat.toString(), //         'startLong': startLong.toString(), //         'endLat': endLat.toString(), //         'endLong': endLong.toString(), //         'distance': distance, //         'price': price, //         'expectedTime': expectedTime, //         'pickUp': pickUp.toString(), //         'dropOff': dropOff.toString(), //       }, //     ); //     print("AddDelivery is sending data ${json.encode({ //           'startLat': startLat.toString(), //           'startLong': startLong.toString(), //           'endLat': endLat.toString(), //           'endLong': endLong.toString(), //           'distance': distance, //           'price': price, //           'expectedTime': expectedTime, //           'pickUp': pickUp.toString(), //           'dropOff': dropOff.toString(), //         })} "); //     return response.data; //   }); // } // // Future<Either<SResponseException, dynamic>> endDeliveryCustomer( //     {required num price, //     required String id, //     required String endLat, //     required String endLong, //     required num distance, //     required String dropOff, //     required String expectedTime}) { //   print("EndDeliveryCustomer is fired "); //   return fetch(call: () async { //     final response = await _api.put<dynamic>( //       'api/SignalR/EndDeliveryCustomer', //       data: { //         'price': price, //         'id': id, //         'endLat': endLat, //         'endLong': endLong, //         'distance': distance, //         'expectedTime': expectedTime, //         'dropOff': dropOff //       }, //     ); //     print("EndDeliveryCustomer is sending data ${json.encode({ //           'price': price, //           'id': id, //           'endLat': endLat, //           'endLong': endLong, //           'distance': distance, //           'expectedTime': expectedTime, //           'dropOff': dropOff //         })} "); //     return response.data; //   }); // }}