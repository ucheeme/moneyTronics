

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../cubits/otpCubit/otp_cubit.dart';
import '../utils/appUtil.dart';
import '../utils/constants/Themes/colors.dart';
import 'customWidgets.dart';
import 'otpHelper.dart';

class TransactionPinScreen extends StatefulWidget {
  String? title = "Transaction pin";
   TransactionPinScreen({ this.title, Key? key}) : super(key: key);

  @override
  State<TransactionPinScreen> createState() => _TransactionPinScreenState();
}

class _TransactionPinScreenState extends State<TransactionPinScreen> {
  StringBuffer pinCode = StringBuffer();
  var selectedIndex = 0;
  int maximumPin = 4;
  late OtpCubit cubit;
  @override
  void initState() {
    _checkOtp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    cubit = context.read<OtpCubit>();
    return BlocBuilder<OtpCubit, OtpState>(
      builder: (context, state) {
        if (state is OtpCompleteState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Future.delayed(Duration.zero, (){
              print("tpin: ${state.response}");
              Navigator.pop(context, state.response);
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
              appBarBackAndTxt(title: widget.title ?? "Transaction pin",
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
                    ctmTxtGroteskMid("Enter your 4 digit pin",AppColors.black33, 18.sp),
                    gapH(20.h),
                    gapH(30.h),
                    GestureDetector(
                      onLongPress: (){
                        _pasteFromClipboard().then((clipboardText) {
                          if (clipboardText != null && clipboardText.isNotEmpty &&
                              clipboardText.length == maximumPin) {
                            setState(() {
                              pinCode.clear();
                              pinCode.write(clipboardText);
                              _checkOtp();
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

  bool _checkOtp() {
    if (pinCode.length == maximumPin) {
      Navigator.pop(context);
    } return false;
  }
  Padding keypad(BuildContext context) {
    return number(
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("0");
            cubit.setFourDigitPinCode(pinCode.toString());
          }
        });
      },//0
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("1");
            cubit.setFourDigitPinCode(pinCode.toString());
          }
        });
      },//1
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("2");
            cubit.setFourDigitPinCode(pinCode.toString());
          }
        });
      },//2
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("3");
            cubit.setFourDigitPinCode(pinCode.toString());
          }
        });
      },//3
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("4");
            cubit.setFourDigitPinCode(pinCode.toString());
          }
        });
      },//4
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("5");
            cubit.setFourDigitPinCode(pinCode.toString());
          }
        });
      },//5
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("6");
            //  cubit.setFourDigitPinCode(value)(pinCode.toString());
          }
        });
      },//6
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("7");
            //cubit.setFourDigitPinCode(value)(pinCode.toString());
          }
        });
      },//7
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("8");
            cubit.setFourDigitPinCode(pinCode.toString());
          }
        });
      },//8
          (){
        setState(() {
          if (pinCode.length != maximumPin) {
            pinCode.write("9");
            cubit.setFourDigitPinCode(pinCode.toString());
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
            cubit.setFourDigitPinCode(pinCode.toString());
          }
        });
      },//cancel
          (){
        // Navigator.pop(context, pinCode.toString());//push(context, MaterialPageRoute(builder: (context) => Container()));
      },//forgot

    );
  }

}
Future<String?> _pasteFromClipboard() async {
  ClipboardData? clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
  return clipboardData?.text;
}







