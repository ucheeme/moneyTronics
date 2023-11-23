part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();
}
class SettingInitial extends SettingState {
  @override
  List<Object> get props => [];
}
class SettingStateLoading extends SettingState {
  @override
  List<Object> get props => [];
}
class SettingStateError extends SettingState {
  final ApiResponse errorResponse;
  const SettingStateError(this.errorResponse);
  @override
  List<Object> get props => [errorResponse];
}
class SettingChangePasswordState extends SettingState {
  const SettingChangePasswordState();
  @override
  List<Object> get props => [];
}
class SettingForgotPasswordState extends SettingState {
  final SimpleResponse response;
  const SettingForgotPasswordState(this.response);
  @override
  List<Object> get props => [response];
}
class SettingForgotPasswordOtpState extends SettingState {
  final ForgotPasswordOtpResponse response;
  const SettingForgotPasswordOtpState(this.response);
  @override
  List<Object> get props => [response];
}
class SettingsSecurityQuestionState extends SettingState {
  final List<SecurityQuestion> response;
  const SettingsSecurityQuestionState(this.response);
  @override
  List<Object> get props => [response];
}
class SettingResetTransactionPinState extends SettingState {
  final SimpleResponse response;
  const SettingResetTransactionPinState(this.response);
  @override
  List<Object> get props => [response];
}
class SettingOtpSentState extends SettingState {
  final SimpleResponse response;
  const SettingOtpSentState(this.response);
  @override
  List<Object> get props => [response];
}
class SettingBvnInfoState extends SettingState {
  final BvnInfoResponse response;
  const SettingBvnInfoState(this.response);
  @override
  List<Object> get props => [response];
}
class SettingAccountUpgradeState extends SettingState {
  final SimpleResponse response;
  const SettingAccountUpgradeState(this.response);
  @override
  List<Object> get props => [response];
}
class SettingDeviceRegistrationState extends SettingState {
  final SimpleResponse response;
  const SettingDeviceRegistrationState(this.response);
  @override
  List<Object> get props => [response];
}