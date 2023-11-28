part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginStateLoading extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginDeviceChangeState extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginStateError extends LoginState {
  final ApiResponse errorResponse;
  const LoginStateError(this.errorResponse);
  @override
  List<Object> get props => [errorResponse];
}
class LoginIncompleteRegistration extends LoginState {
  final LoginIncomplete response;
  const LoginIncompleteRegistration(this.response);
  @override
  List<Object> get props => [response];
}
class LoginSuccessfulState extends LoginState {
  final LoginResponse response;
  const LoginSuccessfulState(this.response);
  @override
  List<Object> get props => [response];
}