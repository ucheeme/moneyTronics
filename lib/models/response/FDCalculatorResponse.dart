// To parse this JSON data, do
//
//     final fdCalculatorResponse = fdCalculatorResponseFromJson(jsonString);

import 'dart:convert';

FdCalculatorResponse fdCalculatorResponseFromJson(String str) => FdCalculatorResponse.fromJson(json.decode(str));

String fdCalculatorResponseToJson(FdCalculatorResponse data) => json.encode(data.toJson());

class FdCalculatorResponse {
  int? retVal;
  String? tdAmount;
  String? intRate;
  String? duration;
  String? startDate;
  String? totalInterest;
  String? taxAmount;
  String? matureAmount;

  FdCalculatorResponse({
    this.retVal,
    this.tdAmount,
    this.intRate,
    this.duration,
    this.startDate,
    this.totalInterest,
    this.taxAmount,
    this.matureAmount,
  });

  factory FdCalculatorResponse.fromJson(Map<String, dynamic> json) => FdCalculatorResponse(
    retVal: json["retVal"],
    tdAmount: json["tdAmount"],
    intRate: json["intRate"],
    duration: json["duration"],
    startDate: json["startDate"],
    totalInterest: json["totalInterest"],
    taxAmount: json["taxAmount"],
    matureAmount: json["matureAmount"],
  );

  Map<String, dynamic> toJson() => {
    "retVal": retVal,
    "tdAmount": tdAmount,
    "intRate": intRate,
    "duration": duration,
    "startDate": startDate,
    "totalInterest": totalInterest,
    "taxAmount": taxAmount,
    "matureAmount": matureAmount,
  };
}
