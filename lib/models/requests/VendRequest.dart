// To parse this JSON data, do
//
//     final vendRequest = vendRequestFromJson(jsonString);

import 'dart:convert';

VendRequest vendRequestFromJson(String str) => VendRequest.fromJson(json.decode(str));

String vendRequestToJson(VendRequest data) => json.encode(data.toJson());

class VendRequest {
  String accountNumber;
  double amountPaid;
  String phoneNumber;
  String transactionDate;
  String networkProvider;
  String vendingCode;
  String subCode;
  String transactionPin;
  bool usesPreset;
  String bsig;
  String otpCode;

  VendRequest({
    required this.accountNumber,
    required this.amountPaid,
    required this.phoneNumber,
    required this.transactionDate,
    required this.networkProvider,
    required this.vendingCode,
    required this.subCode,
    required this.transactionPin,
    required this.usesPreset,
    required this.bsig,
    required this.otpCode,
  });

  factory VendRequest.fromJson(Map<String, dynamic> json) => VendRequest(
    accountNumber: json["accountNumber"],
    amountPaid: json["amountPaid"],
    phoneNumber: json["phoneNumber"],
    transactionDate: json["transactionDate"],
    networkProvider: json["networkProvider"],
    vendingCode: json["vendingCode"],
    subCode: json["subCode"],
    transactionPin: json["transactionPin"],
    usesPreset: json["usesPreset"],
    bsig: json["bsig"],
    otpCode: json["otpCode"],
  );

  Map<String, dynamic> toJson() => {
    "accountNumber": accountNumber,
    "amountPaid": amountPaid,
    "phoneNumber": phoneNumber,
    "transactionDate": transactionDate,
    "networkProvider": networkProvider,
    "vendingCode": vendingCode,
    "subCode": subCode,
    "transactionPin": transactionPin,
    "usesPreset": usesPreset,
    "bsig": bsig,
    "otpCode": otpCode,
  };
}
