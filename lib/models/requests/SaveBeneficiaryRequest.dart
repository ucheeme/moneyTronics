// To parse this JSON data, do
//
//     final saveBeneficiaryRequest = saveBeneficiaryRequestFromJson(jsonString);

import 'dart:convert';

SaveBeneficiaryRequest saveBeneficiaryRequestFromJson(String str) => SaveBeneficiaryRequest.fromJson(json.decode(str));
String saveBeneficiaryRequestToJson(SaveBeneficiaryRequest data) => json.encode(data.toJson());
class SaveBeneficiaryRequest {
  String beneficiaryBankcode;
  String beneficiaryBankname;
  String beneficiaryFullName;
  String beneficiaryAccoutNumber;
  String alias;

  SaveBeneficiaryRequest({
    required this.beneficiaryBankcode,
    required this.beneficiaryBankname,
    required this.beneficiaryFullName,
    required this.beneficiaryAccoutNumber,
    required this.alias,
  });

  factory SaveBeneficiaryRequest.fromJson(Map<String, dynamic> json) => SaveBeneficiaryRequest(
    beneficiaryBankcode: json["beneficiaryBankcode"],
    beneficiaryBankname: json["beneficiaryBankname"],
    beneficiaryFullName: json["beneficiaryFullName"],
    beneficiaryAccoutNumber: json["beneficiaryAccoutNumber"],
    alias: json["alias"],
  );

  Map<String, dynamic> toJson() => {
    "beneficiaryBankcode": beneficiaryBankcode,
    "beneficiaryBankname": beneficiaryBankname,
    "beneficiaryFullName": beneficiaryFullName,
    "beneficiaryAccoutNumber": beneficiaryAccoutNumber,
    "alias": alias,
  };
}
