import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moneytronic/utils/appUtil.dart';
import 'package:rxdart/rxdart.dart';

import '../../repository/loginRepo/login_repo.dart';
import 'loginFormValidation.dart';

part 'login_user_state.dart';

class LoginUserCubit extends Cubit<LoginUserState> {
  final LoginRepository repository;
  LoginUserCubit({required this.repository}) : super(LoginUserInitialState());
  var errorObs = PublishSubject<String>();
  LoginFormValidation validation = LoginFormValidation();
  void loginUser(String userName, String password)async{
    try{
      emit(LoginUserInitialState());


    }catch(e, trace){
      logReport(e);
      logReport(trace);
    }

  }

  void resetState(){
    emit(LoginUserInitialState());
  }
}
