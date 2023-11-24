import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as gett;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:local_auth/local_auth.dart';
import 'package:moneytronic/cubits/loginCubit/login_user_cubit.dart';
import 'package:moneytronic/views/startScreen/signUpScreen/signUpScreen.dart';

import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/passwordTextField.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../controllers/Controller/loginController.dart';
import '../../../models/requests/LoginRequest.dart';
import '../../../models/response/LoginResponse.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';
import '../../../utils/constants/text.dart';
import '../../../utils/userUtil.dart';
import '../../appScreens/bottomNav.dart';
import '../loginOrSignUpScreen.dart';
import 'ForgotPasswordScreen.dart';


LoginResponse? loginResponse;
LoginRequest? loginRequest;
class LoginFirstTime extends StatefulWidget {
  const LoginFirstTime({super.key});
  @override
  State<LoginFirstTime> createState() => _LoginFirstTimeState();
}

class _LoginFirstTimeState extends State<LoginFirstTime> implements PostWidgetCallback {
 var controller = Get.put(LoginController());
 initBiometric() async {
   controller.canAuthenticateWithBiometrics = await controller.auth.canCheckBiometrics;
   await _getSavedValidateUserRequest();
   controller.biometricEnabled =   await SharedPref.getBool(SharedPrefKeys.enableBiometric);
   final List<BiometricType> availableBiometrics =
   await controller.auth.getAvailableBiometrics();
   if (controller.canAuthenticateWithBiometrics && controller.biometricEnabled) {
     if (availableBiometrics.isNotEmpty) {
       if (availableBiometrics.contains(BiometricType.weak) ||
           availableBiometrics.contains(BiometricType.strong) || availableBiometrics.contains(BiometricType.fingerprint)) {
         AppUtils.debug("available biometric weak or strong");
       } else {
         AppUtils.debug("available biometric face");
       }
     }
   }
   setState(() {});
 }
 _getSavedValidateUserRequest() async {
   try {
     var userPref = await SharedPref.read(SharedPrefKeys.loginRequestInfo);
     loginRequest = LoginRequest.fromJson(userPref);
    controller.userNameControl.text = loginRequest?.clientId ?? "";
     controller.cubit.validation.setClientId(loginRequest?.clientId ?? "");
   } catch (e) {
     AppUtils.debug("could not get login request $e");
   }
 }
 _authenticateWithBiometric() async {
   try {
     final bool didAuthenticate = await controller.auth.authenticate(
         localizedReason: 'Please authenticate to login');
     if (didAuthenticate){
       if (loginRequest != null) {
         controller.cubit.handleLoginEvent(loginRequest!);
       }
     }
   } on PlatformException {
     // ...
   }
 }

 @override
 void initState() {
   super.initState();
   _getSavedValidateUserRequest();
   initBiometric();
 }

  @override
  Widget build(BuildContext context) {
    controller.cubit = context.read<LoginUserCubit>();
    controller.cubit.errorObs.listen((value){
         AppUtils.showSnack(value, context);
      });
    return darkStatusBar(
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocBuilder<LoginUserCubit, LoginUserState>(
          builder: (context, state) {
           controller.stateChecker(state, context);
            return     AppUtils().loadingWidget2(
              context: context,
              isLoading: state is LoginUserLoadingState,
              child: Scaffold(
                backgroundColor: AppColors.whiteFA,
                body: Column(
                  children: [
                  SizedBox(
                    child: appBarBackAndImg(title: AppStrings.logInHeaderText,
                        //subText: AppStrings.logInSubText,
                        backTap: (){ Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                            const LoginOrSignUpScreen()
                              //  const Login()
                            ));
                        }),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ctmTxtGroteskMid(AppStrings.logInHeaderText,
                              weight: FontWeight.w800,
                              AppColors.black33, 18.sp,maxLines: 1,textAlign: TextAlign.start),
                          gapH(20.0),
                          ctmTxtGroteskMid(AppStrings.logInSubText,
                              AppColors.black33, 16.sp,maxLines: 2,textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                  Expanded(child:
                  Padding(
                    padding: screenPadding(),
                    child: SingleChildScrollView(
                      child: Column(children: [
                      gapHeight(30.h),
                      StreamBuilder<String>(
                          stream: controller.cubit.validation.clientId,
                          builder: (context, snapshot) {
                            return CustomTextFieldWithValidation(
                              controller: null,
                              title: AppStrings.enterUserNameEmail,
                              details: "",
                              inputType: TextInputType.text,
                              onChange:controller.cubit.validation.setClientId,
                              error: snapshot.hasError ? snapshot.error.toString() : "",);
                          }
                      ),
                     // gapHeight(28.h),
                      StreamBuilder<String>(
                          stream:  controller.cubit.validation.clientSecret,
                          builder: (context, snapshot) {
                            return PasswordTextField(
                              controller: controller.passwordControl,
                              title: AppStrings.enterPassword,
                              onChange: controller.cubit.validation.setClientSecret,
                              error: snapshot.hasError ? snapshot.error.toString() : "",);
                          }
                      ),
                      gapHeight(30.h),
                      forgotPassword(tap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>
                        const ForgotPasswordScreen()));
                      })
                    ],),),
                  )),
                  gapHeight(28.h),
                  Row(
                    children: [
                      Expanded(
                        child: blueBtn(title: AppStrings.proceedText, tap: () {
                          controller.cubit.handleLoginEvent(controller.cubit.validation.loginValidation(context));
                          //controller.cubit.add(LoginEventLoginUser(bloc.validation.loginValidation(context)));
                        }),
                      ),
                      gapW(10.w),
                      controller.biometricEnabled ? GestureDetector(
                        onTap: (){
                          _authenticateWithBiometric();
                        },
                        child: Container(
                          margin: const EdgeInsets
                              .only(right: 20.0),
                          decoration: BoxDecoration(
                            color:AppColors.accent,// Customize the color of the indicator
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                                color: AppColors.primary,
                                width:0.5.r
                            ),// Customize the border radius
                          ),
                          width: 50.w,
                          height: 55.h,
                          child: Center(child: Image.asset("assets/png/icons/face_scan.png", width: 20.w,
                            height: 20.h, color: AppColors.primary,)),),
                      ) : gapW(1.0)
                    ],
                  ),
                  gapHeight(20.h),
                  doNotHaveAccount(tap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    const SignUpScreen()));
                  }),
                  gapHeight(70.h),
                ],),
              ),
            );
          },
        ),
      ),
    );
  }


  @override
  postWidgetBuild(Function() proceed) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, (){
        proceed;
      });
    });
  }
}

