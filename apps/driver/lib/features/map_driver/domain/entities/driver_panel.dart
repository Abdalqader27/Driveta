// To parse this JSON data, do
//
//     final driverPanel = driverPanelFromJson(jsonString);

import 'dart:convert';

DriverPanel driverPanelFromJson(String str) =>
    DriverPanel.fromJson(json.decode(str));

String driverPanelToJson(DriverPanel data) => json.encode(data.toJson());

class DriverPanel {
  DriverPanel({
    required this.result,
    required this.isSuccess,
    required this.hasException,
    this.fullExceptionMessage,
    required this.hasCustomeStatusCode,
    this.message,
    required this.operationResultType,
    this.exception,
    this.statusCode,
  });

  Result result;
  bool isSuccess;
  bool hasException;
  dynamic fullExceptionMessage;
  bool hasCustomeStatusCode;
  dynamic message;
  int operationResultType;
  dynamic exception;
  dynamic statusCode;

  factory DriverPanel.fromJson(Map<String, dynamic> json) => DriverPanel(
        result: Result.fromJson(json["result"]),
        isSuccess: json["isSuccess"],
        hasException: json["hasException"],
        fullExceptionMessage: json["fullExceptionMessage"],
        hasCustomeStatusCode: json["hasCustomeStatusCode"],
        message: json["message"],
        operationResultType: json["operationResultType"],
        exception: json["exception"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "isSuccess": isSuccess,
        "hasException": hasException,
        "fullExceptionMessage": fullExceptionMessage,
        "hasCustomeStatusCode": hasCustomeStatusCode,
        "message": message,
        "operationResultType": operationResultType,
        "exception": exception,
        "statusCode": statusCode,
      };
}

class Result {
  Result({
    required this.revenues,
    required this.rateAvg,
    required this.deliveryCount,
  });

  int revenues;
  int rateAvg;
  int deliveryCount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        revenues: json["revenues"],
        rateAvg: json["rateAvg"],
        deliveryCount: json["deliveryCount"],
      );

  Map<String, dynamic> toJson() => {
        "revenues": revenues,
        "rateAvg": rateAvg,
        "deliveryCount": deliveryCount,
      };
}
