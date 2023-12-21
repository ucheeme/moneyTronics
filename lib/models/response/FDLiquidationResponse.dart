import 'dart:convert';

FdLiquidationResponse fdLiquidationResponseFromJson(String str) => FdLiquidationResponse.fromJson(json.decode(str));
String fdLiquidationResponseToJson(FdLiquidationResponse data) => json.encode(data.toJson());

class FdLiquidationResponse {
  int retval;
  String retmsg;
  String accountNumber;
  String referenceId;
  String penalcharge;
  String wht1;

  FdLiquidationResponse({
    required this.retval,
    required this.retmsg,
    required this.accountNumber,
    required this.referenceId,
    required this.penalcharge,
    required this.wht1,
  });

  factory FdLiquidationResponse.fromJson(Map<String, dynamic> json) => FdLiquidationResponse(
    retval: json["retval"],
    retmsg: json["retmsg"],
    accountNumber: json["accountNumber"],
    referenceId: json["referenceID"],
    penalcharge: json["penalcharge"],
    wht1: json["wht1"],
  );

  Map<String, dynamic> toJson() => {
    "retval": retval,
    "retmsg": retmsg,
    "accountNumber": accountNumber,
    "referenceID": referenceId,
    "penalcharge": penalcharge,
    "wht1": wht1,
  };

}
