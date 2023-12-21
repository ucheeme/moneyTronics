import 'dart:async';



import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moneytronic/bloc/AuthBloc/LoginFormValidation.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/requests/CreateAccountRequest.dart';
import '../../models/requests/CreateExistingUserRequest.dart';
import '../../models/requests/ValidateExistingUserRequest.dart';
import '../../models/response/AccountNumberResponse.dart';
import '../../models/response/ApiResponse.dart';
import '../../models/response/CreaterExistingUserResponse.dart';
import '../../models/response/SecurityQuestionsResponse.dart';
import '../../models/response/validateExistingUserAccountResponsse.dart';
import '../../repository/AuthRepo.dart';
import '../../utils/appUtil.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepo repository;
  CreateUserFormValidation validation = CreateUserFormValidation();
  AuthBloc({required this.repository})  : super(AuthInitial()) {
    on<AuthEventCreateUser>((event, emit) async {
      handleAccountCreateEvent(event);
    });
    on<AuthEventValidateExistingBVN>((event, emit) async {
      handleValidateBvnEvent(event);
    });
    on<SecurityQuestionsEvent>((event, emit) {
      handleSecurityQuestionListEvents(event);
    });
    on<AuthEventCreateExistingUser>((event, emit) async {
      handleCreateExistingUserEvent(event);
    });
  }

initial(){
    emit(AuthInitial());
}


  handleAccountCreateEvent(event) async{
    emit(AuthStateLoading());
    try {
      final response = await repository.createUser(event.request );
      if (response is AccountNumberResponse) {
        emit(AuthStateUserCreated(response));
        AppUtils.debug("success");
      }else{
        emit(AuthStateError(response as ApiResponse));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(AuthStateError(AppUtils.defaultErrorResponse()));
    }
  }
  handleValidateBvnEvent(event) async{
    emit(AuthStateLoading());
    try {
      final response = await repository.validateBvnExistingUser(event.request );
      if (response is ValidateExistingUserAccountResponse) {
        emit(AuthStateValidateExistingBVN(response));
        AppUtils.debug("success");
      }else{
        emit(AuthStateError(response as ApiResponse));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(AuthStateError(AppUtils.defaultErrorResponse()));
    }
  }
  handleSecurityQuestionListEvents(event) async {
    emit(AuthStateLoading());
    try {
      final response = await repository.getSecurityQuestion( );
      if (response is List<SecurityQuestion>) {
        emit(SecurityQuestionState(response));
        AppUtils.debug("login successful");
      }else{
        response as ApiResponse;
        emit(AuthStateError(response));
        AppUtils.debug("error1");
      }
    }catch(e) {
      emit(AuthStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  handleCreateExistingUserEvent(event) async{
    emit(AuthStateLoading());
    try {
      final response = await repository.createExistingUser(event.request);
      if (response is CreateExistingUserResponse) {
        emit(AuthStateCreateExisting(response));
        AppUtils.debug("success");
      }else{
        emit(AuthStateError(response as ApiResponse));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(AuthStateError(AppUtils.defaultErrorResponse()));
    }
  }


}


