// To parse this JSON data, do
//
//     final finedgeBankVerification = finedgeBankVerificationFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';
FinedgeBankVerification finedgeBankVerificationFromJson(String str) => FinedgeBankVerification.fromJson(json.decode(str));
String finedgeBankVerificationToJson(FinedgeBankVerification data) => json.encode(data.toJson());
class FinedgeBankVerification {
  String? accountNumber;
  int? retval;
  String? retmsg;
  String? acctName;

  FinedgeBankVerification({
    this.accountNumber,
    this.retval,
    this.retmsg,
    this.acctName,
  });

  factory FinedgeBankVerification.fromJson(Map<String, dynamic> json) => FinedgeBankVerification(
    accountNumber: json["accountNumber"],
    retval: json["retval"],
    retmsg: json["retmsg"],
    acctName: json["acctName"],
  );

  Map<String, dynamic> toJson() => {
    "accountNumber": accountNumber,
    "retval": retval,
    "retmsg": retmsg,
    "acctName": acctName,
  };
}


OtherBankVerification otherBankVerificationFromJson(String str) => OtherBankVerification.fromJson(json.decode(str));

String otherBankVerificationToJson(OtherBankVerification data) => json.encode(data.toJson());

class OtherBankVerification {
  String? sessionId;
  String? destinationInstitutionCode;
  String? channelCode;
  String? accountNumber;
  String? accountName;
  String? bankVerificationNumber;
  String? kycLevel;
  String? responseCode;

  OtherBankVerification({
    this.sessionId,
    this.destinationInstitutionCode,
    this.channelCode,
    this.accountNumber,
    this.accountName,
    this.bankVerificationNumber,
    this.kycLevel,
    this.responseCode,
  });

  factory OtherBankVerification.fromJson(Map<String, dynamic> json) => OtherBankVerification(
    sessionId: json["sessionID"],
    destinationInstitutionCode: json["destinationInstitutionCode"],
    channelCode: json["channelCode"],
    accountNumber: json["accountNumber"],
    accountName: json["accountName"],
    bankVerificationNumber: json["bankVerificationNumber"],
    kycLevel: json["kycLevel"],
    responseCode: json["responseCode"],
  );

  Map<String, dynamic> toJson() => {
    "sessionID": sessionId,
    "destinationInstitutionCode": destinationInstitutionCode,
    "channelCode": channelCode,
    "accountNumber": accountNumber,
    "accountName": accountName,
    "bankVerificationNumber": bankVerificationNumber,
    "kycLevel": kycLevel,
    "responseCode": responseCode,
  };
}
