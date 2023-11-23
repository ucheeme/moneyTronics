part of 'fixed_deposit_calculator_bloc.dart';

abstract class FixedDepositCalculatorEvent extends Equatable {
  const FixedDepositCalculatorEvent();
}
class FDCalculatorEvent  extends FixedDepositCalculatorEvent {
  final FdCalculatorRequest request;
  const FDCalculatorEvent(this.request);
  @override
  List<Object?> get props => [];
}
class FDListEvents  extends FixedDepositCalculatorEvent {
  const FDListEvents();
  @override
  List<Object?> get props => [];
}
class FDProductListEvents  extends FixedDepositCalculatorEvent {
  const FDProductListEvents();
  @override
  List<Object?> get props => [];
}
class FDInvestEvent  extends FixedDepositCalculatorEvent {
  final FixedDepositRequest request;
  const FDInvestEvent(this.request);
  @override
  List<Object?> get props => [];
}