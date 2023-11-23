part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}
class SettingsForgotPasswordEvent  extends SettingEvent {
  final ForgotPasswordOtpRequest request;
  const SettingsForgotPasswordEvent(this.request);
  @override
  List<Object?> get props => [];
}
class SettingResetPasswordEvent  extends SettingEvent {
  final ForgotPasswordRequest request;
  const SettingResetPasswordEvent(this.request);
  @override
  List<Object?> get props => [];
}

class SettingBvnInfoEvent  extends SettingEvent {
  const SettingBvnInfoEvent();
  @override
  List<Object?> get props => [];
}

class SettingChangePasswordEvent  extends SettingEvent {
  final ChangePasswordRequest request;
  const SettingChangePasswordEvent(this.request);
  @override
  List<Object?> get props => [];
}

class SettingAccountUpgradeEvent  extends SettingEvent {
  final AccountTierUpgradeRequest request;
  const SettingAccountUpgradeEvent(this.request);
  @override
  List<Object?> get props => [];
}

class SettingSecurityQuestionsEvent  extends SettingEvent {
  const SettingSecurityQuestionsEvent();
  @override
  List<Object?> get props => [];
}

class SettingSendOtpEvent  extends SettingEvent {
  final SendOtpRequest request;
  const SettingSendOtpEvent({required this.request});
  @override
  List<Object?> get props => [];
}

class SettingResetTpinEvent  extends SettingEvent {
  final ResetTransactionPinRequest request;
  const SettingResetTpinEvent(this.request);
  @override
  List<Object?> get props => [];
}

class SettingsDeviceRegistrationEvent  extends SettingEvent {
  final DeviceAuthenticationRequest request;
  const SettingsDeviceRegistrationEvent(this.request);
  @override
  List<Object?> get props => [];
}