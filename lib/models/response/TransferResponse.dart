
import 'dart:convert';
TransactionResponse transactionResponseFromJson(String str) => TransactionResponse.fromJson(json.decode(str));
String transactionResponseToJson(TransactionResponse data) => json.encode(data.toJson());

class TransactionResponse {
  int retval;
  String retmsg;
  String requestId;
  String debitAcct;
  String creditAcct;
  String benificiaryBank;
  String transStatus;
  String narration;
  double tranAmt;

  TransactionResponse({
    required this.retval,
    required this.retmsg,
    required this.requestId,
    required this.debitAcct,
    required this.creditAcct,
    required this.benificiaryBank,
    required this.transStatus,
    required this.narration,
    required this.tranAmt,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => TransactionResponse(
    retval: json["retval"],
    retmsg: json["retmsg"],
    requestId: json["requestID"],
    debitAcct: json["debitAcct"],
    creditAcct: json["creditAcct"],
    benificiaryBank: json["benificiaryBank"],
    transStatus: json["trans_status"],
    narration: json["narration"],
    tranAmt: json["tranAmt"],
  );

  Map<String, dynamic> toJson() => {
    "retval": retval,
    "retmsg": retmsg,
    "requestID": requestId,
    "debitAcct": debitAcct,
    "creditAcct": creditAcct,
    "benificiaryBank": benificiaryBank,
    "trans_status": transStatus,
    "narration": narration,
    "tranAmt": tranAmt,
  };
}
