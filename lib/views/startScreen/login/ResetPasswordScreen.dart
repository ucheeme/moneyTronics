

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



import '../../../UiUtil/bottomsheet/simpleSuccessAlertBottomSheet.dart';
import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/passwordTextField.dart';
import '../../../Utils/constants/Themes/colors.dart';
import '../../../bloc/settings/setting_bloc.dart';
import '../../../models/response/SecurityQuestionsResponse.dart';
import '../../../utils/appUtil.dart';
import 'loginFirstTime.dart';


class ResetPasswordScreen extends StatefulWidget {
  
  
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late SettingBloc bloc;
  TextEditingController selectedQuestionControl = TextEditingController();
  TextEditingController questionResponseControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();

  final List<SecurityQuestion> securityQuestions = [];

  @override
  Widget build(BuildContext context) {
    bloc = context.read<SettingBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<SettingBloc, SettingState>(
  builder: (context, state) {
    if (state is SettingForgotPasswordState){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(Duration.zero, (){
          _receiptBottomSheet();
          bloc.initial();
        });
      });
    }
    return AppUtils().loadingWidget2(
      context: context,
      isLoading: state is SettingStateLoading,
      child: Scaffold(resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.whiteFA,
        bottomSheet: SizedBox(
          height: 150.h,
          child: Center(
            child:   StreamBuilder<bool>(
                stream: bloc.passwordSettingsFormValidation.validateResetPasswordForm,
                builder: (context, snapshot) {
                  return snapshot.hasData && snapshot.data == true ? blueBtn(title: 'Proceed', tap: () {
                    bloc.add(SettingResetPasswordEvent(bloc.passwordSettingsFormValidation.resetPasswordRequest()));
                  }) : disabledBtn(title: 'Proceed');
                }
            ),
          ),
        ),
          body: Column(children: [
            appBarBackAndTxt(title: "Enter password",
                backTap: (){Navigator.pop(context);}),
            Expanded(child:
            Padding(
              padding: screenPadding(),
              child: SingleChildScrollView(child: Column(children: [
                gapH(30.h),
                StreamBuilder<String>(
                  stream: bloc.passwordSettingsFormValidation.otpStream,
                  builder: (context, snapshot) {
                    return CustomTextFieldWithValidation(
                      controller: null, title: "Enter otp",
                      details: "", inputType:TextInputType.text,
                      onChange: bloc.passwordSettingsFormValidation.setOtp,
                      error: snapshot.hasError ? snapshot.error.toString() : "",
                    );
                  }
                ),
                gapH(28.h),
                StreamBuilder<String>(
                  stream: bloc.passwordSettingsFormValidation.passwordStream,
                  builder: (context, snapshot) {
                    return PasswordTextField(
                      controller: passwordControl,
                      title: "Enter new password",
                        onChange: bloc.passwordSettingsFormValidation.setPassword,
                        error: snapshot.hasError ? snapshot.error.toString() : "",
                    );
                  }
                ),
                gapH(28.h),
                StreamBuilder<String>(
                  stream: bloc.passwordSettingsFormValidation.confirmPasswordStream,
                  builder: (context, snapshot) {
                    return PasswordTextField(
                      controller: confirmPasswordControl,
                      title: "Confirm new password",
                      onChange: bloc.passwordSettingsFormValidation.setConfirmPassword,
                      error: snapshot.hasError ? snapshot.error.toString() : "",);
                  }
                ),
                gapH(30.h),
                MediaQuery.of(context).viewInsets.bottom > 0.0 ?
                gapH(50.h): gapH(300.h),// if keyboard is open
                ],
               ),
              ),
            )),
          ],),
        ),
    );
  },
),
    );
  }
  _receiptBottomSheet() {
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        context: context,
        builder: (context) => SafeArea(
          child: Container(height: 700.h,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child:  SimpleSuccessAlertBottomSheet(
                  isSuccessful: true, type: "Password changed",
                  description: "Password changed successfully",
                  accountBtn: "Back to login",
                  returnTap: (){   Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  const LoginFirstTime()));})
          ),
        )
    );
  }
}
