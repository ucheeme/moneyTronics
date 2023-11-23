import 'package:equatable/equatable.dart';

import '../../models/requests/SecurityQuestionRequest.dart';

abstract class SecretQuestEvent extends Equatable {
  const SecretQuestEvent();
}
class SecurityQuestionsEvent  extends SecretQuestEvent {
  const SecurityQuestionsEvent();
  @override
  List<Object?> get props => [];
}
class SetSecurityQuestionEvent  extends SecretQuestEvent {
  final SecurityQuestionRequest request;
  const SetSecurityQuestionEvent(this.request);
  @override
  List<Object?> get props => [];
}