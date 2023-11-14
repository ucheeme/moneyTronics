// To parse this JSON data, do
//
//     final accountNumberResponse = accountNumberResponseFromJson(jsonString);

import 'dart:convert';


AccountNumberResponse accountNumberResponseFromJson(String str) => AccountNumberResponse.fromJson(json.decode(str));

String accountNumberResponseToJson(AccountNumberResponse data) => json.encode(data.toJson());

class AccountNumberResponse {
  String? accountNumber;
  int? retval;
  String? customerId;

  AccountNumberResponse({
    this.accountNumber,
    this.retval,
    this.customerId,
  });

  factory AccountNumberResponse.fromJson(Map<String, dynamic> json) => AccountNumberResponse(
    accountNumber: json["accountNumber"],
    retval: json["retval"],
    customerId: json["customerId"],
  );

  Map<String, dynamic> toJson() => {
    "accountNumber": accountNumber,
    "retval": retval,
    "customerId": customerId,
  };
}
