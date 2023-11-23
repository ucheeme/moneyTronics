
import 'dart:convert';
FixedDepositResponse fixedDepositResponseFromJson(String str) => FixedDepositResponse.fromJson(json.decode(str));
String fixedDepositResponseToJson(FixedDepositResponse data) => json.encode(data.toJson());

class FixedDepositResponse {

  int retval;
  String retmsg;
  String productName;
  String tenor;
  String tdAmount;
  String tdInterest;
  String tdTax;
  String refNo;

  FixedDepositResponse({
    required this.retval,
    required this.retmsg,
    required this.productName,
    required this.tenor,
    required this.tdAmount,
    required this.tdInterest,
    required this.tdTax,
    required this.refNo,
  });

  factory FixedDepositResponse.fromJson(Map<String, dynamic> json) => FixedDepositResponse(
    retval: json["retval"],
    retmsg: json["retmsg"],
    productName: json["productName"],
    tenor: json["tenor"],
    tdAmount: json["tdAmount"],
    tdInterest: json["tdInterest"],
    tdTax: json["tdTax"],
    refNo: json["refNo"],
  );

  Map<String, dynamic> toJson() => {
    "retval": retval,
    "retmsg": retmsg,
    "productName": productName,
    "tenor": tenor,
    "tdAmount": tdAmount,
    "tdInterest": tdInterest,
    "tdTax": tdTax,
    "refNo": refNo,
  };
}
