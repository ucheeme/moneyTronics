import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../models/requests/SecurityQuestionRequest.dart';
import '../../models/response/SecurityQuestionsResponse.dart';

class SecurityQuestionFormValidation {

  final _securityQuestion = BehaviorSubject<SecurityQuestion>();
  final _securityAnswer = BehaviorSubject<String>();


  Function(SecurityQuestion) get setSecurityQuestion => _securityQuestion.sink.add;
  Function(String) get setSecurityAnswer => _securityAnswer.sink.add;

  Stream<SecurityQuestion> get securityQuestion =>
      _securityQuestion.stream.transform(validateSecurityQuestion);
  Stream<String> get securityAnswer =>
      _securityAnswer.stream.transform(validateSecretAnswer);
  Stream<bool> get validateForm => Rx.combineLatest2(
      securityQuestion, securityAnswer, (securityQuestion, securityAnswer) => true);

  final validateSecurityQuestion = StreamTransformer<SecurityQuestion,  SecurityQuestion>.fromHandlers(
      handleData: (value, sink) {
        sink.add(value);
      }
  );
  final validateSecretAnswer = StreamTransformer<String, String>.fromHandlers(
      handleData: (value, sink) {
        if (value.isEmpty) {
          sink.addError('Please secret answer');
        } else {
          sink.add(value);
        }
      }
  );
  SecurityQuestionRequest getSecurityQuestion(){
    SecurityQuestionRequest request = SecurityQuestionRequest(questionId: _securityQuestion.stream.value.id,answer: _securityAnswer.stream.value);
    return request;
  }
}