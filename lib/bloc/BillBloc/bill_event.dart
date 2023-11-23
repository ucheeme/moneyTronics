part of 'bill_bloc.dart';

abstract class BillEvent extends Equatable {
  const BillEvent();
}
class BillGetNetworkProvidersEvents  extends BillEvent {
  const BillGetNetworkProvidersEvents();
  @override
  List<Object?> get props => [];
}
class BillPostVendEvents extends BillEvent {
  VendRequest request;
  BillPostVendEvents({required this.request});
  @override
  List<Object?> get props => [];
}

class BillGetBillerGroupsEvents  extends BillEvent {
  const BillGetBillerGroupsEvents();
  @override
  List<Object?> get props => [];
}
class BillGetBillerGroupsDetailsEvents  extends BillEvent {
  int? billerId;
  BillGetBillerGroupsDetailsEvents({required this.billerId});
  @override
  List<Object?> get props => [];
}
class BillGetBillerPackageEvents  extends BillEvent {
 String? categorySlug;
  BillGetBillerPackageEvents({required this.categorySlug});
  @override
  List<Object?> get props => [];
}
class BillGetCustomerLookUpEvents extends BillEvent {
  BillsCustomerLookUpRequest request;
  BillGetCustomerLookUpEvents({required this.request});
  @override
  List<Object?> get props => [];
}
class BillMakeBillsPaymentEvents extends BillEvent {
  BillMakeBillsPaymentRequest request;
  BillMakeBillsPaymentEvents({required this.request});
  @override
  List<Object?> get props => [];
}