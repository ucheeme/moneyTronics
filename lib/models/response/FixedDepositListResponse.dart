
import 'dart:convert';
List<FixedDepositListResponse> fixedDepositListResponseFromJson(String str) => List<FixedDepositListResponse>.from(json.decode(str).map((x) => FixedDepositListResponse.fromJson(x)));
String fixedDepositListResponseToJson(List<FixedDepositListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FixedDepositListResponse {
  String tdAccountNo;
  String settlementAcctNo;
  String accountName;
  String branch;
  String product;
  double tdAmount;
  double currentBalance;
  String tdDuration;
  String interestrate;
  String startDate;
  String maturityDate;
  String tdPurpose;
  String totalInterest;
  String taxAmount;
  String matureAmount;
  String accruedToDate;

  FixedDepositListResponse({
    required this.tdAccountNo,
    required this.settlementAcctNo,
    required this.accountName,
    required this.branch,
    required this.product,
    required this.tdAmount,
    required this.currentBalance,
    required this.tdDuration,
    required this.interestrate,
    required this.startDate,
    required this.maturityDate,
    required this.tdPurpose,
    required this.totalInterest,
    required this.taxAmount,
    required this.matureAmount,
    required this.accruedToDate,
  });

  factory FixedDepositListResponse.fromJson(Map<String, dynamic> json) => FixedDepositListResponse(
    tdAccountNo: json["tdAccountNo"],
    settlementAcctNo: json["settlementAcctNo"],
    accountName: json["accountName"],
    branch: json["branch"],
    product: json["product"],
    tdAmount: json["tdAmount"],
    currentBalance: json["currentBalance"],
    tdDuration: json["tdDuration"],
    interestrate: json["interestrate"],
    startDate: json["startDate"],
    maturityDate: json["maturityDate"],
    tdPurpose: json["tdPurpose"],
    totalInterest: json["totalInterest"],
    taxAmount: json["taxAmount"],
    matureAmount: json["matureAmount"],
    accruedToDate: json["accruedToDate"],
  );

  Map<String, dynamic> toJson() => {
    "tdAccountNo": tdAccountNo,
    "settlementAcctNo": settlementAcctNo,
    "accountName": accountName,
    "branch": branch,
    "product": product,
    "tdAmount": tdAmount,
    "currentBalance": currentBalance,
    "tdDuration": tdDuration,
    "interestrate": interestrate,
    "startDate": startDate,
    "maturityDate": maturityDate,
    "tdPurpose": tdPurpose,
    "totalInterest": totalInterest,
    "taxAmount": taxAmount,
    "matureAmount": matureAmount,
    "accruedToDate": accruedToDate,
  };
}
