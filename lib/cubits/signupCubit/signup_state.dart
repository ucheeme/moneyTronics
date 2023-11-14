part of 'signup_cubit.dart';

abstract class SignupState extends Equatable {
  const SignupState();
}

class SignupInitialState extends SignupState {
  @override
  List<Object> get props => [];
}

class SignupLoadingState extends SignupState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SignupSuccessState extends SignupState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class SignupErrorState extends SignupState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}