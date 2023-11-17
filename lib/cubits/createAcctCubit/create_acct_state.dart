part of 'create_acct_cubit.dart';

abstract class CreateAcctState extends Equatable {
  const CreateAcctState();
}

class CreateAcctInitialState extends CreateAcctState {
  @override
  List<Object> get props => [];
}

class CreateAcctLoadingState extends CreateAcctState {
  @override
  List<Object> get props => [];
}

class CreateAcctErrorState extends CreateAcctState {
  final ApiResponse errorResponse;
  const CreateAcctErrorState(this.errorResponse);
  @override
  List<Object> get props => [errorResponse];
}

class CreateAcctSuccessfulState extends CreateAcctState {
 final AccountNumberResponse response;
 CreateAcctSuccessfulState(this.response);
  @override
  List<Object> get props => [response];
}