import 'dart:convert';
ForgotPasswordRequest forgotPasswordRequestFromJson(String str) => ForgotPasswordRequest.fromJson(json.decode(str));
String forgotPasswordRequestToJson(ForgotPasswordRequest data) => json.encode(data.toJson());

class ForgotPasswordRequest {
  String code;
  String username;
  String password;
  ForgotPasswordRequest({
    required this.code,
    required this.username,
    required this.password,
  });
  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) => ForgotPasswordRequest(
    code: json["code"],
    username: json["username"],
    password: json["password"],
  );
  Map<String, dynamic> toJson() => {
    "code": code,
    "username": username,
    "password": password,
  };
}
