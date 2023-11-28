import 'dart:async';

import 'package:bloc/bloc.dart';


import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

import '../../ApiService/ApiService.dart';
import '../../cubits/loginCubit/loginFormValidation.dart';
import '../../models/requests/LoginRequest.dart';
import '../../models/response/ApiResponse.dart';
import '../../models/response/LoginResponse.dart';
import '../../repository/AuthRepo.dart';
import '../../utils/appUtil.dart';
import '../../utils/constants/Constants.dart';
import '../../utils/userUtil.dart';




part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepo repository;
  String loadingTitle = Constants.loginTitleLoadingMessage;
  String loadingDescription = Constants.loginDescriptionLoadingMessage;
  var errorObs = PublishSubject<String>();
  LoginFormValidation validation = LoginFormValidation();
  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
    });
    on<LoginEventLoginUser>((event, emit) {
      handleLoginEvent(event);
    });
  }
  initial(){
    emit(LoginInitial());
  }
  handleLoginEvent(event) async {
    emit(LoginStateLoading());
    try {
      final response = await repository.login(event.request );
      if (response is LoginResponse) {
        accessToken = response.token ?? "";
        SharedPref.save(SharedPrefKeys.loginRequestInfo,
            event.request.toJson());
        emit(LoginSuccessfulState(response));
        AppUtils.debug("login successful");
      }else{
        response as ApiResponse;
       if(response.result?.message?.toLowerCase() == "New device detected".toLowerCase() ||
       response.result?.message?.toLowerCase() == "Device details not found".toLowerCase() ) {
        emit(LoginDeviceChangeState()); return;
       }
        errorObs.add(response.result?.message ?? "");
        emit(LoginStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      errorObs.add("error occurred");
      emit(LoginStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
}

