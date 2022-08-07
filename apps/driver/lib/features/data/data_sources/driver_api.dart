import 'dart:convert';

import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:driver/features/data/models/invoices.dart';
import 'package:either_dart/either.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network/network.dart';

import '../../../common/utils/helper_method.dart';
import '../models/delivers.dart';
import '../models/driver_info.dart';
import '../models/profile.dart';
import '../models/statistics.dart';

class DriverApi {
  DriverApi({required SHttpClient api}) : _api = api;

  final SHttpClient _api;

  Future<Either<dynamic, dynamic>> addSupportText(String text) {
    return fetch(call: () async {
      final response = await _api.post<dynamic>(
        'api/DriverApp/AddSupport',
        data: {'description': text},
      );
      return response.data;
    });
  }

  Future<Either<dynamic, dynamic>> getProfile() {
    return fetch(call: () async {
      final response = await _api.get<dynamic>(
        'api/DriverApp/Profile',
      );
      return DriverProfile.fromJson(response.data);
    });
  }

  Future<Either<dynamic, Invoices>> getInvoices() {
    return fetch(call: () async {
      final response = await _api.get<dynamic>(
        'api/DriverApp/GetInvoices',
      );
      (json.encode(response.data)).log();
      return Invoices.fromJson(response.data);
      // return DriverProfile.fromJson(response.data);
    });
  }

  Future<Either<dynamic, Statistics>> getStatistics() {
    return fetch(call: () async {
      final response = await _api.get(
        'api/DriverApp/GetStatistics',
      );
      (json.encode(response.data)).log();
      return Statistics.fromJson(response.data);
      // return DriverProfile.fromJson(response.data);
    });
  }

  Future<Either<dynamic, List<Delivers>>> getHistories() {
    return fetch(call: () async {
      final response = await _api.get(
        'api/DriverApp/GetDeliveries',
      );
      (json.encode(response.data)).log();

      final List<Delivers> list =
          List.from((response.data).map((i) => Delivers.fromJson(i)));

      return List.from(list);
      // return DriverProfile.fromJson(response.data);
    });
  }

  Future<Either<dynamic, dynamic>> signUp({
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
    return fetch(
      call: () async {
        FormData formData = FormData.fromMap({
          'userName': userName,
          'name': name,
          'phoneNumber': phoneNumber,
          'email': email,
          'password': password,
          'sexType': sexType,
          'bloodType': bloodType,
          'dob': dob,
          'personalImageFile': personalImageFile != null
              ? FormData.fromMap(<String, dynamic>{
                  'file': await MultipartFile.fromFile(
                    personalImageFile.path,
                    filename: personalImageFile.name,
                    contentType: MediaType('image', 'png'),
                  ),
                })
              : null,
          'idPhotoFile': idPhotoFile != null
              ? FormData.fromMap(<String, dynamic>{
                  'file': await MultipartFile.fromFile(
                    idPhotoFile.path,
                    filename: idPhotoFile.name,
                    contentType: MediaType('image', 'png'),
                  ),
                })
              : null,
          'drivingCertificateFile': drivingCertificateFile != null
              ? FormData.fromMap(<String, dynamic>{
                  'file': await MultipartFile.fromFile(
                    drivingCertificateFile.path,
                    filename: drivingCertificateFile.name,
                    contentType: MediaType('image', 'png'),
                  ),
                })
              : null,
        });

        await _api.post(
          'api/DriverApp/SignUp',
          data: formData,
        );
        return 'Sent';
      },
    );
  }

  Future<Either<dynamic, DriverInfo>> login({
    required String username,
    required String password,
    required String deviceToken,
    bool rememberMe = true,
  }) async {
    return fetch(
      call: () async {
        final response = await _api.post(
          'api/DriverApp/SignIn',
          data: {
            'username': username,
            'password': password,
            'deviceToken': deviceToken,
            'rememberMe': rememberMe
          },
        );
        (json.encode(response.data)).log();
        return DriverInfo.fromJson(response.data);
      },
    );
  }

  Future<Either<dynamic, dynamic>> changeDeliveryStatue({
    required String id,
    required String statue,
  }) async {
    return fetch(
      call: () async {
        final response = await _api.put(
          'api/DriverApp/ChangeDeliveryStatue?id=$id&statue=$statue',
        );
        (json.encode(response.data)).log();
      },
    );
  }

  Future<Either<dynamic, dynamic>> endDelivery({
    required String id,
    required int payingValue,
  }) async {
    return fetch(
      call: () async {
        final response = await _api.put(
          'api/DriverApp/EndDelivery?id=$id&payingValue=$payingValue',
          // data: {'id': id, 'payingValue': payingValue},
        );
        (json.encode(response.data)).log();
      },
    );
  }
}
