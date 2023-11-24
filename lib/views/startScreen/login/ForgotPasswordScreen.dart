import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../Utils/constants/Themes/colors.dart';
import '../../../bloc/settings/setting_bloc.dart';
import '../../../models/response/SecurityQuestionsResponse.dart';
import '../../../utils/appUtil.dart';
import 'ResetPasswordScreen.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  late SettingBloc bloc;
  TextEditingController selectedQuestionControl = TextEditingController();
  TextEditingController questionResponseControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();
  final List<SecurityQuestion> securityQuestions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<SettingBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is SettingForgotPasswordOtpState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                const ResetPasswordScreen()));
                bloc.initial();
              });
            });
          }
          if (state is SettingStateError){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
               AppUtils.showSnack(state.errorResponse.result?.message ?? "", context);
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
                      stream: bloc.passwordSettingsFormValidation.validateForgotPasswordForm,
                      builder: (context, snapshot) {
                        return snapshot.hasData && snapshot.data == true ? blueBtn(title: 'Proceed', tap: () {
                          bloc.add(SettingsForgotPasswordEvent(bloc.passwordSettingsFormValidation.forgotPasswordRequest()));
                        }) : disabledBtn(title: 'Proceed');
                      }
                  ),
                ),
              ),
              body: Column(children: [
                appBarBackAndTxt(title: "Forgot password",
                    backTap: (){Navigator.pop(context);}),
                Expanded(child:
                Padding(
                  padding: screenPadding(),
                  child: SingleChildScrollView(child: Column(children: [
                    gapH(30.h),
                    StreamBuilder<String>(
                      stream: bloc.passwordSettingsFormValidation.usernameStream,
                      builder: (context, snapshot) {
                        return CustomTextFieldWithValidation(
                          controller: null,
                          title: "Enter username",
                          details: "",
                          inputType:TextInputType.text,
                          onChange: bloc.passwordSettingsFormValidation.setUsername,
                          error: snapshot.hasError ? snapshot.error.toString() : "",
                        );
                      }
                    ),
                    gapH(28.h),
                    StreamBuilder<String>(
                      stream: bloc.passwordSettingsFormValidation.securityAnswerStream,
                      builder: (context, snapshot) {
                        return CustomTextFieldWithValidation(
                          controller: null, title: "Security answer",
                          details: "", inputType:TextInputType.text,
                          onChange: bloc.passwordSettingsFormValidation.setSecurityAnswer,
                          error: snapshot.hasError ? snapshot.error.toString() : "",
                        );
                      }
                    ),
                    gapH(28.h),
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
}
