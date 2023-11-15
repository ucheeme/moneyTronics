import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as gett;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:moneytronic/cubits/loginCubit/login_user_cubit.dart';

import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/passwordTextField.dart';
import '../../../controllers/Controller/loginController.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';
import '../../../utils/constants/text.dart';
import '../../appScreens/bottomNav.dart';
import 'forgotPassword.dart';


class LoginFirstTime extends StatefulWidget {
  const LoginFirstTime({super.key});
  @override
  State<LoginFirstTime> createState() => _LoginFirstTimeState();
}

class _LoginFirstTimeState extends State<LoginFirstTime> implements PostWidgetCallback {
 var controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    controller.cubit = context.read<LoginUserCubit>();
    controller.cubit.errorObs.listen((value){
         AppUtils.showSnack(value, context);
      l});
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
                body: Column(children: [
                  appBarBackAndTxt(title: AppStrings.loginText,
                      backTap: () {
                        Navigator.pop(context);
                      }),
                  Expanded(child:
                  Padding(
                    padding: screenPadding(),
                    child: SingleChildScrollView(child: Column(children: [
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
                      gapHeight(28.h),
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
                  blueBtn(title: AppStrings.proceedText, tap: () {
                    controller.cubit.handleLoginEvent(controller.cubit.validation.loginValidation(context));
                 //  controller.cubit.add(LoginEventLoginUser(bloc.validation.loginValidation(context)));
                  }),
                  gapHeight(50.h),
                  doNotHaveAccount(tap: () {

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

