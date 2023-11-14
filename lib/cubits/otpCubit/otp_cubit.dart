import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/response/AccountNumberResponse.dart';
import '../../models/response/ApiResponse.dart';
import '../../repository/AuthRepo.dart';
import '../../utils/appUtil.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {

  final AuthRepo authRepository;

  OtpCubit({required this.authRepository}) : super(OtpInitial());
  void setPinCode(String value) async{
    if (value.length == 5){
      emit(OtpCompleteState(value));
    }
  }

  void setFourDigitPinCode(String value) async{
    if (value.length == 4){
      emit(OtpCompleteState(value));
    }
  }

  void completeRegistration(otp) async {
    try {
      emit( OtpLoadingState() );
      final response = await authRepository.verifyRegistration(otp);
      if (response is AccountNumberResponse) {
        emit(OtpAccountCreatedState(response));
        AppUtils.debug("success");
      }else{
        emit(OtpErrorState(response as ApiResponse));
        AppUtils.debug("error");
      }
    } catch (e) {
      emit(OtpErrorState(AppUtils.defaultErrorResponse()));
    }
  }
  //
  // void validatePin(request) async {
  //   try {
  //     emit( OtpLoadingState());
  //     final response = await authRepository.validatePin(request);
  //     if (response is ApiResponse) {
  //       emit(PinVerifiedState(response));
  //       AppUtils.debug("success");
  //     }else{
  //       emit(OtpErrorState(response as ApiResponse));
  //       AppUtils.debug("error");
  //     }
  //   } catch (e) {
  //     emit(OtpErrorState(AppUtils.defaultErrorResponse()));
  //   }
  // }
  // void sendOtp(email) async {
  //   try {
  //     emit( OtpLoadingState() );
  //     final response = await authRepository.sendOtp(email);
  //     if (response is ApiResponse) {
  //       emit(OtpSentState(response));
  //       AppUtils.debug("success");
  //     }else{
  //       emit(OtpErrorState(response as ApiResponse));
  //       AppUtils.debug("error");
  //     }
  //   } catch (e) {
  //     emit(OtpErrorState(AppUtils.defaultErrorResponse()));
  //   }
  // }
  //
  void initialState() {
    emit( OtpInitial() );
  }
}

