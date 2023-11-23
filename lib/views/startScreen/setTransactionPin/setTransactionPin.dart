import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../UiUtil/bottomsheet/accountCreatedSuccessful.dart';
import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/otpHelper.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../cubits/otpCubit/otp_cubit.dart';
import '../../../models/requests/RegistrationVerificationRequest.dart';
import '../../../utils/appUtil.dart';
import '../../../utils/constants/Themes/colors.dart';
import '../../../utils/constants/text.dart';

class SetTransactionPin extends StatefulWidget {
  const SetTransactionPin({super.key});

  @override
  State<SetTransactionPin> createState() => _SetTransactionPinState();
}

class _SetTransactionPinState extends State<SetTransactionPin> {
  StringBuffer pinCode = StringBuffer();
  var selectedIndex = 0;
  int maximumPin = 5;
  late OtpCubit cubit;
  @override
  Widget build(BuildContext context) {
    cubit = context.read<OtpCubit>();
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        if (state is OtpCompleteState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              // Get.bottomSheet(
              //     backgroundColor: AppColors.white,
              //     AccountCreated(accountNumber:"0112345678",));

            });
          });
        }
        if (state is OtpAccountCreatedState) {

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              // Navigator.pop(context, true);
              // _receiptBottomSheet(state.response.accountNumber);
              Get.bottomSheet(
                  backgroundColor: AppColors.white,
                  AccountCreated(accountNumber:state.response.accountNumber!,));
              cubit.initialState();
            });
          });
        }
        if (state is OtpErrorState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              AppUtils.showSnack(state.response.result?.message ?? "", context);
            });
            cubit.initialState();
          });
        }
        return AppUtils.loadingWidget(
          child: Scaffold(
            backgroundColor: AppColors.whiteFA,
            body: Column(children: [
              appBarBackAndTxt(title: "Enter OTP",
                  backTap: (){Navigator.pop(context);}),
              Expanded(child:
              Padding(
                padding: screenPadding(),
                child: SingleChildScrollView(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    gapHeight(25.h),
                    Image.asset("assets/icons/backgroundLock.png",width: 78.w,height: 78.h,),
                    gapHeight(30.h),
                    ctmTxtGroteskMid(AppStrings.enterOTPText,AppColors.black33, 18.sp),
                    ctmTxtGroteskMid(AppStrings.phoneNumText,AppColors.black33, 18.sp),
                    gapHeight(20.h),
                    ctmTxtGroteskReg(AppStrings.otpTimeText,AppColors.moneyTronicsBlue, 14.sp),
                    gapHeight(30.h),
                    GestureDetector(
                      onLongPress: (){
                        // _pasteFromClipboard().then((clipboardText) {
                        //   if (clipboardText != null && clipboardText.isNotEmpty &&
                        //       clipboardText.length == maximumPin) {
                        //     setState(() {
                        //       pinCode.clear();
                        //       pinCode.write(clipboardText);
                        //       _checkOtp();
                        //     });
                        //   } else{
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //         content: Text(AppStrings.invalidOTPText),
                        //       ),
                        //     );
                        //   }
                        // });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DigitHolder(
                              selectedIndex: selectedIndex, value: pinCode
                              .toString(), index: 0),
                          gapWidth(30.w),
                          DigitHolder(
                            selectedIndex: selectedIndex, value: pinCode
                              .toString(), index: 1,),
                          gapWidth(30.w),
                          DigitHolder(
                            selectedIndex: selectedIndex, value: pinCode
                              .toString(), index: 2,),
                          gapWidth(30.w),
                          DigitHolder(
                            selectedIndex: selectedIndex, value: pinCode
                              .toString(), index: 3,),
                          gapWidth(30.w),
                          DigitHolder(
                            selectedIndex: selectedIndex, value: pinCode
                              .toString(), index: 4,),
                          // gapW(30.w),
                          // DigitHolder(
                          //   selectedIndex: selectedIndex, value: pinCode
                          //     .toString(), index: 4,),
                          // gapW(30.w),
                          // DigitHolder(
                          //   selectedIndex: selectedIndex, value: pinCode
                          //     .toString(), index: 5,),

                        ],),
                    ),
                    gapHeight(59.h),
                    keypad(context),
                    gapHeight(50.h),
                    secureTxt(),
                    gapHeight(30.h),
                  ],),),
              ))


            ],),
          ), isLoading: state is OtpLoadingState,
        );
      },
    );
  }
  Padding keypad(BuildContext context) {
    return number(
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("0");
            cubit.setPinCode(pinCode.toString());
          }
        });
      },//0
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("1");
            cubit.setPinCode(pinCode.toString());
          }
        });
      },//1
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("2");
            cubit.setPinCode(pinCode.toString());
          }
        });
      },//2
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("3");
            cubit.setPinCode(pinCode.toString());
          }
        });
      },//3
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("4");
            cubit.setPinCode(pinCode.toString());
          }
        });
      },//4
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("5");
            cubit.setPinCode(pinCode.toString());
          }
        });
      },//5
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("6");
            //  cubit.setPinCode(pinCode.toString());
          }
        });
      },//6
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("7");
            //cubit.setPinCode(pinCode.toString());
          }
        });
      },//7
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("8");
            cubit.setPinCode(pinCode.toString());
          }
        });
      },//8
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("9");
            cubit.setPinCode(pinCode.toString());
          }
        });
      },//9
          (){
        var c = pinCode.toString();
        pinCode.clear();
        setState(() {
          if (c.isNotEmpty) {
            var r = c.substring(0, c.length - 1);
            pinCode.write(r);
            cubit.setPinCode(pinCode.toString());
          }
        });
      },//cancel
          (){
        // Navigator.pop(context, pinCode.toString());//push(context, MaterialPageRoute(builder: (context) => Container()));
      },//forgot

    );
  }
}
