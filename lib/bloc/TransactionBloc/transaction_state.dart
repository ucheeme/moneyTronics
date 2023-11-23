part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();
}
class TransactionInitial extends TransactionState {
  @override
  List<Object> get props => [];
}
class TransactionClearBankState extends TransactionState {
  @override
  List<Object> get props => [];
}
class TransactionStateLoading extends TransactionState {
  @override
  List<Object> get props => [];
}
class TransactionStateError extends TransactionState {
  final ApiResponse errorResponse;
  const TransactionStateError(this.errorResponse);
  @override
  List<Object> get props => [errorResponse];
}
class TransactionBankState extends TransactionState {
  List<Bank> response;
  TransactionBankState(this.response);
  @override
  List<Object> get props => [];
}
class TransactionSaveBeneficiaryState extends TransactionState {
  SimpleResponse response;
  TransactionSaveBeneficiaryState(this.response);
  @override
  List<Object> get props => [];
}
class TransactionAccountVerificationState extends TransactionState {
  AccountVerificationResponse response;
  TransactionAccountVerificationState(this.response);
  @override
  List<Object> get props => [];
}
class TransactionPostState extends TransactionState {
  final TransactionResponse response;
  const TransactionPostState(this.response);
  @override
  List<Object> get props => [response];
}