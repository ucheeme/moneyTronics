
import 'dart:convert';

ApiResponse2 apiResponse2FromJson(String str) => ApiResponse2.fromJson(json.decode(str));

String apiResponse2ToJson(ApiResponse2 data) => json.encode(data.toJson());

class ApiResponse2 {
  bool? success;
  Result? result;

  ApiResponse2({
    this.success,
    this.result,
  });

  factory ApiResponse2.fromJson(Map<String, dynamic> json) => ApiResponse2(
    success: json["success"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result?.toJson(),
  };
}

class Result {
  int? statusCode;
  bool? error;
  String? status;
  String? message;
  bool? success;
  String? responseCode;
  dynamic responseData;

  Result({
    this.statusCode,
    this.error,
    this.status,
    this.message,
    this.success,
    this.responseCode,
    this.responseData,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    statusCode: json["statusCode"],
    error: json["error"],
    status: json["status"],
    message: json["message"],
    success: json["success"],
    responseCode: json["responseCode"],
    responseData: json["responseData"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "error": error,
    "status": status,
    "message": message,
    "success": success,
    "responseCode": responseCode,
    "responseData": responseData,
  };
}
