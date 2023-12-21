// To parse this JSON data, do
//
//     final validateExistingUserAccountResponse = validateExistingUserAccountResponseFromJson(jsonString);

import 'dart:convert';

ValidateExistingUserAccountResponse validateExistingUserAccountResponseFromJson(String str) => ValidateExistingUserAccountResponse.fromJson(json.decode(str));

String validateExistingUserAccountResponseToJson(ValidateExistingUserAccountResponse data) => json.encode(data.toJson());

class ValidateExistingUserAccountResponse {
  int? retval;
  String? fullname;
  String? accountnumber;
  String? phoneNumber;
  String? customerId;

  ValidateExistingUserAccountResponse({
    this.retval,
    this.fullname,
    this.accountnumber,
    this.phoneNumber,
    this.customerId,
  });

  factory ValidateExistingUserAccountResponse.fromJson(Map<String, dynamic> json) => ValidateExistingUserAccountResponse(
    retval: json["retval"],
    fullname: json["fullname"],
    accountnumber: json["accountnumber"],
    phoneNumber: json["phoneNumber"],
    customerId: json["customerId"],
  );

  Map<String, dynamic> toJson() => {
    "retval": retval,
    "fullname": fullname,
    "accountnumber": accountnumber,
    "phoneNumber": phoneNumber,
    "customerId": customerId,
  };
}
