// To parse this JSON data, do
//
//     final createExistingUserRequest = createExistingUserRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateExistingUserRequest createExistingUserRequestFromJson(String str) => CreateExistingUserRequest.fromJson(json.decode(str));

String createExistingUserRequestToJson(CreateExistingUserRequest data) => json.encode(data.toJson());

class CreateExistingUserRequest {
  String fullname;
  String accountnumber;
  String username;
  String email;
  String userpassword;
  String opTcode;
  String transactionPin;
  int secretQuestionId;
  String secretAnswer;
  String deviceId;
  String deviceModel;
  String deviceOs;
  String deviceName;
  String deviceType;

  CreateExistingUserRequest({
    required this.fullname,
    required this.accountnumber,
    required this.username,
    required this.email,
    required this.userpassword,
    required this.opTcode,
    required this.transactionPin,
    required this.secretQuestionId,
    required this.secretAnswer,
    required this.deviceId,
    required this.deviceModel,
    required this.deviceOs,
    required this.deviceName,
    required this.deviceType,
  });

  factory CreateExistingUserRequest.fromJson(Map<String, dynamic> json) => CreateExistingUserRequest(
    fullname: json["fullname"],
    accountnumber: json["accountnumber"],
    username: json["username"],
    email: json["email"],
    userpassword: json["userpassword"],
    opTcode: json["opTcode"],
    transactionPin: json["transactionPin"],
    secretQuestionId: json["secret_QuestionID"],
    secretAnswer: json["secret_Answer"],
    deviceId: json["deviceID"],
    deviceModel: json["deviceModel"],
    deviceOs: json["deviceOS"],
    deviceName: json["deviceName"],
    deviceType: json["deviceType"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "accountnumber": accountnumber,
    "username": username,
    "email": email,
    "userpassword": userpassword,
    "opTcode": opTcode,
    "transactionPin": transactionPin,
    "secret_QuestionID": secretQuestionId,
    "secret_Answer": secretAnswer,
    "deviceID": deviceId,
    "deviceModel": deviceModel,
    "deviceOS": deviceOs,
    "deviceName": deviceName,
    "deviceType": deviceType,
  };
}
