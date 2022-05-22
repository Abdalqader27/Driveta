import 'dart:convert';import 'package:core/core.dart';import 'package:either_dart/either.dart';import 'package:network/network.dart';import '../../../../common/utils/helper_method.dart';class HistoryApi {  HistoryApi({required SHttpClient api}) : _api = api;  final SHttpClient _api;  Future<Either<SResponseException, dynamic>> getHistories() {    return fetch(call: () async {      final response = await _api.get<dynamic>(        'api/DriverApp/GetDeliveries',      );      (json.encode(response.data)).log();      // return DriverProfile.fromJson(response.data);    });  }}