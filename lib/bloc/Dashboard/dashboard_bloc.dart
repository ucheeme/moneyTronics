import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../ApiService/ApiService.dart';
import '../../models/requests/DeleteBeneficiary.dart';
import '../../models/requests/FetchStatementRequest.dart';
import '../../models/requests/LoginRequest.dart';
import '../../models/requests/SecurityQuestionRequest.dart';
import '../../models/requests/TransactionHistoryRequest.dart';
import '../../models/requests/TransactionPinRequest.dart';
import '../../models/response/ApiResponse.dart';
import '../../models/response/BeneficiaryResponse.dart';
import '../../models/response/BillsResponse/NetworkPlansResponse.dart';
import '../../models/response/LoginResponse.dart';
import '../../models/response/SimpleApiResponse.dart';
import '../../models/response/TransactionHistory.dart';
import '../../models/response/UserAccountResponse.dart';
import '../../repository/dashboardRepository.dart';
import '../../utils/appUtil.dart';
import '../../utils/userUtil.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';


class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final _transactionListSubject = BehaviorSubject<List<TransactionHistoryResponse>>();
  final _beneficiaryListSubject = BehaviorSubject<List<Beneficiary>>();
  Stream<List<Beneficiary>> get beneficiaryListStream =>  _beneficiaryListSubject.stream;
  Stream<List<TransactionHistoryResponse>> get transactionListStream =>  _transactionListSubject.stream;

  DashboardRepository repository;
  final _userAccountListSubject = BehaviorSubject<List<UserAccount>>();
  Stream<List<UserAccount>> get userAccountListSubject => _userAccountListSubject.stream;
  DashboardBloc({required this.repository}) : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {
    });
    on<DashboardGetAccountsEvent>((event, emit){
      handleAccountFetch();
    });
    on<DashboardSetTransactionPinEvent>((event, emit){
      handleSetTransactionPin(event);
    });
    on<DashboardLoginEvents>((event, emit){
      handleLoginEvent(event);
    });
    on<DashboardTransactionHistoryEvents>((event, emit){
      handleTransactionHistoryEvent(event);
    });
    on<DashboardBeneficiaryEvent>((event, emit){
      handleBeneficiaryEvent(event);
    });
    on<DashboardDelBeneficiaryEvent>((event, emit){
      handleDelBeneficiaryEvent(event);
    });
    on<DashboardRequestStatementEvent>((event, emit){
      handleRequestStatementEvent(event);
    });
  }
  handleAccountFetch()async{
    emit(DashboardStateLoading());
    try {
      final response = await repository.getUsersAccount( );
      if (response is List<UserAccount>) {
        emit(DashboardAccountsState(response));
        await SharedPref.save(SharedPrefKeys.userAccount, userAccountToJson(response));
        _userAccountListSubject.sink.add(response);
        AppUtils.debug("accounts fetched");
      }else{
        response as ApiResponse;
        emit(DashboardStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(DashboardStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  handleSetTransactionPin(event)async{
    emit(DashboardStateLoading());
    try {
      final response = await repository.setTransactionPin(event.request);
      if (response is SimpleResponse) {
        emit(DashboardSetTransactionPinState(response));
        AppUtils.debug("transaction pin set successfully");
      }else{
        response as ApiResponse;
        emit(DashboardStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(DashboardStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  handleLoginEvent(event) async {
    try {
      final response = await repository.login(event.request );
      if (response is LoginResponse) {
        accessToken = response.token ?? "";
        emit(DashboardLoginSuccessfulState(response));
        AppUtils.debug("login successful");
      }else{
        response as ApiResponse;
        emit(DashboardStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(DashboardStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  handleTransactionHistoryEvent(event) async {
    try {
      final response = await repository.getTransactionHistory(event.request );
      if (response is List<TransactionHistoryResponse>) {
        _transactionListSubject.sink.add(response);
        emit(DashboardTransactionHistoryState(response));
        AppUtils.debug("Transaction history fetched");
      }else{
        response as ApiResponse;
        emit(DashboardStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(DashboardStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  handleSetSecurityQuestion(event)async{
    emit(DashboardStateLoading());
    try {
      final response = await repository.setSecurityQuestion(event.request);
      if (response is SimpleResponse) {
        emit(DashboardSetSecurityQuestionState(response));
        AppUtils.debug("security question set successfully");
      }else{
        response as ApiResponse;
        emit(DashboardStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(DashboardStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  handleBeneficiaryEvent(event) async {
    emit(DashboardStateLoading());
    try {
      final response = await repository.getBeneficiary();
      if (response is List<Beneficiary>) {
        _beneficiaryListSubject.add(response);
        emit(DashboardBeneficiaryState(response));
        AppUtils.debug("Beneficiary fetched");
      } else {
        response as ApiResponse;
        emit(DashboardStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(DashboardStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }

  handleDelBeneficiaryEvent(event)async{
    emit(DashboardStateLoading());
    try {
      final response = await repository.delBeneficiary(event.request);
      if (response is SimpleResponse) {
        emit(DashboardDelBeneficiaryState(response));
        AppUtils.debug("Beneficiary deleted");
      } else {
        response as ApiResponse;
        emit(DashboardStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(DashboardStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  handleRequestStatementEvent(event)async{
    emit(DashboardStateLoading());
    try {
      final response = await repository.requestStatement(event.request);
      if (response is SimpleResponse) {
        emit(DashboardDelBeneficiaryState(response));
        AppUtils.debug("Beneficiary deleted");
      } else {
        response as ApiResponse;
        emit(DashboardStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(DashboardStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  initial(){
    emit(DashboardInitial());
  }

}