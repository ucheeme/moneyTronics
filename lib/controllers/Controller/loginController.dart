import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';

import '../../UiUtil/Alerts/AlertDialog.dart';
import '../../UiUtil/customWidgets.dart';
import '../../cubits/loginCubit/login_user_cubit.dart';
import '../../models/requests/LoginRequest.dart';
import '../../models/response/LoginResponse.dart';
import '../../repository/DashboardRepository.dart';
import '../../utils/userUtil.dart';
import '../../views/appScreens/bottomNav.dart';
import '../../views/appScreens/settings/device_registration.dart';
import '../../views/startScreen/login/loginFirstTime.dart';

class LoginController extends GetxController{

   var goToLoginSubject = PublishSubject<bool>();
  TextEditingController userNameControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  late LoginUserCubit cubit;
  final LocalAuthentication auth = LocalAuthentication();
  var canAuthenticateWithBiometrics = false;
  var biometricEnabled = false;

  void stateChecker(LoginUserState state, BuildContext context) {

    if (state is LoginUserSuccessState){
      loginResponse = state.response;
      loginRequest ??= cubit.validation.loginValidation(context);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
          // Navigator.push(context, MaterialPageRoute(builder: (context)
          // => const BottomNavigator()));
          if (biometricEnabled){
           openHome(context);
            return;
          }
          openBottomSheet(isDismissible: false, context, CustomAlertDialog(showIcon: true, body: "Do you want to use your biometric when next you log in",
              proceedText: "Yes, Enable",
              declineText: "No, Don't",
              proceed: () async{
                await SharedPref.saveBool(SharedPrefKeys.enableBiometric, true).then((value) => openHome(context));
              },
              decline: (){
                openHome(context);
              })
          );
          // bloc.initial();
          cubit.resetState();
        });
      });
    }
    if (state is LoginIncompleteRegistration){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
          DashboardRepository().getUsersAccount();
          cubit.resetState();
        });
      });
    }
    if (state is LoginDeviceChangeState){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, (){
          openDeviceManagement(context);
          cubit.resetState();
        });
      });
    }
    // if (state is LoginUserErrorState){
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Future.delayed(Duration.zero, (){
    //        DashboardRepository().getUsersAccount();
    //       cubit.resetState();
    //     });
    //   });
    // }

  }

  void openHome(context){
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigator(),
      ), (Route<dynamic> route) => false,);
  }
  void openDeviceManagement(context) async{
    await Navigator.push(context,
        MaterialPageRoute(
          builder: (context) =>  DeviceRegistrationScreen(username:
          cubit.validation.loginValidation(context).clientId),
        )).then((value){
      print("poppped");
      if (value == true){
      // cubit.add(LoginEventLoginUser(bloc.validation.loginValidation()));
       cubit.handleLoginEvent(cubit.validation.loginValidation(context));
      }
    });
  }
}