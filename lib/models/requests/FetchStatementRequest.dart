
import 'dart:convert';

FetchStatementRequest fetchStatementRequestFromJson(String str) => FetchStatementRequest.fromJson(json.decode(str));

String fetchStatementRequestToJson(FetchStatementRequest data) => json.encode(data.toJson());

class FetchStatementRequest {
  String accountNumber;
  String startDate;
  String endDate;

  FetchStatementRequest({
    required this.accountNumber,
    required this.startDate,
    required this.endDate,
  });

  factory FetchStatementRequest.fromJson(Map<String, dynamic> json) => FetchStatementRequest(
    accountNumber: json["accountNumber"],
    startDate: json["startDate"],
    endDate: json["endDate"],
  );

  Map<String, dynamic> toJson() => {
    "accountNumber": accountNumber,
    "startDate": startDate,
    "endDate": endDate,
  };
}
