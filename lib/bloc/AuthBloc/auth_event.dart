part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}
 class AuthEventCreateUser  extends AuthEvent {
  final CreateAccountRequest request;
  const AuthEventCreateUser(this.request);

  @override
  List<Object?> get props => [];
}
class AuthEventValidateExistingBVN  extends AuthEvent {
 final ValidateExistingUserRequest request;
 const AuthEventValidateExistingBVN(this.request);

 @override
 List<Object?> get props => [];
}
class SecurityQuestionsEvent  extends AuthEvent {
 const SecurityQuestionsEvent();
 @override
 List<Object?> get props => [];
}
class AuthEventCreateExistingUser  extends AuthEvent {
 final CreateExistingUserRequest request;
 const AuthEventCreateExistingUser(this.request);

 @override
 List<Object?> get props => [];
}

