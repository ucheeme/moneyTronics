
import 'dart:convert';
ForgotPasswordOtpResponse forgotPasswordOtpResponseFromJson(String str) => ForgotPasswordOtpResponse.fromJson(json.decode(str));
String forgotPasswordOtpResponseToJson(ForgotPasswordOtpResponse data) => json.encode(data.toJson());

class ForgotPasswordOtpResponse {
  String? username;
  String? email;
  String? code;
  int? retval;
  ForgotPasswordOtpResponse({
    this.username,
    this.email,
    this.code,
    this.retval,
  });
  factory ForgotPasswordOtpResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordOtpResponse(
    username: json["username"],
    email: json["email"],
    code: json["code"],
    retval: json["retval"],
  );
  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "code": code,
    "retval": retval,
  };
}
