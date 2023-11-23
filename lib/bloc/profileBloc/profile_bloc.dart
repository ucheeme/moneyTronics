import 'dart:async';

import 'package:bloc/bloc.dart';


import 'package:equatable/equatable.dart';

import '../../Utils/appUtil.dart';
import '../../models/requests/ProductCode.dart';
import '../../models/response/ApiResponse.dart';
import '../../models/response/CreateAdditionalAccountResponse.dart';
import '../../models/response/FinedgeProduct.dart';
import '../../models/response/SimpleApiResponse.dart';
import '../../repository/ProfileRepository.dart';
import 'ProfileFormValidation.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository repository;
  ProfileFormValidation formValidation = ProfileFormValidation();
  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<ProfileCustomerDetailsEvent>((event, emit) {
      handleCustomerDetailEvent(event);
    });
    on<ProfileBankProductEvent>((event, emit) {
      handleBankProductEvent(event);
    });
    on<ProfileCreateAdditionalAccountEvent>((event, emit) {
      handleCreateAccountRequest(event);
    });
  }

  handleCustomerDetailEvent(event) async {
    emit(ProfileStateLoading());
    try {
      final response = await repository.getCustomerDetails();
      if (response is SimpleResponse) {
        emit(ProfileCustomerDetailState(response));
        AppUtils.debug("Customer details fetched");
      }else{
        response as ApiResponse;
        emit(ProfileStateError(response));
        AppUtils.debug("error");
      }
    }catch(e) {
      emit(ProfileStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }

  handleCreateAccountRequest(event) async {
    emit(ProfileStateLoading());
    try {
      final response = await repository.createAdditionalAccount(event.request);
      if (response is CreateAdditionalAccountResponse) {
        emit(ProfileCreateAdditionalAccountState(response));
        AppUtils.debug("bank products fetched");
      } else {
        response as ApiResponse;
        emit(ProfileStateError(response));
        AppUtils.debug("error");
      }
    }catch(e) {
      emit(ProfileStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }

  handleBankProductEvent(event) async {
    emit(ProfileStateLoading());
    try {
      final response = await repository.getProduct();
      if (response is List<FinedgeProduct>) {
        emit(ProfileBankProductState(response));
        AppUtils.debug("bank products fetched");
      }else{
        response as ApiResponse;
        emit(ProfileStateError(response));
        AppUtils.debug("error");
      }
    }catch(e) {
      emit(ProfileStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  initial(){
    emit(ProfileInitial());
  }
}
