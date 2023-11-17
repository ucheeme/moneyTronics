// To parse this JSON data, do
//
//     final fdCalculatorRequest = fdCalculatorRequestFromJson(jsonString);

import 'dart:convert';

FdCalculatorRequest fdCalculatorRequestFromJson(String str) => FdCalculatorRequest.fromJson(json.decode(str));

String fdCalculatorRequestToJson(FdCalculatorRequest data) => json.encode(data.toJson());

class FdCalculatorRequest {
  double tdAmount;
  int duration;
  String productcode;

  FdCalculatorRequest({
    required this.tdAmount,
    required this.duration,
    required this.productcode,
  });

  factory FdCalculatorRequest.fromJson(Map<String, dynamic> json) => FdCalculatorRequest(
    tdAmount: json["tdAmount"],
    duration: json["duration"],
    productcode: json["productcode"],
  );

  Map<String, dynamic> toJson() => {
    "tdAmount": tdAmount,
    "duration": duration,
    "productcode": productcode,
  };
}
