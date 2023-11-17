// To parse this JSON data, do
//
//     final forgotPasswordOtpRequest = forgotPasswordOtpRequestFromJson(jsonString);

import 'dart:convert';

ForgotPasswordOtpRequest forgotPasswordOtpRequestFromJson(String str) => ForgotPasswordOtpRequest.fromJson(json.decode(str));

String forgotPasswordOtpRequestToJson(ForgotPasswordOtpRequest data) => json.encode(data.toJson());

class ForgotPasswordOtpRequest {
  String? username;
  String? answerToQuestion;

  ForgotPasswordOtpRequest({
    this.username,
    this.answerToQuestion,
  });

  factory ForgotPasswordOtpRequest.fromJson(Map<String, dynamic> json) => ForgotPasswordOtpRequest(
    username: json["username"],
    answerToQuestion: json["answer_To_Question"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "answer_To_Question": answerToQuestion,
  };
}
