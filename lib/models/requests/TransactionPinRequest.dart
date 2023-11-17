
import 'dart:convert';

TransactionPinRequest transactionPinRequestFromJson(String str) => TransactionPinRequest.fromJson(json.decode(str));
String transactionPinRequestToJson(TransactionPinRequest data) => json.encode(data.toJson());

class TransactionPinRequest {
  String? accountnumber;
  String? transactionpin;
  String? renterTransactionpin;
  TransactionPinRequest({
    this.accountnumber,
    this.transactionpin,
    this.renterTransactionpin,
  });
  factory TransactionPinRequest.fromJson(Map<String, dynamic> json) => TransactionPinRequest(
    accountnumber: json["accountnumber"],
    transactionpin: json["transactionpin"],
    renterTransactionpin: json["renter_Transactionpin"],
  );
  Map<String, dynamic> toJson() => {
    "accountnumber": accountnumber,
    "transactionpin": transactionpin,
    "renter_Transactionpin": renterTransactionpin,
  };
}
