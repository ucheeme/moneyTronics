// To parse this JSON data, do
//
//     final securityQuestion = securityQuestionFromJson(jsonString);

import 'dart:convert';

List<SecurityQuestion> securityQuestionFromJson(String str) => List<SecurityQuestion>.from(json.decode(str).map((x) => SecurityQuestion.fromJson(x)));

String securityQuestionToJson(List<SecurityQuestion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SecurityQuestion {
  int id;
  String secretQuestion;

  SecurityQuestion({
    required this.id,
    required this.secretQuestion,
  });

  factory SecurityQuestion.fromJson(Map<String, dynamic> json) => SecurityQuestion(
    id: json["id"],
    secretQuestion: json["secret_Question"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "secret_Question": secretQuestion,
  };
}
