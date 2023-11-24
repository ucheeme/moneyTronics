// To parse this JSON data, do
//
//     final statementRequestResponse = statementRequestResponseFromJson(jsonString);

import 'dart:convert';

StatementRequestResponse statementRequestResponseFromJson(String str) => StatementRequestResponse.fromJson(json.decode(str));

String statementRequestResponseToJson(StatementRequestResponse data) => json.encode(data.toJson());

class StatementRequestResponse {
  int retval;
  String retmsg;
  String statementRequestId;

  StatementRequestResponse({
    required this.retval,
    required this.retmsg,
    required this.statementRequestId,
  });

  factory StatementRequestResponse.fromJson(Map<String, dynamic> json) => StatementRequestResponse(
    retval: json["retval"],
    retmsg: json["retmsg"],
    statementRequestId: json["statementRequestID"],
  );

  Map<String, dynamic> toJson() => {
    "retval": retval,
    "retmsg": retmsg,
    "statementRequestID": statementRequestId,
  };
}
