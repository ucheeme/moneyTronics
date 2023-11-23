// To parse this JSON data, do
//
//     final billMakeBillsPaymentResponse = billMakeBillsPaymentResponseFromJson(jsonString);

import 'dart:convert';

BillMakeBillsPaymentResponse billMakeBillsPaymentResponseFromJson(String str) => BillMakeBillsPaymentResponse.fromJson(json.decode(str));

String billMakeBillsPaymentResponseToJson(BillMakeBillsPaymentResponse data) => json.encode(data.toJson());

class BillMakeBillsPaymentResponse {
  String? packageName;
  bool? paid;
  String? kct1;
  String? kct2;
  String? paymentReference;
  String? vendStatus;
  String? narration;
  String? statusCode;
  int? amount;
  int? convenienceFee;
  String? customerMessage;

  BillMakeBillsPaymentResponse({
    this.packageName,
    this.paid,
    this.kct1,
    this.kct2,
    this.paymentReference,
    this.vendStatus,
    this.narration,
    this.statusCode,
    this.amount,
    this.convenienceFee,
    this.customerMessage,
  });

  factory BillMakeBillsPaymentResponse.fromJson(Map<String, dynamic> json) => BillMakeBillsPaymentResponse(
    packageName: json["packageName"],
    paid: json["paid"],
    kct1: json["kct1"],
    kct2: json["kct2"],
    paymentReference: json["paymentReference"],
    vendStatus: json["vendStatus"],
    narration: json["narration"],
    statusCode: json["statusCode"],
    amount: json["amount"],
    convenienceFee: json["convenienceFee"],
    customerMessage: json["customerMessage"],
  );

  Map<String, dynamic> toJson() => {
    "packageName": packageName,
    "paid": paid,
    "kct1": kct1,
    "kct2": kct2,
    "paymentReference": paymentReference,
    "vendStatus": vendStatus,
    "narration": narration,
    "statusCode": statusCode,
    "amount": amount,
    "convenienceFee": convenienceFee,
    "customerMessage": customerMessage,
  };
}
