import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';

class BankWidgetWithDetails extends StatefulWidget {
  final String name,bank, accountNumber;
  const BankWidgetWithDetails({
    super.key, required this.name, required this.bank, required this.accountNumber,
  });

  @override
  State<BankWidgetWithDetails> createState() => _BankWidgetWithDetailsState();
}

class _BankWidgetWithDetailsState extends State<BankWidgetWithDetails> {

  String firstTwoLetters = "";

  @override
  void initState() {
    super.initState();

    // Access widget.name here and perform the necessary operations
    List<String> wordList = widget.name.split(' ');
    if (wordList.length >= 2) {
      firstTwoLetters = wordList[0][0]; //+ wordList[1][0];
    }
  }
  // Output: "jm"
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 242.w,height: 56.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      margin: EdgeInsets.only(left: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.r),
          color: AppColors.whiteFA
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 34.w,height: 32.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.moneyTronicsBlue
            ),
            child: Center(child: ctmTxtGroteskMid(firstTwoLetters,AppColors.white,12.5.sp),),
          ),
          gapWidth(8.w),
          SizedBox(width: 176.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ctmTxtGroteskMid(widget.name,AppColors.black19,18.sp,maxLines: 1),
                gapHeight(4.h),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 70.w,
                        child: ctmTxtGroteskReg(widget.bank,AppColors.black6B,14.sp,maxLines: 1)),
                    ctmTxtGroteskReg("• ",AppColors.black19,14.sp,maxLines: 1),
                    Expanded(child: ctmTxtGroteskReg(widget.accountNumber,AppColors.black6B,14.sp,maxLines: 1)),
                  ],
                ),


              ],),
          )
        ],),
    );
  }
}