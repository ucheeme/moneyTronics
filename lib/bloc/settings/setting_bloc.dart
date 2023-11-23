import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../Repository/SettingsRepository.dart';
import '../../Utils/appUtil.dart';
import '../../models/requests/AccountTierUpgradeRequest.dart';
import '../../models/requests/ChangePasswordRequest.dart';
import '../../models/requests/DeviceRegistrationRequest.dart';
import '../../models/requests/ForgotPasswordOtpRequest.dart';
import '../../models/requests/ForgotPasswordRequest.dart';
import '../../models/requests/ResetTransactionPinRequest.dart';
import '../../models/requests/SendOtpRequest.dart';
import '../../models/response/ApiResponse.dart';
import '../../models/response/BvnInfoResponse.dart';
import '../../models/response/ForgotPasswordOtpResponse.dart';
import '../../models/response/SecurityQuestionsResponse.dart';
import '../../models/response/SimpleApiResponse.dart';
import 'SettingsFormValidation.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
   var passwordSettingsFormValidation = PasswordSettingsFormValidation();
   final SettingsRepository repository;
   SettingBloc({required this.repository}) :
         super(SettingInitial()) {
      on<SettingEvent>((event, emit) {
      });
      on<SettingResetPasswordEvent>((event, emit) {
        handleResetPassword(event);
      });
      on<SettingsForgotPasswordEvent>((event, emit) {
        handleForgotPassword(event);
      });
      on<SettingChangePasswordEvent>((event, emit) {
        handleChangePassword(event);
      });
      on<SettingSecurityQuestionsEvent>((event, emit) {
        handleSecurityQuestionListEvents(event);
      });
      on<SettingSendOtpEvent>((event, emit) {
        handleSendOtpEvents(event);
      });
      on<SettingResetTpinEvent>((event, emit) {
        handleTransactionPinReset(event);
      });
      on<SettingsDeviceRegistrationEvent>((event, emit) {
        handleDeviceRegistrationEvent(event);
      });

      on<SettingBvnInfoEvent>((event, emit) {
        handleBvnInfoEvent(event);
      });
      on<SettingAccountUpgradeEvent>((event, emit) {
        handleAccountTierUpgrade(event);
      });
   }

   handleChangePassword(event) async {
    emit(SettingStateLoading());
    try {
      final response = await repository.changePassword(event.request);
      if (response is SimpleResponse) {
        emit(const SettingChangePasswordState());
        AppUtils.debug("change password successful");
      }else{
        response as ApiResponse;
        emit(SettingStateError(response));
        AppUtils.debug("error");
      }
    }catch(e) {
      emit(SettingStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }

   handleForgotPassword(event) async {
     emit(SettingStateLoading());
     try {
       final response = await repository.forgotPassword(event.request);
       if (response is ForgotPasswordOtpResponse) {
         emit(SettingForgotPasswordOtpState(response));
         AppUtils.debug("forgot password otp sent");
       }else{
         response as ApiResponse;
         emit(SettingStateError(response));
         AppUtils.debug("error");
       }
     }catch(e) {
       emit(SettingStateError(AppUtils.defaultErrorResponse()));
       AppUtils.debug("error");
     }
   }

   handleResetPassword(event) async {
     emit(SettingStateLoading());
     try {
       final response = await repository.resetPassword(event.request);
       if (response is SimpleResponse) {
         emit(SettingForgotPasswordState(response));
         AppUtils.debug("change password successful");
       }else{
         response as ApiResponse;
         emit(SettingStateError(response));
         AppUtils.debug("error");
       }
     }catch(e) {
       emit(SettingStateError(AppUtils.defaultErrorResponse()));
       AppUtils.debug("error");
     }
   }

   handleSecurityQuestionListEvents(event) async {
     emit(SettingStateLoading());
     try {
       final response = await repository.getSecurityQuestion( );
       if (response is List<SecurityQuestion>) {
         emit(SettingsSecurityQuestionState(response));
         AppUtils.debug("security question fetched");
       }else{
         response as ApiResponse;
         emit(SettingStateError(response));
         AppUtils.debug("error");
       }
     }catch(e) {
       emit(SettingStateError(AppUtils.defaultErrorResponse()));
       AppUtils.debug("error");
     }
   }

   handleSendOtpEvents(event) async {
     emit(SettingStateLoading());
     try {
       final response = await repository.sendOtp(event.request);
       if (response is SimpleResponse) {
         emit(SettingOtpSentState(response));
         AppUtils.debug("Otp sent");
       }else{
         response as ApiResponse;
         emit(SettingStateError(response));
         AppUtils.debug("error");
       }
     }catch(e) {
       emit(SettingStateError(AppUtils.defaultErrorResponse()));
       AppUtils.debug("error");
     }
   }

   handleTransactionPinReset(event) async {
     emit(SettingStateLoading());
     try {
       final response = await repository.resetTransactionPin(event.request);
       if (response is SimpleResponse) {
         emit(SettingResetTransactionPinState(response));
         AppUtils.debug("Transaction pin reset successful");
       }else{
         response as ApiResponse;
         emit(SettingStateError(response));
         AppUtils.debug("error");
       }
     }catch(e) {
       emit(SettingStateError(AppUtils.defaultErrorResponse()));
       AppUtils.debug("error");
     }
   }

   handleDeviceRegistrationEvent(event) async {
     emit(SettingStateLoading());
     try {
       final response = await repository.deviceRegistration(event.request);
       if (response is SimpleResponse) {
         emit(SettingDeviceRegistrationState(response));
         AppUtils.debug("Transaction pin reset successful");
       }else{
         response as ApiResponse;
         emit(SettingStateError(response));
         AppUtils.debug("error");
       }
     }catch(e) {
       emit(SettingStateError(AppUtils.defaultErrorResponse()));
       AppUtils.debug("error");
     }
   }
   initial(){
     emit(SettingInitial());
   }

  void handleBvnInfoEvent(SettingBvnInfoEvent event) async{
    emit(SettingStateLoading());
    try {
      final response = await repository.bvnInfo();
      if (response is BvnInfoResponse) {
        emit(SettingBvnInfoState(response));
        AppUtils.debug("Bvn info url fetched");
      }else{
        response as ApiResponse;
        emit(SettingStateError(response));
        AppUtils.debug("error");
      }
    }catch(e) {
      emit(SettingStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
   void handleAccountTierUpgrade(event) async{
     emit(SettingStateLoading());
     try {
       final response = await repository.accountTierUpgrade(event.request);
       if (response is BvnInfoResponse) {
         emit(SettingBvnInfoState(response));
         AppUtils.debug("Bvn info url fetched");
       }else{
         response as ApiResponse;
         emit(SettingStateError(response));
         AppUtils.debug("error");
       }
     }catch(e) {
       emit(SettingStateError(AppUtils.defaultErrorResponse()));
       AppUtils.debug("error");
     }
   }
}
