import 'dart:convert';
ResetTransactionPinRequest resetTransactionPinRequestFromJson(String str) => ResetTransactionPinRequest.fromJson(json.decode(str));
String resetTransactionPinRequestToJson(ResetTransactionPinRequest data) => json.encode(data.toJson());

class ResetTransactionPinRequest {
  String accountnumber;
  String opTcode;
  String newTransPin;
  String renterTransactionpin;
  String answerToQuestion;

  ResetTransactionPinRequest({
    required this.accountnumber,
    required this.opTcode,
    required this.newTransPin,
    required this.renterTransactionpin,
    required this.answerToQuestion,
  });

  factory ResetTransactionPinRequest.fromJson(Map<String, dynamic> json) => ResetTransactionPinRequest(
    accountnumber: json["accountnumber"],
    opTcode: json["opTcode"],
    newTransPin: json["new_Trans_Pin"],
    renterTransactionpin: json["renter_Transactionpin"],
    answerToQuestion: json["answer_To_Question"],
  );

  Map<String, dynamic> toJson() => {
    "accountnumber": accountnumber,
    "opTcode": opTcode,
    "new_Trans_Pin": newTransPin,
    "renter_Transactionpin": renterTransactionpin,
    "answer_To_Question": answerToQuestion,
  };
}
