part of 'login_user_cubit.dart';

abstract class LoginUserState extends Equatable {
  const LoginUserState();
}

class LoginUserInitialState extends LoginUserState {
  @override
  List<Object> get props => [];
}

class LoginUserSuccessState extends LoginUserState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class LoginUserErrorState extends LoginUserState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class LoginUserLoadingState extends LoginUserState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}