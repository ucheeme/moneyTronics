import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moneytronic/models/response/LoginResponse.dart';
import 'package:moneytronic/utils/appUtil.dart';
import 'package:rxdart/rxdart.dart';

import '../../ApiService/ApiService.dart';
import '../../models/response/ApiResponse.dart';
import '../../repository/loginRepo/login_repo.dart';
import '../../utils/constants/Constants.dart';
import 'loginFormValidation.dart';

part 'login_user_state.dart';

class LoginUserCubit extends Cubit<LoginUserState> {
  final LoginRepository repository;
  String loadingTitle = Constants.loginTitleLoadingMessage;
  String loadingDescription = Constants.loginDescriptionLoadingMessage;
  var errorObs = PublishSubject<String>();
  LoginFormValidation validation = LoginFormValidation();
  LoginUserCubit({required this.repository}) : super(LoginUserInitialState());
  void loginUser(String userName, String password)async{
    try{
      emit(LoginUserInitialState());


    }catch(e, trace){
      logReport(e);
      logReport(trace);
    }

  }
  handleLoginEvent(event) async {
    emit(LoginUserLoadingState());
    try {
      final response = await repository.login(event.request);
      if (response is LoginResponse) {
        accessToken = response.token ?? "";
        emit(LoginUserSuccessState(response));
        AppUtils.debug("login successful");
      } else {
        response as ApiResponse;
        errorObs.add(response.result?.message ?? "");
        emit(LoginUserErrorState( response));
        AppUtils.debug("error");
      }
    } catch (e) {
      errorObs.add("error occurred");
      emit(LoginUserErrorState(AppUtils.defaultErrorResponse()));
      AppUtils.debug("error");
    }
  }
    void resetState(){
    emit(LoginUserInitialState());
  }
}
