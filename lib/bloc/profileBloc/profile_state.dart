part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}
class ProfileStateLoading extends ProfileState {
  @override
  List<Object> get props => [];
}
class ProfileStateError extends ProfileState {
  final ApiResponse errorResponse;
  const ProfileStateError(this.errorResponse);
  @override
  List<Object> get props => [errorResponse];
}

class ProfileCustomerDetailState extends ProfileState {
  final SimpleResponse response;
  const ProfileCustomerDetailState(this.response);
  @override
  List<Object> get props => [response];
}
class ProfileCreateAdditionalAccountState extends ProfileState {
  final CreateAdditionalAccountResponse response;
  const ProfileCreateAdditionalAccountState(this.response);
  @override
  List<Object> get props => [response];
}

class ProfileBankProductState extends ProfileState {
  final List<FinedgeProduct> response;
  const ProfileBankProductState(this.response);
  @override
  List<Object> get props => [response];
}