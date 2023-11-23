// To parse this JSON data, do
//
//     final transactionHistoryResponse = transactionHistoryResponseFromJson(jsonString);

import 'dart:convert';

List<TransactionHistoryResponse> transactionHistoryResponseFromJson(String str) => List<TransactionHistoryResponse>.from(json.decode(str).map((x) => TransactionHistoryResponse.fromJson(x)));

String transactionHistoryResponseToJson(List<TransactionHistoryResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionHistoryResponse {
  String? accountNo;
  String? beneficiaryAccount;
  String? beneficiaryName;
  String? amount;
  String? trandate;
  String? narration;
  String? requestId;
  String? accountHolderName;
  String? destinationBank;
  String? email;
  String? phonenumber;
  String? category;
  String? customerPhoneNumber;

  TransactionHistoryResponse({
    this.accountNo,
    this.beneficiaryAccount,
    this.beneficiaryName,
    this.amount,
    this.trandate,
    this.narration,
    this.requestId,
    this.accountHolderName,
    this.email,
    this.phonenumber,
    this.category,
    this.customerPhoneNumber,
    this.destinationBank,
  });

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) => TransactionHistoryResponse(
    accountNo: json["accountNo"],
    beneficiaryAccount: json["beneficiaryAccount"],
    beneficiaryName: json["beneficiaryName"],
    amount: json["amount"],
    trandate: json["trandate"],
    narration: json["narration"],
    requestId: json["request_ID"],
    accountHolderName: json["accountHolderName"],
    email: json["email"],
    phonenumber: json["phonenumber"],
    category: json["category"],
    customerPhoneNumber: json["customerPhoneNumber"],
    destinationBank: json["destinationBank"],
  );

  Map<String, dynamic> toJson() => {
    "accountNo": accountNo,
    "beneficiaryAccount": beneficiaryAccount,
    "beneficiaryName": beneficiaryName,
    "amount": amount,
    "trandate": trandate,
    "narration": narration,
    "request_ID": requestId,
    "accountHolderName": accountHolderName,
    "email": email,
    "phonenumber": phonenumber,
    "category": category,
    "customerPhoneNumber": customerPhoneNumber,
  };
}
