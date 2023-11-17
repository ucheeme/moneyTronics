// To parse this JSON data, do
//
//     final fixedDepositRequest = fixedDepositRequestFromJson(jsonString);
import 'dart:convert';
FixedDepositRequest fixedDepositRequestFromJson(String str) => FixedDepositRequest.fromJson(json.decode(str));
String fixedDepositRequestToJson(FixedDepositRequest data) => json.encode(data.toJson());

class FixedDepositRequest {
  int term;
  int rollOverMaturity;
  int rolloverOption;
  String purpose;
  double amount;
  String settlementAccount;
  String productCode;
  FixedDepositRequest({
    required this.term,
    required this.rollOverMaturity,
    required this.rolloverOption,
    required this.purpose,
    required this.amount,
    required this.settlementAccount,
    required this.productCode,
  });
  factory FixedDepositRequest.fromJson(Map<String, dynamic> json) => FixedDepositRequest(
    term: json["term"],
    rollOverMaturity: json["rollOverMaturity"],
    rolloverOption: json["rolloverOption"],
    purpose: json["purpose"],
    amount: json["amount"],
    settlementAccount: json["settlementAccount"],
    productCode: json["productCode"],
  );

  Map<String, dynamic> toJson() => {
    "term": term,
    "rollOverMaturity": rollOverMaturity,
    "rolloverOption": rolloverOption,
    "purpose": purpose,
    "amount": amount,
    "settlementAccount": settlementAccount,
    "productCode": productCode,
  };
}
