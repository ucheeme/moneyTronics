import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../cubits/loginCubit/login_user_cubit.dart';
import '../../models/requests/LoginRequest.dart';
import '../../models/response/LoginResponse.dart';
import '../../views/appScreens/bottomNav.dart';

class LoginController extends GetxController{
  LoginResponse? loginResponse;
  LoginRequest? loginRequest;
   var goToLoginSubject = PublishSubject<bool>();
  TextEditingController userNameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  late LoginUserCubit cubit;

  void stateChecker(LoginUserState state, BuildContext context) {
    if (state is LoginUserSuccessState){
      loginResponse = state.response;
      loginRequest = cubit.validation.loginValidation(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
          Navigator.push(context, MaterialPageRoute(builder: (context)
          => const BottomNavigator()));
          cubit.resetState();
        });
      });
    }
    if (state is LoginUserErrorState){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
          // DashboardRepository().getUsersAccount();
          cubit.resetState();
        });
      });
    }
  }
}