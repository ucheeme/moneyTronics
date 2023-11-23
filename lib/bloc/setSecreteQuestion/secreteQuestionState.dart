import 'package:equatable/equatable.dart';

import '../../models/response/ApiResponse.dart';
import '../../models/response/SecurityQuestionsResponse.dart';
import '../../models/response/SimpleApiResponse.dart';

abstract class SecreteQuestionState extends Equatable {
  const SecreteQuestionState();
}

class SecreteQuestionInitial extends SecreteQuestionState {
  @override
  List<Object> get props => [];
}
class SecreateQuestionStateLoading extends SecreteQuestionState {
  @override
  List<Object> get props => [];
}
class SecreateQuestionStateError extends SecreteQuestionState {
  final ApiResponse errorResponse;
  const SecreateQuestionStateError(this.errorResponse);
  @override
  List<Object> get props => [errorResponse];
}
class SecurityQuestionState extends SecreteQuestionState {
  final List<SecurityQuestion> response;
  const SecurityQuestionState(this.response);
  @override
  List<Object> get props => [response];
}
class SetSecurityQuestionState extends SecreteQuestionState {
  final SimpleResponse response;
  const SetSecurityQuestionState(this.response);
  @override
  List<Object> get props => [response];
}