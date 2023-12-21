// To parse this JSON data, do
//
//     final vendSecRequest = vendSecRequestFromJson(jsonString);

import 'dart:convert';

VendSecRequest vendSecRequestFromJson(String str) => VendSecRequest.fromJson(json.decode(str));

String vendSecRequestToJson(VendSecRequest data) => json.encode(data.toJson());

class VendSecRequest {
  String accountNumber;
  String amountPaid;
  String channel;
  String customerName;
  String phoneNumber;
  String email;
  String transactionPin;
  String otpCode;
  String customerId;
  String packageSlug;

  VendSecRequest({
    required this.accountNumber,
    required this.amountPaid,
    required this.channel,
    required this.customerName,
    required this.phoneNumber,
    required this.email,
    required this.transactionPin,
    required this.otpCode,
    required this.customerId,
    required this.packageSlug,
  });

  factory VendSecRequest.fromJson(Map<String, dynamic> json) => VendSecRequest(
    accountNumber: json["a_N"],
    amountPaid: json["a_P"],
    channel: json["c_H"],
    customerName: json["c_N"],
    phoneNumber: json["p_N"],
    email: json["e_L"],
    transactionPin: json["t_P"],
    otpCode: json["o_C"],
    customerId: json["c_Id"],
    packageSlug: json["p_S"],
  );

  Map<String, dynamic> toJson() => {
    "a_N": accountNumber,
    "a_P": amountPaid,
    "c_H": channel,
    "c_N": customerName,
    "p_N": phoneNumber,
    "e_L": email,
    "t_P": transactionPin,
    "o_C": otpCode,
    "c_Id": customerId,
    "p_S": packageSlug,
  };
}
