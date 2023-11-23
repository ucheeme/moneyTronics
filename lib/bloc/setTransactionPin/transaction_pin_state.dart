part of 'transaction_pin_bloc.dart';

abstract class SetTransactionPinState extends Equatable {
  const SetTransactionPinState();
}

class SetTransactionPinInitial extends SetTransactionPinState {
  @override
  List<Object> get props => [];
}

class SetTransactionPinLoading extends SetTransactionPinState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SetTransactionPinErrorState extends SetTransactionPinState{
  final ApiResponse errorResponse;
  const SetTransactionPinErrorState(this.errorResponse);
  @override
  // TODO: implement props
  List<Object?> get props => [errorResponse];
}

class SetTransactionPinSuccessState extends SetTransactionPinState{
  final ApiResponse errorResponse;
  const SetTransactionPinSuccessState(this.errorResponse);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}