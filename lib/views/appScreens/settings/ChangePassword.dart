

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Bloc/settings/setting_bloc.dart';
import '../../../UiUtil/bottomsheet/simpleSuccessAlertBottomSheet.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/passwordTextField.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late SettingBloc bloc;
  TextEditingController oldPasswordControl = TextEditingController();
  TextEditingController newPasswordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bloc = context.read<SettingBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {

          if (state is SettingStateError){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                AppUtils.showSnack(state.errorResponse.result?.message ?? "", context);
                bloc.initial();
              });
            });
          }
          if (state is SettingChangePasswordState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                nonDismissibleBottomSheet(context,
                    SimpleSuccessAlertBottomSheet(
                        isSuccessful: true, type: "Successful",
                        description: "Password changed successfully",
                        accountBtn: "Close",
                        returnTap: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }));
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
                      stream: bloc.passwordSettingsFormValidation.validateChangePasswordPasswordForm,
                      builder: (context, snapshot) {
                        return snapshot.hasData && snapshot.data == true ? blueBtn(title: 'Proceed', tap: () {
                          bloc.add(SettingChangePasswordEvent(bloc.passwordSettingsFormValidation.changePasswordRequest()));
                        }) : disabledBtn(title: 'Proceed');
                      }
                  ),
                ),
              ),
              body: Column(children: [
                appBarBackAndTxt(title: "Change password", backTap: (){Navigator.pop(context);}),
                Expanded(child:
                Padding(
                  padding: screenPadding(),
                  child: SingleChildScrollView(child: Column(children: [
                    gapH(30.h),
                    StreamBuilder<String>(
                        stream: bloc.passwordSettingsFormValidation.passwordStream,
                        builder: (context, snapshot) {
                          return PasswordTextField(
                            controller: oldPasswordControl,
                            title: "Enter current password",
                            onChange: bloc.passwordSettingsFormValidation.setPassword,
                            error: snapshot.hasError ? snapshot.error.toString() : "",
                          );
                        }
                    ),
                    gapH(28.h),
                    StreamBuilder<String>(
                        stream: bloc.passwordSettingsFormValidation.newPasswordStream,
                        builder: (context, snapshot) {
                          return PasswordTextField(
                            controller: newPasswordControl,
                            title: "Enter new password",
                            onChange: bloc.passwordSettingsFormValidation.setNewPassword,
                            error: snapshot.hasError ? snapshot.error.toString() : "",
                          );
                        }
                    ),
                    gapH(28.h),
                    StreamBuilder<String>(
                        stream: bloc.passwordSettingsFormValidation.confirmNewPasswordStream,
                        builder: (context, snapshot) {
                          return PasswordTextField(
                            controller: confirmPasswordControl,
                            title: "Confirm new password",
                            onChange: bloc.passwordSettingsFormValidation.setNewConfirmPassword,
                            error: snapshot.hasError ? snapshot.error.toString() : "",);
                        }
                    ),
                    gapH(30.h),
                    MediaQuery.of(context).viewInsets.bottom > 0.0 ?
                    gapH(50.h): gapH(300.h),
                  ],),),
                )),
              ],),
            ),
          );
        },
      ),
    );
  }
}
