// To parse this JSON data, do
//
//     final networkPlansResponse = networkPlansResponseFromJson(jsonString);

import 'dart:convert';

NetworkPlansResponse networkPlansResponseFromJson(String str) => NetworkPlansResponse.fromJson(json.decode(str));

String networkPlansResponseToJson(NetworkPlansResponse data) => json.encode(data.toJson());

class NetworkPlansResponse{
  bool? success;
  int? statusCode;
  String? message;
  bool? requestSuccessful;
  int? executionTime;
  ApiErrors? apiErrors;
  ApiWarnings? apiWarnings;
  String? requestedCommand;
  ResponseEntity? responseEntity;

  NetworkPlansResponse({
    this.success,
    this.statusCode,
    this.message,
    this.requestSuccessful,
    this.executionTime,
    this.apiErrors,
    this.apiWarnings,
    this.requestedCommand,
    this.responseEntity,
  });

  factory NetworkPlansResponse.fromJson(Map<String, dynamic> json) => NetworkPlansResponse(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    requestSuccessful: json["requestSuccessful"],
    executionTime: json["executionTime"],
    apiErrors: json["apiErrors"] == null ? null : ApiErrors.fromJson(json["apiErrors"]),
    apiWarnings: json["apiWarnings"] == null ? null : ApiWarnings.fromJson(json["apiWarnings"]),
    requestedCommand: json["requestedCommand"],
    responseEntity: json["responseEntity"] == null ? null : ResponseEntity.fromJson(json["responseEntity"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "statusCode": statusCode,
    "message": message,
    "requestSuccessful": requestSuccessful,
    "executionTime": executionTime,
    "apiErrors": apiErrors?.toJson(),
    "apiWarnings": apiWarnings?.toJson(),
    "requestedCommand": requestedCommand,
    "responseEntity": responseEntity?.toJson(),
  };
}

class ApiErrors {
  int? errorCount;
  List<dynamic>? apiErrorList;

  ApiErrors({
    this.errorCount,
    this.apiErrorList,
  });

  factory ApiErrors.fromJson(Map<String, dynamic> json) => ApiErrors(
    errorCount: json["errorCount"],
    apiErrorList: json["apiErrorList"] == null ? [] : List<dynamic>.from(json["apiErrorList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "errorCount": errorCount,
    "apiErrorList": apiErrorList == null ? [] : List<dynamic>.from(apiErrorList!.map((x) => x)),
  };
}

class ApiWarnings {
  int? warningCount;
  List<dynamic>? apiWarningList;

  ApiWarnings({
    this.warningCount,
    this.apiWarningList,
  });

  factory ApiWarnings.fromJson(Map<String, dynamic> json) => ApiWarnings(
    warningCount: json["warningCount"],
    apiWarningList: json["apiWarningList"] == null ? [] : List<dynamic>.from(json["apiWarningList"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "warningCount": warningCount,
    "apiWarningList": apiWarningList == null ? [] : List<dynamic>.from(apiWarningList!.map((x) => x)),
  };
}

class ResponseEntity {
  Headers? headers;
  Body? body;
  String? statusCode;
  int? statusCodeValue;

  ResponseEntity({
    this.headers,
    this.body,
    this.statusCode,
    this.statusCodeValue,
  });

  factory ResponseEntity.fromJson(Map<String, dynamic> json) => ResponseEntity(
    headers: json["headers"] == null ? null : Headers.fromJson(json["headers"]),
    body: json["body"] == null ? null : Body.fromJson(json["body"]),
    statusCode: json["statusCode"],
    statusCodeValue: json["statusCodeValue"],
  );

  Map<String, dynamic> toJson() => {
    "headers": headers?.toJson(),
    "body": body?.toJson(),
    "statusCode": statusCode,
    "statusCodeValue": statusCodeValue,
  };
}

class Body {
  int? serviceCount;
  List<SubscribedService>? subscribedServices;

  Body({
    this.serviceCount,
    this.subscribedServices,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    serviceCount: json["serviceCount"],
    subscribedServices: json["subscribedServices"] == null ? [] : List<SubscribedService>.from(json["subscribedServices"]!.map((x) => SubscribedService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "serviceCount": serviceCount,
    "subscribedServices": subscribedServices == null ? [] : List<dynamic>.from(subscribedServices!.map((x) => x.toJson())),
  };
}

class SubscribedService {
  String? name;
  String? vendCode;
  bool? usesPreset;
  List<PresetAmountList>? presetAmountList;
  int? presetCount;

  SubscribedService({
    this.name,
    this.vendCode,
    this.usesPreset,
    this.presetAmountList,
    this.presetCount,
  });

  factory SubscribedService.fromJson(Map<String, dynamic> json) => SubscribedService(
    name: json["name"],
    vendCode: json["vendCode"],
    usesPreset: json["usesPreset"],
    presetAmountList: json["presetAmountList"] == null ? [] : List<PresetAmountList>.from(json["presetAmountList"]!.map((x) => PresetAmountList.fromJson(x))),
    presetCount: json["presetCount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "vendCode": vendCode,
    "usesPreset": usesPreset,
    "presetAmountList": presetAmountList == null ? [] : List<dynamic>.from(presetAmountList!.map((x) => x.toJson())),
    "presetCount": presetCount,
  };
}

class PresetAmountList {
  String? subCode;
  String? description;
  double? amount;

  PresetAmountList({
    this.subCode,
    this.description,
    this.amount,
  });

  factory PresetAmountList.fromJson(Map<String, dynamic> json) => PresetAmountList(
    subCode: json["subCode"],
    description: json["description"],
    amount: json["amount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "subCode": subCode,
    "description": description,
    "amount": amount,
  };
}

class Headers {
  Headers();

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
  );

  Map<String, dynamic> toJson() => {
  };
}
