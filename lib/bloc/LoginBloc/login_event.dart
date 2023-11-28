part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}
class LoginEventLoginUser  extends LoginEvent {
  final LoginRequest request;
  const LoginEventLoginUser(this.request);
  @override
  List<Object?> get props => [];
}