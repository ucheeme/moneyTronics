part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthStateLoading extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthStateError extends AuthState {
  final ApiResponse errorResponse;
  const AuthStateError(this.errorResponse);
  @override
  List<Object> get props => [errorResponse];
}
class AuthStateUserCreated extends AuthState {
  final AccountNumberResponse response;
  const AuthStateUserCreated(this.response);
  @override
  List<Object> get props => [response];
}
