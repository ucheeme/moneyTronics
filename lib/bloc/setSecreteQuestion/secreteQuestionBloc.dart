import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneytronic/bloc/setSecreteQuestion/secreteQuestionEvent.dart';
import 'package:moneytronic/bloc/setSecreteQuestion/secreteQuestionState.dart';
import '../../models/response/ApiResponse.dart';
import '../../models/response/SecurityQuestionsResponse.dart';
import '../../models/response/SimpleApiResponse.dart';
import '../../repository/securityQuestionTransactionPInRepo.dart';
import '../../utils/appUtil.dart';
import 'SecurityTransPinFormValidation.dart';

class SetSecreteQuestionBloc extends Bloc<SecretQuestEvent, SecreteQuestionState> {
  final SecurityQuestionTransactionPinRepository repository;
  SecurityQuestionFormValidation validation = SecurityQuestionFormValidation();
  SetSecreteQuestionBloc({required this.repository}) : super(SecreteQuestionInitial()) {
    on<SecretQuestEvent>((event, emit) {
    });
    on<SecurityQuestionsEvent>((event, emit) {
      handleSecurityQuestionListEvents(event);
    });
    on<SetSecurityQuestionEvent>((event, emit) {
      handleSetSecurityQuestion(event);
    });
  }
  handleSecurityQuestionListEvents(event) async {
    emit(SecreateQuestionStateLoading());
    try {
      final response = await repository.getSecurityQuestion( );
      if (response is List<SecurityQuestion>) {
        emit(SecurityQuestionState(response));

      }else{
        response as ApiResponse;
        emit(SecreateQuestionStateError(response));
        AppUtils.debug("error");
      }
    }catch(e) {
      emit(SecreateQuestionStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
  handleSetSecurityQuestion(event) async {
    emit(SecreateQuestionStateLoading());
    try {
      final response = await repository.setSecurityQuestion(event.request);
      if (response is SimpleResponse) {
        emit(SetSecurityQuestionState(response));
        AppUtils.debug("security question set successfully");
      }else{
        response as ApiResponse;
        emit(SecreateQuestionStateError(response));
        AppUtils.debug("error");
      }
    }catch(e){
      emit(SecreateQuestionStateError(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
}
