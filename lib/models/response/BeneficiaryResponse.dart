// To parse this JSON data, do
//
//     final beneficiary = beneficiaryFromJson(jsonString);

import 'dart:convert';

List<Beneficiary> beneficiaryFromJson(String str) => List<Beneficiary>.from(json.decode(str).map((x) => Beneficiary.fromJson(x)));

String beneficiaryToJson(List<Beneficiary> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Beneficiary {
  String id;
  String accountholderFullname;
  String alias;
  String beneficiaryAccount;
  String beneficiaryBank;
  String beneficiaryBankcode;
  String beneficiaryFullName;
  String username;
  String status;
  String customerId;
  String createDate;

  Beneficiary({
    required this.id,
    required this.accountholderFullname,
    required this.alias,
    required this.beneficiaryAccount,
    required this.beneficiaryBank,
    required this.beneficiaryBankcode,
    required this.beneficiaryFullName,
    required this.username,
    required this.status,
    required this.customerId,
    required this.createDate,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
    id: json["id"],
    accountholderFullname: json["accountholderFullname"],
    alias: json["alias"],
    beneficiaryAccount: json["beneficiaryAccount"],
    beneficiaryBank: json["beneficiaryBank"],
    beneficiaryBankcode: json["beneficiaryBankcode"],
    beneficiaryFullName: json["beneficiaryFullName"],
    username: json["username"],
    status: json["status"],
    customerId: json["customerId"],
    createDate: json["createDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accountholderFullname": accountholderFullname,
    "alias": alias,
    "beneficiaryAccount": beneficiaryAccount,
    "beneficiaryBank": beneficiaryBank,
    "beneficiaryBankcode": beneficiaryBankcode,
    "beneficiaryFullName": beneficiaryFullName,
    "username": username,
    "status": status,
    "customerId": customerId,
    "createDate": createDate,
  };
}
