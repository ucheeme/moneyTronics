part of 'bill_bloc.dart';

abstract class BillState extends Equatable {
  const BillState();
}
class BillInitial extends BillState {
  @override
  List<Object> get props => [];
}
class BillStateLoading extends BillState {
  @override
  List<Object> get props => [];
}
class BillNetworkProvidersSuccessState extends BillState {
  final NetworkPlansResponse response;
  const BillNetworkProvidersSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class BillVendSuccessState extends BillState {
  final SimpleResponse response;
  const BillVendSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class BillGetBillerGroupsSuccessState extends BillState {
  final List<BillerGroupsResponse> response;
  const BillGetBillerGroupsSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class BillGetBillerGroupsDetailsSuccessState extends BillState {
  final List<BillerGroupsDetailsResponse> response;
  const BillGetBillerGroupsDetailsSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class BillGetBillerPackageSuccessState extends BillState {
  final List<BillerPackageResponse> response;
  const BillGetBillerPackageSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class BillGetBillerCustomerLookUPSuccessState extends BillState {
  final BillsCustomerLookUpResponse response;
  const BillGetBillerCustomerLookUPSuccessState(this.response);
  @override
  List<Object> get props => [response];
}
class BillMakeBillsPaymentSuccessState extends BillState {
  final BillMakeBillsPaymentResponse response;
  const BillMakeBillsPaymentSuccessState(this.response);
  @override
  List<Object> get props => [response];
}

class BillStateError extends BillState {
  final ApiResponse errorResponse;
  const BillStateError(this.errorResponse);
  @override
  List<Object> get props => [errorResponse];
}
class BillStateError2 extends BillState {
  final ApiResponse2 errorResponse;
  const BillStateError2(this.errorResponse);

  @override
  List<Object> get props => [errorResponse];
}
