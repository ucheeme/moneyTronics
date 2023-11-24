part of 'dashboard_bloc.dart';


abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}
class DashboardStateLoading extends DashboardState {
  @override
  List<Object> get props => [];
}
class DashboardStateError extends DashboardState {
  final ApiResponse errorResponse;
  const DashboardStateError(this.errorResponse);
  @override
  List<Object> get props => [errorResponse];
}
class DashboardAccountsState extends DashboardState {
  final List<UserAccount> response;
  const DashboardAccountsState(this.response);
  @override
  List<Object> get props => [response];
}
class DashboardSetTransactionPinState extends DashboardState {
  final SimpleResponse response;
  const DashboardSetTransactionPinState(this.response);
  @override
  List<Object> get props => [response];
}
class DashboardSetSecurityQuestionState extends DashboardState {
  final SimpleResponse response;
  const DashboardSetSecurityQuestionState(this.response);
  @override
  List<Object> get props => [response];
}
class DashboardNetworkProvidersSuccessState extends DashboardState {
  final NetworkPlansResponse response;
  const DashboardNetworkProvidersSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class DashboardLoginSuccessfulState extends DashboardState {
  final LoginResponse response;
  const DashboardLoginSuccessfulState(this.response);
  @override
  List<Object> get props => [response];
}
class DashboardTransactionHistoryState extends DashboardState {
  final List<TransactionHistoryResponse> response;
  const DashboardTransactionHistoryState(this.response);
  @override
  List<Object> get props => [response];
}
class DashboardBeneficiaryState extends DashboardState {
  final List<Beneficiary> response;
  const DashboardBeneficiaryState(this.response);
  @override
  List<Object> get props => [response];
}
class DashboardDelBeneficiaryState extends DashboardState {
  final SimpleResponse response;
  const DashboardDelBeneficiaryState(this.response);
  @override
  List<Object> get props => [response];
}
class DashboardStatementState extends DashboardState {
  final StatementRequestResponse response;
  const DashboardStatementState(this.response);
  @override
  List<Object> get props => [response];
}