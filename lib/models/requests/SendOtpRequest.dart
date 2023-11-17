// To parse this JSON data, do
//
//     final sendOtpRequest = sendOtpRequestFromJson(jsonString);

import 'dart:convert';

SendOtpRequest sendOtpRequestFromJson(String str) => SendOtpRequest.fromJson(json.decode(str));

String sendOtpRequestToJson(SendOtpRequest data) => json.encode(data.toJson());

class SendOtpRequest {
  String phoneOrAccountnumber;
  String email;

  SendOtpRequest({
    required this.phoneOrAccountnumber,
    required this.email,
  });

  factory SendOtpRequest.fromJson(Map<String, dynamic> json) => SendOtpRequest(
    phoneOrAccountnumber: json["phoneOrAccountnumber"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "phoneOrAccountnumber": phoneOrAccountnumber,
    "email": email,
  };
}
