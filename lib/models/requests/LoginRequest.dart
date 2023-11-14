// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';
LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));
String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  String clientId;
  String clientSecret;

  LoginRequest({
    required this.clientId,
    required this.clientSecret,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    clientId: json["clientId"],
    clientSecret: json["clientSecret"],
  );

  Map<String, dynamic> toJson() => {
    "clientId": clientId,
    "clientSecret": clientSecret,
  };
}
