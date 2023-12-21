import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Repository/BillRepository.dart';
import '../../models/requests/BillMakeBillsPaymentRequest.dart';
import '../../models/requests/BillsCustomerLookUpRequest.dart';
import '../../models/requests/EncRequest.dart';
import '../../models/requests/VendRequest.dart';
import '../../models/response/ApiResonse2.dart';
import '../../models/response/ApiResponse.dart';
import '../../models/response/BillsResponse/BillMakeBillsPaymentResponse.dart';
import '../../models/response/BillsResponse/BillerGroupsDetailsResponse.dart';
import '../../models/response/BillsResponse/BillerGroupsResponse.dart';
import '../../models/response/BillsResponse/BillerPackageResponse.dart';
import '../../models/response/BillsResponse/BillsCustomerLookUpResponse.dart';
import '../../models/response/BillsResponse/NetworkPlansResponse.dart';
import '../../models/response/SimpleApiResponse.dart';
import '../../utils/appUtil.dart';
import 'FormValidation.dart';

part 'bill_event.dart';
part 'bill_state.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  BillRepository repository;
  BillFormValidation formValidation  = BillFormValidation();
  BillBloc({required this.repository}) : super(BillInitial()) {
    on<BillEvent>((event, emit) {
    });
    on<BillGetNetworkProvidersEvents>((event, emit) {
      handleNetworkFetch(event);
    });
    on<BillPostVendEvents>((event, emit) {
      handleVend(event);
    });
    on<BillGetBillerGroupsEvents>((event, emit) {
      handleBillerGroupsFetch(event);
    });
    on<BillGetBillerGroupsDetailsEvents>((event, emit) {
      handleBillerGroupDetailsFetch(event);
    });
    on<BillGetBillerPackageEvents>((event, emit) {
      handleBillerPackageFetch(event);
    });
    on<BillGetCustomerLookUpEvents>((event, emit) {
      handleBillerCustomerLookUP(event);
    });
    on<BillMakeBillsPaymentEvents>((event, emit) {
      handleMakeBillsPayment(event);
    });

  }

  handleNetworkFetch(event) async {
    emit(BillStateLoading());
    try {
      final response = await repository.getNetworkProviders();
      if (response is NetworkPlansResponse) {
        emit(BillNetworkProvidersSuccessState(response));
        AppUtils.debug("network fetched");
      }
      else{
        response as ApiResponse;
        emit(BillStateError(response));
        AppUtils.debug("error1");
      }
    }catch(e){
      emit(BillStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error2");
    }
  }

  handleVend(event) async {
    emit(BillStateLoading());
    try {
      final response = await repository.vend(event.request);
      if (response is SimpleResponse) {
        emit(BillVendSuccessState(response));
        AppUtils.debug("network fetched");
      }
      else{
        response as ApiResponse;
        emit(BillStateError(response));
        AppUtils.debug("error1");
      }
    }catch(e){
      emit(BillStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error2");
    }
  }

  handleBillerGroupsFetch(event) async {
    emit(BillStateLoading());
    try {
      final response = await repository.getBillerGroups();
      if (response is List<BillerGroupsResponse>) {
        emit(BillGetBillerGroupsSuccessState(response));
        AppUtils.debug("success response fetched");
      }
      else{
        response as ApiResponse2;
        emit(BillStateError2(response));
        AppUtils.debug("error1");
      }
    }catch(e){
      emit(BillStateError2(AppUtils.defaultErrorResponse2()));
      AppUtils.debug("error2");
    }
  }
  handleBillerGroupDetailsFetch(event) async {
    emit(BillStateLoading());
    try {
      final response = await repository.getBillerGroupsDetails(event.billerId);
      if (response is List<BillerGroupsDetailsResponse>) {
        emit(BillGetBillerGroupsDetailsSuccessState(response));
        AppUtils.debug("success response fetched");
      }
      else{
        response as ApiResponse2;
        emit(BillStateError2(response));
        AppUtils.debug("error1");
      }
    }catch(e){
      emit(BillStateError2(AppUtils.defaultErrorResponse2()));
      AppUtils.debug("error2");
    }
  }
  handleBillerPackageFetch(event) async {
    emit(BillStateLoading());
    try {
      final response = await repository.getBillerPackage(event.categorySlug);
      if (response is List<BillerPackageResponse>) {
        emit(BillGetBillerPackageSuccessState(response));
        AppUtils.debug("success response fetched");
      }
      else{
        response as ApiResponse2;
        emit(BillStateError2(response));
        AppUtils.debug("error1");
      }
    }catch(e){
      emit(BillStateError2(AppUtils.defaultErrorResponse2()));
      AppUtils.debug("error2");
    }
  }

  handleBillerCustomerLookUP(event) async {
    emit(BillStateLoading());
    try {
      final response = await repository.getBillerCustomerLookUp(event.request);
      if (response is BillsCustomerLookUpResponse) {
        emit(BillGetBillerCustomerLookUPSuccessState(response));
        AppUtils.debug("success response fetched");//BillsCustomerLookUpResponse
      }
      else{
        response as ApiResponse;
        emit(BillStateError(response));
        AppUtils.debug("error1");
      }
    }catch(e){
      emit(BillStateError2(AppUtils.defaultErrorResponse2()));
      AppUtils.debug("error2");
    }
  }
  handleMakeBillsPayment(event) async {
    emit(BillStateLoading());
    try {
      final response = await repository.postMakeBillPayment(event.request.encryptedRequest());
      if (response is BillMakeBillsPaymentResponse) {
        emit(BillMakeBillsPaymentSuccessState(response));
        AppUtils.debug("success response fetched");//BillsCustomerLookUpResponse
      }
      else{
        response as ApiResponse;
        emit(BillStateError(response));
        AppUtils.debug("make bill payment error");
      }
    }catch(e){
      emit(BillStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("make bill payment exception error");
    }
  }

  initial(){
    emit(BillInitial());
  }


}
