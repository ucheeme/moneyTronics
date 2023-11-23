part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();
}
class TransactionBankEvent  extends TransactionEvent {
  const TransactionBankEvent();
  @override
  List<Object?> get props => [];
}
class TransactionSaveBeneficiaryEvent  extends TransactionEvent {
  SaveBeneficiaryRequest request;
  TransactionSaveBeneficiaryEvent(this.request);
  @override
  List<Object?> get props => [];
}
class TransactionPostEvent  extends TransactionEvent {
  TransferRequest request;
   TransactionPostEvent(this.request);
  @override
  List<Object?> get props => [];
}
class TransactionAccountVerificationEvent  extends TransactionEvent {
  AccountVerification request;
  TransactionAccountVerificationEvent(this.request);
  @override
  List<Object?> get props => [];
}