

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';
import 'customWidgets.dart';

class AccountAndBalanceWidgetTwo extends StatefulWidget {
  final String accountTitle,accountNumber,accountBalance;
  const AccountAndBalanceWidgetTwo({super.key, required this.accountTitle, required this.accountNumber, required this.accountBalance});

  @override
  State<AccountAndBalanceWidgetTwo> createState() => _AccountAndBalanceWidgetTwoState();
}

class _AccountAndBalanceWidgetTwoState extends State<AccountAndBalanceWidgetTwo> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 18.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.moneyTronicsSkyBlue
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 150.w,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ctmTxtGroteskReg(widget.accountTitle,AppColors.black33,16.sp),
                gapH(10.h),
                ctmTxtGroteskReg(widget.accountNumber,AppColors.black33,18.sp),
              ],),
          ),
          Row(
            children: [
              nairaSign(obscure? "NGN *****": "NGN ${widget.accountBalance}",20.sp,colors:AppColors.black),
              gapW(16.w),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  child: Image.asset(obscure?"assets/png/icons/eye.png":"assets/png/icons/eye_slash.png"
                    ,width: 24.w,height: 24.h,color: AppColors.black,)
              )

            ],),


        ],
      ),
    );
  }
}
