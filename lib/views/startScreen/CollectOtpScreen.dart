import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../UiUtil/customWidgets.dart';
import '../../UiUtil/otpHelper.dart';
import '../../UiUtil/textWidgets.dart';
import '../../utils/appUtil.dart';
import '../../utils/constants/Themes/colors.dart';
import '../../cubits/otpCubit/otp_cubit.dart';

class CollectOtpScreen extends StatefulWidget {
  const CollectOtpScreen({super.key});

  @override
  State<CollectOtpScreen> createState() => _CollectOtpScreenState();
}

class _CollectOtpScreenState extends State<CollectOtpScreen> {
  StringBuffer pinCode = StringBuffer();
  var selectedIndex = 0;
  int maximumPin = 6;
  late OtpCubit cubit;
  late Timer timer;
  @override
  void initState() {
    //_checkOtp();
    // Listen for clipboard changes
    // Clipboard.getData('text/plain').then((clipboardData) {
    //   if (clipboardData != null && clipboardData.text != null) {
    //     setState(() {
    //       pinCode.clear();
    //       pinCode.write(clipboardData.text!);
    //     });
    //   }
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    cubit = context.read<OtpCubit>();
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        if (state is OtpCollectedState) {
          AppUtils.debug("jddk");
          String otp = state.response;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              collectOtp(otp);
            });
          });
          cubit.initialState();
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
                    gapH(25.h),
                    Image.asset("assets/png/icons/luck.png",width: 78.w,height: 78.h,),
                    gapH(30.h),
                    ctmTxtGroteskMid("Enter the OTP sent to your registered",AppColors.black33, 18.sp),
                    ctmTxtGroteskMid("Phone number",AppColors.black33, 18.sp),
                    // gapH(20.h),
                    // ctmTxtGroteskReg("OTP expires in 2min 30secs...",AppColors.primary, 14.sp),
                    gapH(30.h),
                    GestureDetector(
                      onLongPress: (){
                        _pasteFromClipboard().then((clipboardText) {
                          if (clipboardText != null && clipboardText.isNotEmpty &&
                              clipboardText.length == maximumPin) {
                            setState(() {
                              pinCode.clear();
                              pinCode.write(clipboardText);
                              cubit.setCollectedPinCode(pinCode.toString());
                              //_checkOtp();
                            });
                          } else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid OTP. Please enter a valid 4-digit OTP '),
                              ),
                            );
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DigitHolder(
                              selectedIndex: selectedIndex, value: pinCode
                              .toString(), index: 0),
                          gapW(30.w),
                          DigitHolder(
                            selectedIndex: selectedIndex, value: pinCode
                              .toString(), index: 1,),
                          gapW(30.w),
                          DigitHolder(
                            selectedIndex: selectedIndex, value: pinCode
                              .toString(), index: 2,),
                          gapW(30.w),
                          DigitHolder(
                            selectedIndex: selectedIndex, value: pinCode
                              .toString(), index: 3,),
                          gapW(30.w),
                          DigitHolder(
                            selectedIndex: selectedIndex, value: pinCode
                              .toString(), index: 4,),
                          gapW(30.w),
                          DigitHolder(
                            selectedIndex: selectedIndex, value: pinCode
                              .toString(), index: 5,),
                          // gapW(30.w),
                          // DigitHolder(
                          //   selectedIndex: selectedIndex, value: pinCode
                          //     .toString(), index: 5,),

                        ],),
                    ),
                    gapH(59.h),
                    keypad(context),
                    gapH(50.h),
                    secureTxt(),
                    gapH(30.h),
                  ],),),
              ))


            ],),
          ), isLoading: state is OtpLoadingState,
        );
      },
    );
  }

  collectOtp(collectedOtp) {
    AppUtils.debug("her${collectedOtp}");
    if (collectedOtp.toString().length == maximumPin) {
      Navigator.pop(context,collectedOtp);
    }else{

    }
    // setState(() {
    //   pinCode.clear();
    // });
    // Perform any desired action after failed verification

  }
  Padding keypad(BuildContext context) {
    return number(
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("0");
            cubit.setCollectedPinCode(pinCode.toString());
          }
        });
      },//0
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("1");
            cubit.setCollectedPinCode(pinCode.toString());
          }
        });
      },//1
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("2");
            cubit.setCollectedPinCode(pinCode.toString());
          }
        });
      },//2
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("3");
            cubit.setCollectedPinCode(pinCode.toString());
          }
        });
      },//3
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("4");
            cubit.setCollectedPinCode(pinCode.toString());
          }
        });
      },//4
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("5");
            cubit.setCollectedPinCode(pinCode.toString());
          }
        });
      },//5
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("6");
            cubit.setCollectedPinCode(pinCode.toString());
          }
        });
      },//6
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("7");
            cubit.setCollectedPinCode(pinCode.toString());
          }
        });
      },//7
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("8");
            cubit.setCollectedPinCode(pinCode.toString());
          }
        });
      },//8
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("9");
            cubit.setCollectedPinCode(pinCode.toString());
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
            cubit.setCollectedPinCode(pinCode.toString());
          }
        });
      },//cancel
          (){
        // Navigator.pop(context, pinCode.toString());//push(context, MaterialPageRoute(builder: (context) => Container()));
      },//forgot

    );
  }

}

// void _copyToClipboard(String value) {
//   Clipboard.setData(ClipboardData(text: value));
// }

Future<String?> _pasteFromClipboard() async {
  ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
  return clipboardData?.text;
}

