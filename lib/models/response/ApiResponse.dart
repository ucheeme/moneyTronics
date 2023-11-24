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


List<String> validationMessageFromJson(String str) => List<String>.from(json.decode(str).map((x) => x));

String validationMessageToJson(List<String> data) => json.encode(List<String>.from(data.map((x) => x)));

class Result {
  String? responseCode;
  bool? success;
  String? message;
  dynamic error;
  dynamic data;
  dynamic otherBanks;
  Token? token;
  CustomerDocumentUpload? customerDocumentUpload;

  Result({
    this.responseCode,
    this.success,
    this.message,
    this.error,
    this.data,
    this.token,
    this.otherBanks,
    this.customerDocumentUpload
  });
  factory Result.fromJson(Map<String, dynamic> json) => Result(
    responseCode: json["responseCode"],
    success: json["success"],
    message: json["message"],
    token: json["token"] == null ? null : Token.fromJson(json["token"]),
    //error: json["error"] == null ? null : Error.fromJson(json["error"]),
    error: json["error"],
    data: json["data"],
    otherBanks: json["otherBanks"],
    customerDocumentUpload: json["customerDocumentUpload"] == null ? null : CustomerDocumentUpload.fromJson(json["customerDocumentUpload"]),
  );
  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "success": success,
    "message": message,
    "error": error?.toJson(),
    "data": data?.toJson(),
    "token": token,
    "customerDocumentUpload": customerDocumentUpload?.toJson(),
    "otherBanks": otherBanks
  };
}

// To parse this JSON data, do
//
//     final apiError = apiErrorFromJson(jsonString);



ApiError apiErrorFromJson(String str) => ApiError.fromJson(json.decode(str));

String apiErrorToJson(ApiError data) => json.encode(data.toJson());

class ApiError {
  bool? isValid;
  List<String>? validationMessages;

  ApiError({
    this.isValid,
    this.validationMessages,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
    isValid: json["isValid"],
    validationMessages: json["validationMessages"] == null ? [] : List<String>.from(json["validationMessages"]!.map((x) => x)),
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

class UploadedDocument {
  String customerId;
  String documentName;
  String username;
  String status;
  int docId;

  UploadedDocument({
    required this.customerId,
    required this.documentName,
    required this.username,
    required this.status,
    required this.docId,
  });

  factory UploadedDocument.fromJson(Map<String, dynamic> json) => UploadedDocument(
    customerId: json["customerID"],
    documentName: json["documentName"],
    username: json["username"],
    status: json["status"],
    docId: json["docId"],
  );

  Map<String, dynamic> toJson() => {
    "customerID": customerId,
    "documentName": documentName,
    "username": username,
    "status": status,
    "docId": docId,
  };
}

class CustomerDocumentUpload {
  List<UploadedDocument> uploadedDocument;

  CustomerDocumentUpload({
    required this.uploadedDocument,
  });

  factory CustomerDocumentUpload.fromJson(Map<String, dynamic> json) => CustomerDocumentUpload(
    uploadedDocument: List<UploadedDocument>.from(json["uploadedDocument"].map((x) => UploadedDocument.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uploadedDocument": List<dynamic>.from(uploadedDocument.map((x) => x.toJson())),
  };
}
