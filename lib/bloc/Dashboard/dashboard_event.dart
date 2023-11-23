part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}
class DashboardGetAccountsEvent  extends DashboardEvent {
  const DashboardGetAccountsEvent();
  @override
  List<Object?> get props => [];
}
class DashboardSetSecurityQuestionEvent  extends DashboardEvent {
  final SecurityQuestionRequest request;
  const DashboardSetSecurityQuestionEvent(this.request);
  @override
  List<Object?> get props => [];
}
class DashboardLoginEvents  extends DashboardEvent {
  final LoginRequest request;
  const DashboardLoginEvents(this.request);
  @override
  List<Object?> get props => [];
}
class DashboardTransactionHistoryEvents  extends DashboardEvent {
  final TransactionHistoryRequest request;
  const DashboardTransactionHistoryEvents(this.request);
  @override
  List<Object?> get props => [];
}
class DashboardBeneficiaryEvent  extends DashboardEvent {
  const DashboardBeneficiaryEvent();
  @override
  List<Object?> get props => [];
}
class DashboardSetTransactionPinEvent  extends DashboardEvent {
  final TransactionPinRequest request;
  const DashboardSetTransactionPinEvent(this.request);
  @override
  List<Object?> get props => [];
}
class DashboardDelBeneficiaryEvent  extends DashboardEvent {
  final DeleteBeneficiary request;
  const DashboardDelBeneficiaryEvent(this.request);
  @override
  List<Object?> get props => [];
}
class DashboardRequestStatementEvent  extends DashboardEvent {
  final FetchStatementRequest request;
  const DashboardRequestStatementEvent(this.request);
  @override
  List<Object?> get props => [];
}