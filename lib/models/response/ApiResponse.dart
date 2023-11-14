import 'dart:convert';
ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));
String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());
class ApiResponse {
  bool? success;
  Result? result;

  ApiResponse({
    this.success,
    this.result,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    success: json["success"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result?.toJson(),
  };
}

class Result {
  String? responseCode;
  bool? success;
  String? message;
  Error? error;
  dynamic data;
  Token? token;
  Result({
    this.responseCode,
    this.success,
    this.message,
    this.error,
    this.data,
    this.token
  });
  factory Result.fromJson(Map<String, dynamic> json) => Result(
    responseCode: json["responseCode"],
    success: json["success"],
    message: json["message"],
    token: json["token"] == null ? null : Token.fromJson(json["token"]),
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
    data: json["data"],

  );
  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "success": success,
    "message": message,
    "error": error?.toJson(),
    "data": data?.toJson(),
    "token": token
  };
}

class Error {
  bool? isValid;
  List<dynamic>? validationMessages;

  Error({
    this.isValid,
    this.validationMessages,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    isValid: json["isValid"],
    validationMessages: json["validationMessages"] == null ? [] : List<dynamic>.from(json["validationMessages"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "isValid": isValid,
    "validationMessages": validationMessages == null ? [] : List<dynamic>.from(validationMessages!.map((x) => x)),
  };
}

class Token {
  String? accessToken;

  Token({
    this.accessToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
  };
}

