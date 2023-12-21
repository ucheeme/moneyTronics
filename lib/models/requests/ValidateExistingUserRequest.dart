// To parse this JSON data, do
//
//     final validateExistingUserRequest = validateExistingUserRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ValidateExistingUserRequest validateExistingUserRequestFromJson(String str) => ValidateExistingUserRequest.fromJson(json.decode(str));

String validateExistingUserRequestToJson(ValidateExistingUserRequest data) => json.encode(data.toJson());

class ValidateExistingUserRequest {
  String bvn;
  String accountNumber;
  String referral;

  ValidateExistingUserRequest({
    required this.bvn,
    required this.accountNumber,
    required this.referral,
  });

  factory ValidateExistingUserRequest.fromJson(Map<String, dynamic> json) => ValidateExistingUserRequest(
    bvn: json["bvn"],
    accountNumber: json["accountNumber"],
    referral: json["referral"],
  );

  Map<String, dynamic> toJson() => {
    "bvn": bvn,
    "accountNumber": accountNumber,
    "referral": referral,
  };
}
