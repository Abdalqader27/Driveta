import 'dart:convert';import 'package:core/core.dart';import 'package:dio/dio.dart';import 'package:either_dart/either.dart';import 'package:http_parser/http_parser.dart';import 'package:network/network.dart';import 'package:image_picker/image_picker.dart';import '../../../common/utils/helper_method.dart';class RiderApi {  RiderApi({required SHttpClient api}) : _api = api;  final SHttpClient _api;  Future<Either<SResponseException, dynamic>> addSupportText(String text) {    return fetch(call: () async {      final response = await _api.post<dynamic>(        'api/CustomerApp/AddSupport',        data: {'description': text},      );      return response.data;    });  }  Future<Either<SResponseException, dynamic>> endDelivery(String rate) {    return fetch(call: () async {      final response = await _api.put<dynamic>(        'api/CustomerApp/EndDelivery',        data: {'rate': rate},      );      return response.data;    });  }  Future<Either<SResponseException, dynamic>> removeDelivery() {    return fetch(call: () async {      final response = await _api.delete<dynamic>(        'api/CustomerApp/RemoveDelivery',      );      return response.data;    });  }  Future<Either<SResponseException, dynamic>> getVehicleTypes() {    return fetch(call: () async {      final response = await _api.get<dynamic>(        'api/CustomerApp/GetVehicleTypes',      );      return response.data;    });  }  Future<Either<SResponseException, dynamic>> profile() {    return fetch(call: () async {      final response = await _api.get<dynamic>(        'api/CustomerApp/Profile',      );      return response.data;    });  }  Future<Either<SResponseException, dynamic>> getDeliveries() {    return fetch(call: () async {      final response = await _api.get<dynamic>(        'api/CustomerApp/GetDeliveries',      );      return response.data;    });  }  Future<Either<SResponseException, String>> signUp({    String? userName,    String? name,    String? phoneNumber,    String? email,    String? password,    int? sexType,    int? bloodType,    DateTime? dob,    XFile? personalImageFile,    XFile? idPhotoFile,    XFile? drivingCertificateFile,  }) async {    return fetch(      call: () async {        await _api.post(          'api/DriverApp/SignUp',          data: {            'userName': userName,            'name': name,            'phoneNumber': phoneNumber,            'email': email,            'password': password,            'sexType': sexType,            'bloodType': bloodType,            'dob': dob?.toIso8601String(),            'personalImageFile': personalImageFile != null                ? FormData.fromMap(<String, dynamic>{                    'file': await MultipartFile.fromFile(                      personalImageFile.path,                      filename: personalImageFile.name,                      contentType: MediaType('image', 'png'),                    ),                  })                : null,            'idPhotoFile': idPhotoFile != null                ? FormData.fromMap(<String, dynamic>{                    'file': await MultipartFile.fromFile(                      idPhotoFile.path,                      filename: idPhotoFile.name,                      contentType: MediaType('image', 'png'),                    ),                  })                : null,            'drivingCertificateFile': drivingCertificateFile != null                ? FormData.fromMap(<String, dynamic>{                    'file': await MultipartFile.fromFile(                      drivingCertificateFile.path,                      filename: drivingCertificateFile.name,                      contentType: MediaType('image', 'png'),                    ),                  })                : null,          },        );        return 'Verification Code sent';      },    );  }  Future<Either<SResponseException, dynamic>> signIn({    required String username,    required String password,    required String deviceToken,    bool rememberMe = true,  }) async {    return fetch(      call: () async {        final response = await _api.post(          'api/CustomerApp/SignIn',          data: {'username': username, 'password': password, 'deviceToken': deviceToken, 'rememberMe': rememberMe},        );        (json.encode(response.data)).log();        //return DriverInfo.fromJson(response.data);      },    );  }}