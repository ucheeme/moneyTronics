
import 'dart:convert';

AccountVerification accountVerificationFromJson(String str) => AccountVerification.fromJson(json.decode(str));
String accountVerificationToJson(AccountVerification data) => json.encode(data.toJson());

class AccountVerification {
  String accountNumber;
  String bankCode;
  AccountVerification({
    required this.accountNumber,
    required this.bankCode,
  });
  factory AccountVerification.fromJson(Map<String, dynamic> json) => AccountVerification(
    accountNumber: json["AccountNumber"],
    bankCode: json["BankCode"],
  );
  Map<String, dynamic> toJson() => {
    "AccountNumber": accountNumber,
    "BankCode": bankCode,
  };
}
