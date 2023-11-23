part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}
class ProfileCustomerDetailsEvent extends ProfileEvent {
  const ProfileCustomerDetailsEvent();
  @override
  List<Object?> get props => [];
}
class ProfileBankProductEvent  extends ProfileEvent {
  const ProfileBankProductEvent();
  @override
  List<Object?> get props => [];
}
class ProfileCreateAdditionalAccountEvent  extends ProfileEvent {
  ProductCode request;
  ProfileCreateAdditionalAccountEvent({required this.request});
  @override
  List<Object?> get props => [];
}