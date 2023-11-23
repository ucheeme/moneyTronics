import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';


import '../../models/requests/FDCalculator.dart';
import '../../models/requests/FixedDepositRequest.dart';
import '../../models/response/ApiResponse.dart';
import '../../models/response/FDCalculatorResponse.dart';
import '../../models/response/FDProducts.dart';
import '../../models/response/FixedDepositListResponse.dart';
import '../../models/response/FixedDepositResponse.dart';
import '../../repository/FDRepository.dart';
import '../../utils/appUtil.dart';
import 'BookingFormValidation.dart';

part 'fixed_deposit_calculator_event.dart';
part 'fixed_deposit_calculator_state.dart';

class FixedDepositCalculatorBloc extends Bloc<FixedDepositCalculatorEvent, FixedDepositCalculatorState> {

  FDBookingValidation validation = FDBookingValidation();
  final _fdProductSubject = BehaviorSubject<List<FdProducts>>();
  final _fdListSubject = BehaviorSubject<List<FixedDepositListResponse>>();
  Stream<List<FdProducts>> get productStream => _fdProductSubject.stream;
  Stream<List<FixedDepositListResponse>> get fdListSubject => _fdListSubject.stream;

  FDRepository repository;
  FixedDepositCalculatorBloc({required this.repository}) : super(FixedDepositCalculatorInitial()) {
    on<FixedDepositCalculatorEvent>((event, emit) {
    });
    on<FDCalculatorEvent>((event, emit) async{
      try {
        emit(FDLoadingState());
        final response = await repository.fdCalculator(event.request );
        if (response is FdCalculatorResponse) {
          emit(FDCalculatorState(response));
          AppUtils.debug("login successful");
        }else{
          response as ApiResponse;
          emit(FDStateError(response));
          AppUtils.debug("error");
        }
      }catch(e){
        emit(FDStateError(AppUtils.defaultErrorResponse()));
        AppUtils.debug("error");
      }
    });
    on<FDProductListEvents>((event, emit) async{
      try {
        emit(FDLoadingState());
        final response = await repository.getFDProducts();
        if (response is List<FdProducts>) {
          _fdProductSubject.sink.add(response);
          emit(FDProductsState(response));
          AppUtils.debug("login successful");
        }else{
          response as ApiResponse;
          emit(FDStateError(response));
          AppUtils.debug("error");
        }
      }catch(e){
        emit(FDStateError(AppUtils.defaultErrorResponse()));
        AppUtils.debug("error");
      }
    });
    on<FDInvestEvent>((event, emit) {
      handleFDInvest(event);
    });
    on<FDListEvents>((event, emit) {
      handleFDListEvent(event);
    });
  }
  handleCalculatorEvent(event) async {
    try {
      emit(FDLoadingState());
      final response = await repository.fdCalculator(event.request );
      if (response is FdCalculatorResponse) {
        emit(FDCalculatorState(response));
        AppUtils.debug("login successful");
      }else{
        response as ApiResponse;
        emit(FDStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(FDStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  handleFDProductEvent(event) async {

  }
  handleFDListEvent(event) async {
    try {
      emit(FDLoadingState());
      final response = await repository.getFDList();
      if (response is List<FixedDepositListResponse>) {
        _fdListSubject.sink.add(response);
        emit(FDListState(response));
        AppUtils.debug("Fixed deposit fetched successfully");
      }else{
        response as ApiResponse;
        emit(FDStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(FDStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }

  handleFDInvest(event) async {
    try {

      emit(FDLoadingState());
      final response = await repository.fdInvest(event.request);
      if (response is FixedDepositResponse) {
        emit(FDInvestResponseState(response));
        AppUtils.debug("login successful");
      }else{
        response as ApiResponse;
        emit(FDStateError(response));
        AppUtils.debug("error");
      }

    }catch(e){
      emit(FDStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }

  }

  initial(){
    emit(FixedDepositCalculatorInitial());
  }

}
