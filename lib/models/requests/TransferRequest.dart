// To parse this JSON data, do
//
//     final transferRequest = transferRequestFromJson(jsonString);

import 'dart:convert';

TransferRequest transferRequestFromJson(String str) => TransferRequest.fromJson(json.decode(str));

String transferRequestToJson(TransferRequest data) => json.encode(data.toJson());

class TransferRequest {
  String debitAcct;
  String creditAcct;
  String creditAcctName;
  String benificiaryBank;
  String bankCode;
  double payamount;
  String narration1;
  String transType;
  String transactionPin;
  String otpCode;
  String sg;

  TransferRequest({
    required this.debitAcct,
    required this.creditAcct,
    required this.creditAcctName,
    required this.benificiaryBank,
    required this.bankCode,
    required this.payamount,
    required this.narration1,
    required this.transType,
    required this.transactionPin,
    required this.otpCode,
    required this.sg,
  });

  factory TransferRequest.fromJson(Map<String, dynamic> json) => TransferRequest(
    debitAcct: json["debitAcct"],
    creditAcct: json["creditAcct"],
    creditAcctName: json["creditAcctName"],
    benificiaryBank: json["benificiaryBank"],
    bankCode: json["bankCode"],
    payamount: json["payamount"],
    narration1: json["narration1"],
    transType: json["trans_Type"],
    transactionPin: json["transactionPin"],
    otpCode: json["otpCode"],
    sg: json["sg"],
  );

  Map<String, dynamic> toJson() => {
    "debitAcct": debitAcct,
    "creditAcct": creditAcct,
    "creditAcctName": creditAcctName,
    "benificiaryBank": benificiaryBank,
    "bankCode": bankCode,
    "payamount": payamount,
    "narration1": narration1,
    "trans_Type": transType,
    "transactionPin": transactionPin,
    "otpCode": otpCode,
    "sg": sg,
  };
}
