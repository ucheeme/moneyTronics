part of 'fixed_deposit_calculator_bloc.dart';

abstract class FixedDepositCalculatorState extends Equatable {
  const FixedDepositCalculatorState();
}
class FixedDepositCalculatorInitial extends FixedDepositCalculatorState {
  @override
  List<Object> get props => [];
}
class FDListState extends FixedDepositCalculatorState {
  final List<FixedDepositListResponse> response;
  const FDListState(this.response);
  @override
  List<Object> get props => [response];
}
class FDLoadingState extends FixedDepositCalculatorState {
  @override
  List<Object> get props => [];
}
class FDCalculatorState extends FixedDepositCalculatorState {
  final FdCalculatorResponse response;
  const FDCalculatorState(this.response);
  @override
  List<Object> get props => [response];
}
class FDProductsState extends FixedDepositCalculatorState {
  final List<FdProducts> response;
  const FDProductsState(this.response);
  @override
  List<Object> get props => [response];
}
class FDInvestResponseState extends FixedDepositCalculatorState {
  final FixedDepositResponse response;
  const FDInvestResponseState(this.response);
  @override
  List<Object> get props => [response];
}
class FDStateError extends FixedDepositCalculatorState {
  final ApiResponse errorResponse;
  const FDStateError(this.errorResponse);
  @override
  List<Object> get props => [errorResponse];
}