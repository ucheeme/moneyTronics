// To parse this JSON data, do
//
//     final userAccount = userAccountFromJson(jsonString);

import 'dart:convert';

List<UserAccount> userAccountFromJson(String str) => List<UserAccount>.from(json.decode(str).map((x) => UserAccount.fromJson(x)));

String userAccountToJson(List<UserAccount> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserAccount {
  String? accountnumber;
  String? productName;
  double? balance;

  UserAccount({
     this.accountnumber,
     this.productName,
     this.balance,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
    accountnumber: json["accountnumber"],
    productName: json["productName"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "accountnumber": accountnumber,
    "productName": productName,
    "balance": balance,
  };
}
