
import 'dart:convert';

BillMakeBillsPaymentRequest billMakeBillsPaymentRequestFromJson(String str) => BillMakeBillsPaymentRequest.fromJson(json.decode(str));

String billMakeBillsPaymentRequestToJson(BillMakeBillsPaymentRequest data) => json.encode(data.toJson());

class BillMakeBillsPaymentRequest {
  String customerId;
  String packageSlug;
  String channel;
  String customerName;
  String phoneNumber;
  String email;
  String accountNumber;
  double amount;
  String transactionPin;
  String otpCode;

  BillMakeBillsPaymentRequest({
    required this.customerId,
    required this.packageSlug,
    required this.channel,
    required this.customerName,
    required this.phoneNumber,
    required this.email,
    required this.accountNumber,
    required this.amount,
    required this.transactionPin,
    required this.otpCode,
  });

  factory BillMakeBillsPaymentRequest.fromJson(Map<String, dynamic> json) => BillMakeBillsPaymentRequest(
    customerId: json["customerId"],
    packageSlug: json["packageSlug"],
    channel: json["channel"],
    customerName: json["customerName"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    accountNumber: json["accountNumber"],
    amount: json["amount"],
    transactionPin: json["transactionPin"],
    otpCode: json["otpCode"],
  );

  Map<String, dynamic> toJson() => {
    "customerId": customerId,
    "packageSlug": packageSlug,
    "channel": channel,
    "customerName": customerName,
    "phoneNumber": phoneNumber,
    "email": email,
    "accountNumber": accountNumber,
    "amount": amount,
    "transactionPin": transactionPin,
    "otpCode": otpCode,
  };
}
