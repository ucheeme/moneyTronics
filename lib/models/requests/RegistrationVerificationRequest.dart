// To parse this JSON data, do
//
//     final regVerificationRequest = regVerificationRequestFromJson(jsonString);

import 'dart:convert';

RegVerificationRequest regVerificationRequestFromJson(String str) => RegVerificationRequest.fromJson(json.decode(str));

String regVerificationRequestToJson(RegVerificationRequest data) => json.encode(data.toJson());

class RegVerificationRequest {
  String username;
  String otpCode;

  RegVerificationRequest({
    required this.username,
    required this.otpCode,
  });

  factory RegVerificationRequest.fromJson(Map<String, dynamic> json) => RegVerificationRequest(
    username: json["username"],
    otpCode: json["otpCode"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "otpCode": otpCode,
  };
}
