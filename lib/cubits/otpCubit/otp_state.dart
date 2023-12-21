part of 'otp_cubit.dart';

abstract class OtpState extends Equatable {
  const OtpState();
}
class OtpInitial extends OtpState {
  @override
  List<Object> get props => [];
}
class OtpLoadingState extends OtpState {
  @override
  List<Object?> get props => [];
}
class OtpCompleteState extends OtpState {
  final String response;
  const OtpCompleteState(this.response);
  @override
  List<Object> get props => [response];
}
class OtpErrorState extends OtpState {
  final ApiResponse response;
  const OtpErrorState(this.response);
  @override
  List<Object> get props => [response];
}
class OtpVerifiedState extends OtpState {
  final bool response;
  const OtpVerifiedState(this.response);
  @override
  List<Object> get props => [response];
}
class OtpAccountCreatedState extends OtpState {
final AccountNumberResponse response;
 const OtpAccountCreatedState(this.response);
  @override
 List<Object> get props => [response];
}
class PinVerifiedState extends OtpState {
  final ApiResponse response;
  const PinVerifiedState(this.response);
  @override
  List<Object> get props => [response];
}
class OtpSentState extends OtpState {
  final ApiResponse response;
  const OtpSentState(this.response);
  @override
  List<Object> get props => [response];
}
class OtpResendState extends OtpState {
  final ApiResponse response;
  const OtpResendState(this.response);
  @override
  List<Object> get props => [response];
}
class OtpCollectedState extends OtpState {
  final String response;
  const OtpCollectedState(this.response);
  @override
  List<Object> get props => [response];
}