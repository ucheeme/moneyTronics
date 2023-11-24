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
