// To parse this JSON data, do
//
//     final fixedDepositLiquidationRequest = fixedDepositLiquidationRequestFromJson(jsonString);

import 'dart:convert';

FixedDepositLiquidationRequest fixedDepositLiquidationRequestFromJson(String str) => FixedDepositLiquidationRequest.fromJson(json.decode(str));

String fixedDepositLiquidationRequestToJson(FixedDepositLiquidationRequest data) => json.encode(data.toJson());

class FixedDepositLiquidationRequest {
  String accountnumber;
  String settlementAccount;

  FixedDepositLiquidationRequest({
    required this.accountnumber,
    required this.settlementAccount,
  });

  factory FixedDepositLiquidationRequest.fromJson(Map<String, dynamic> json) => FixedDepositLiquidationRequest(
    accountnumber: json["accountnumber"],
    settlementAccount: json["settlementAccount"],
  );

  Map<String, dynamic> toJson() => {
    "accountnumber": accountnumber,
    "settlementAccount": settlementAccount,
  };
}
