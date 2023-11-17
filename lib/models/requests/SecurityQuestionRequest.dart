import 'dart:convert';

SecurityQuestionRequest securityQuestionRequestFromJson(String str) => SecurityQuestionRequest.fromJson(json.decode(str));

String securityQuestionRequestToJson(SecurityQuestionRequest data) => json.encode(data.toJson());

class SecurityQuestionRequest {
  int? questionId;
  String? answer;

  SecurityQuestionRequest({
    this.questionId,
    this.answer,
  });

  factory SecurityQuestionRequest.fromJson(Map<String, dynamic> json) => SecurityQuestionRequest(
    questionId: json["questionID"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "questionID": questionId,
    "answer": answer,
  };
}
