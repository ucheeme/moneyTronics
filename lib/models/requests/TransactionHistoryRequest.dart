// To parse this JSON data, do
//
//     final transactionHistoryRequest = transactionHistoryRequestFromJson(jsonString);

import 'dart:convert';

TransactionHistoryRequest transactionHistoryRequestFromJson(String str) => TransactionHistoryRequest.fromJson(json.decode(str));

String transactionHistoryRequestToJson(TransactionHistoryRequest data) => json.encode(data.toJson());

class TransactionHistoryRequest {
  String row;
  String accountNumber;

  TransactionHistoryRequest({
    required this.row,
    required this.accountNumber,
  });

  factory TransactionHistoryRequest.fromJson(Map<String, dynamic> json) => TransactionHistoryRequest(
    row: json["Row"],
    accountNumber: json["AccountNumber"],
  );

  Map<String, dynamic> toJson() => {
    "Row": row,
    "AccountNumber": accountNumber,
  };
}
