// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';
LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));
String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  String clientId;
  String clientSecret;
  String deviceId;
  String deviceModel;
  String deviceOs;
  String deviceName;
  String deviceType;

  LoginRequest({
    required this.clientId,
    required this.clientSecret,
    required this.deviceId,
    required this.deviceModel,
    required this.deviceOs,
    required this.deviceName,
    required this.deviceType,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    clientId: json["clientId"],
    clientSecret: json["clientSecret"],
    deviceId: json["deviceID"],
    deviceModel: json["deviceModel"],
    deviceOs: json["deviceOS"],
    deviceName: json["deviceName"],
    deviceType: json["deviceType"],
  );

  Map<String, dynamic> toJson() => {
    "clientId": clientId,
    "clientSecret": clientSecret,
    "deviceID": deviceId,
    "deviceModel": deviceModel,
    "deviceOS": deviceOs,
    "deviceName": deviceName,
    "deviceType": deviceType,
  };
}
