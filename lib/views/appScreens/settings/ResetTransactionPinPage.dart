

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/settings/setting_bloc.dart';
import '../../../UiUtil/TransactionPin.dart';
import '../../../UiUtil/bottomsheet/simpleSuccessAlertBottomSheet.dart';
import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../Utils/appUtil.dart';
import '../../../Utils/constants/Themes/colors.dart';
import '../../../models/requests/ResetTransactionPinRequest.dart';
import '../../../models/requests/SendOtpRequest.dart';
import '../../startScreen/login/loginFirstTime.dart';
import '../dashboard/dashboard.dart';







class ResetTransactionPinScreen extends StatefulWidget {
  const ResetTransactionPinScreen({super.key});

  @override
  State<ResetTransactionPinScreen> createState() => _ResetTransactionPinScreenState();
}

class _ResetTransactionPinScreenState extends State<ResetTransactionPinScreen> {

  late SettingBloc bloc;

  TextEditingController otpControl = TextEditingController();
  TextEditingController securityAnswerControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add( SettingSendOtpEvent(request: SendOtpRequest(phoneOrAccountnumber: userAccounts?[0].accountnumber ?? "", email: loginResponse?.email ?? "")));
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<SettingBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state is SettingOtpSentState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                AppUtils.showSuccessSnack("Otp has been sent to your email/phone", context);
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
          if (state is SettingResetTransactionPinState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                nonDismissibleBottomSheet(context,
                    SimpleSuccessAlertBottomSheet(
                        isSuccessful: true, type: "Successful",
                        description: "Pin changed successfully",
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
                      stream: bloc.passwordSettingsFormValidation.validateResetPinForm,
                      builder: (context, snapshot) {
                        return snapshot.hasData && snapshot.data == true ? blueBtn(title: 'Proceed', tap: () {
                          openPinScreen();
                        }) : disabledBtn(title: 'Proceed');
                      }
                  ),
                ),
              ),
              body: Column(children: [
                appBarBackAndTxt(title: "Reset transaction pin",
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
                          controller: otpControl,
                          title: "Enter otp",
                          details: "",
                          inputType:TextInputType.text,
                          onChange: bloc.passwordSettingsFormValidation.setOtp,
                          error: snapshot.hasError ? snapshot.error.toString() : "",
                        );
                      }
                    ),
                    gapH(28.h),
                    StreamBuilder<String>(
                      stream: bloc.passwordSettingsFormValidation.securityAnswerStream,
                      builder: (context, snapshot) {
                        return CustomTextFieldWithValidation(
                          controller: securityAnswerControl, title: "Security answer",
                          details: "", inputType:TextInputType.text,
                          onChange: bloc.passwordSettingsFormValidation.setSecurityAnswer,
                          error: snapshot.hasError ? snapshot.error.toString() : "",
                        );
                      }
                    ), gapH(28.h),
                    ],),),)),
              ],),
            ),
          );
        },
      ),
    );
  }
  void openPinScreen()async {
    var pin = await Navigator.push(context, MaterialPageRoute(builder: (context) =>
     TransactionPinScreen(title: "Enter new pin",)));
    if (pin != null) {
      AppUtils.debug("pin entered $pin");
      bloc.add(SettingResetTpinEvent(ResetTransactionPinRequest(
          accountnumber: userAccounts?[0].accountnumber ?? "",
          opTcode: otpControl.text,
          newTransPin: pin,
          renterTransactionpin: pin,
          answerToQuestion: securityAnswerControl.text
      )));
    }
  }
}
