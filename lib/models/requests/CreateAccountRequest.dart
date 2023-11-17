// To parse this JSON data, do
//
//     final createAccountRequest = createAccountRequestFromJson(jsonString);

import 'dart:convert';

CreateAccountRequest createAccountRequestFromJson(String str) => CreateAccountRequest.fromJson(json.decode(str));

String createAccountRequestToJson(CreateAccountRequest data) => json.encode(data.toJson());

class CreateAccountRequest {
  String username;
  String password;
  String confirmPassword;
  String phoneNumber;
  String surname;
  String firstname;
  String othername;
  String email;
  String bvn;
  String gender;
  String referral;
  String title;
  String deviceId;
  String deviceModel;
  String deviceOs;
  String deviceName;
  String deviceType;

  CreateAccountRequest({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.surname,
    required this.firstname,
    required this.othername,
    required this.email,
    required this.bvn,
    required this.gender,
    required this.referral,
    required this.title,
    required this.deviceId,
    required this.deviceModel,
    required this.deviceOs,
    required this.deviceName,
    required this.deviceType,
  });

  factory CreateAccountRequest.fromJson(Map<String, dynamic> json) => CreateAccountRequest(
    username: json["username"],
    password: json["password"],
    confirmPassword: json["confirmPassword"],
    phoneNumber: json["phoneNumber"],
    surname: json["surname"],
    firstname: json["firstname"],
    othername: json["othername"],
    email: json["email"],
    bvn: json["bvn"],
    gender: json["gender"],
    referral: json["referral"],
    title: json["title"],
    deviceId: json["deviceID"],
    deviceModel: json["deviceModel"],
    deviceOs: json["deviceOS"],
    deviceName: json["deviceName"],
    deviceType: json["deviceType"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "confirmPassword": confirmPassword,
    "phoneNumber": phoneNumber,
    "surname": surname,
    "firstname": firstname,
    "othername": othername,
    "email": email,
    "bvn": bvn,
    "gender": gender,
    "referral": referral,
    "title": title,
    "deviceID": deviceId,
    "deviceModel": deviceModel,
    "deviceOS": deviceOs,
    "deviceName": deviceName,
    "deviceType": deviceType,
  };
}
