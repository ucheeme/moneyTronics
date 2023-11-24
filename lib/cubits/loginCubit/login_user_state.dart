part of 'login_user_cubit.dart';

abstract class LoginUserState extends Equatable {
  const LoginUserState();
}

class LoginUserInitialState extends LoginUserState {
  @override
  List<Object> get props => [];
}

class LoginUserSuccessState extends LoginUserState {
  final LoginResponse response;

  const LoginUserSuccessState(this.response);

  @override
  // TODO: implement props
  List<Object?> get props => [response];
}
class LoginDeviceChangeState extends LoginUserState {
  @override
  List<Object> get props => [];
}
class LoginIncompleteRegistration extends LoginUserState {
  final LoginIncomplete response;
  const LoginIncompleteRegistration(this.response);
  @override
  List<Object> get props => [response];
}
class LoginUserErrorState extends LoginUserState{
  final ApiResponse errorResponse;
  const LoginUserErrorState( this.errorResponse);
  @override
  // TODO: implement props
  List<Object?> get props => [errorResponse];

}

class LoginUserLoadingState extends LoginUserState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}