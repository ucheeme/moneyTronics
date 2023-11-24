import 'dart:convert';

import 'ApiResponse.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? username;
  String? role;
  String? customerId;
  String? fullname;
  String? phoneNumber;
  String? email;
  String? details;
  String? registrationStatus;
  String? token;
  CustomerDocumentUpload? customerDocumentUpload;

  LoginResponse({
    this.username,
    this.role,
    this.customerId,
    this.fullname,
    this.phoneNumber,
    this.email,
    this.details,
    this.registrationStatus,
    this.token,
    this.customerDocumentUpload
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    username: json["username"],
    role: json["role"],
    customerId: json["customerId"],
    fullname: json["fullname"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    details: json["details"],
    registrationStatus: json["registrationStatus"],

  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "role": role,
    "customerId": customerId,
    "fullname": fullname,
    "phoneNumber": phoneNumber,
    "email": email,
    "details": details,
    "registrationStatus": registrationStatus,
  };


}
class LoginIncomplete{
  String message;
  String accessToken;
  LoginIncomplete(this.message, this.accessToken);
}