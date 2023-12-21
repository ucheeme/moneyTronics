// To parse this JSON data, do
//
//     final fixedDepositSummaryResponse = fixedDepositSummaryResponseFromJson(jsonString);

import 'dart:convert';

FixedDepositSummaryResponse fixedDepositSummaryResponseFromJson(String str) => FixedDepositSummaryResponse.fromJson(json.decode(str));

String fixedDepositSummaryResponseToJson(FixedDepositSummaryResponse data) => json.encode(data.toJson());

class FixedDepositSummaryResponse {
  String investmentAmount;
  String startDate;
  String interestAccrued;
  String taxAmount;
  String penalCharge;
  String amountDue;
  int retval;

  FixedDepositSummaryResponse({
    required this.investmentAmount,
    required this.startDate,
    required this.interestAccrued,
    required this.taxAmount,
    required this.penalCharge,
    required this.amountDue,
    required this.retval,
  });

  factory FixedDepositSummaryResponse.fromJson(Map<String, dynamic> json) => FixedDepositSummaryResponse(
    investmentAmount: json["investmentAmount"],
    startDate: json["startDate"],
    interestAccrued: json["interestAccrued"],
    taxAmount: json["taxAmount"],
    penalCharge: json["penalCharge"],
    amountDue: json["amountDue"],
    retval: json["retval"],
  );

  Map<String, dynamic> toJson() => {
    "investmentAmount": investmentAmount,
    "startDate": startDate,
    "interestAccrued": interestAccrued,
    "taxAmount": taxAmount,
    "penalCharge": penalCharge,
    "amountDue": amountDue,
    "retval": retval,
  };
}
