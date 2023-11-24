

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Bloc/settings/setting_bloc.dart';
import '../../../UiUtil/customTextfield.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/normalTextFieldWithValidation.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../Utils/appUtil.dart';
import '../../../Utils/constants/Themes/colors.dart';
import '../../../models/requests/SendOtpRequest.dart';



class DeviceRegistrationScreen extends StatefulWidget {
  final String username;
  const DeviceRegistrationScreen({required this.username, super.key});
  @override
  State<DeviceRegistrationScreen> createState() => _DeviceRegistrationScreenState();
}

class _DeviceRegistrationScreenState extends State<DeviceRegistrationScreen> {
  late SettingBloc bloc;
  TextEditingController otpControl = TextEditingController();
  TextEditingController accountNumberControl = TextEditingController();
  TextEditingController secretAnswerControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   bloc.add(SettingSendOtpEvent(request: SendOtpRequest(phoneOrAccountnumber: phoneOrAccountnumber, email: email)));
    });
  }

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
          if (state is SettingOtpSentState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
                AppUtils.showSuccessSnack("Otp has been sent to your email/phone", context);
                bloc.initial();
              });
            });
          }
          if (state is SettingDeviceRegistrationState){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Future.delayed(Duration.zero, (){
               Navigator.pop(context,true);
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
                      stream: bloc.passwordSettingsFormValidation.validateDeviceChangeForm,
                      builder: (context, snapshot) {
                        return snapshot.hasData && snapshot.data == true ? blueBtn(title: 'Proceed', tap: () {
                          bloc.add(SettingsDeviceRegistrationEvent(bloc.passwordSettingsFormValidation.deviceAuthRequest(widget.username)));
                        }) : disabledBtn(title: 'Proceed');
                      }
                  ),
                ),
              ),
              body: Column(children: [
                appBarBackAndTxt(title: "Device Authorization", backTap: (){
                   Navigator.pop(context);
                }),
                Expanded(child:
                Padding(
                  padding: screenPadding(),
                  child:
                  SingleChildScrollView(child: Column(children: [
                    gapH(30.h),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ctmTxtGroteskMid("Register this device to use CEDAR mfb mobile application",
                              AppColors.black33, 18.sp,maxLines: 2,textAlign: TextAlign.start),
                        ],
                      ),
                    ),
                    StreamBuilder<String>(
                        stream: bloc.passwordSettingsFormValidation.accountNumber,
                        builder: (context, snapshot) {
                          return CustomTextFieldWithValidation(
                              controller: accountNumberControl,
                              title: "Enter Account number",
                              details: "Send Otp",
                              inputType:TextInputType.number,
                              onChange: bloc.passwordSettingsFormValidation.setAccountNumber,
                              error: snapshot.hasError ? snapshot.error.toString() : "",
                              detailTap: (){
                                bloc.add(SettingSendOtpEvent(request: SendOtpRequest(phoneOrAccountnumber: accountNumberControl.text, email: "")));
                              }
                          );
                        }
                    ),
                    gapH(28.h),
                    StreamBuilder<String>(
                        stream: bloc.passwordSettingsFormValidation.otpStream,
                        builder: (context, snapshot) {
                          return NormalTextFieldWithValidation(
                            labelText: 'Enter OTP',
                            inputType: TextInputType.number,
                            controller: otpControl,
                            onChange: bloc.passwordSettingsFormValidation.setOtp,

                          );
                        }
                    ),
                    gapH(28.h),
                    StreamBuilder<String>(
                        stream: bloc.passwordSettingsFormValidation.securityAnswerStream,
                        builder: (context, snapshot) {
                          return NormalTextFieldWithValidation(
                            labelText: 'Enter secret answer',
                            inputType: TextInputType.text,
                            controller: secretAnswerControl,
                            onChange: bloc.passwordSettingsFormValidation.setSecurityAnswer,
                          );
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
