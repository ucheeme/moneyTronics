import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';
import 'balance_widget.dart';

class BalanceAndAccountDetailsWidget extends StatefulWidget {
  final String accountNumber, accountTitle,balance;
  const BalanceAndAccountDetailsWidget({
    super.key, required this.accountNumber, required this.accountTitle,
    required this.balance,
  });

  @override
  State<BalanceAndAccountDetailsWidget> createState() => _BalanceAndAccountDetailsWidgetState();
}

class _BalanceAndAccountDetailsWidgetState extends State<BalanceAndAccountDetailsWidget> {
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ctmTxtGroteskReg(widget.accountTitle,AppColors.white,16.sp,
              textAlign: TextAlign.center),
          gapHeight(10.h),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ctmTxtGroteskReg(widget.accountNumber,AppColors.white,16.sp),
              gapWidth(5.w),
              GestureDetector(onTap: (){
                _copyToClipboard(widget.accountNumber);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Account number copied to clipboard')),
                );
              },
                child: Row(children: [
                  Image.asset("assets/icons/copy.png",width: 12.w,height:12.h),
                  ctmTxtGroteskReg("Copy",AppColors.white,16.sp),
                ],),
              )

            ],
          ),
          gapHeight(22.h),
          BalanceWidget(balance: widget.balance,),
        ],),
    );
  }
}