

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';
import 'customWidgets.dart';

class TransactionHistoryCard extends StatelessWidget {
  final String description,time,amount;
  final bool isCredit;
  final void Function() tap;
  const TransactionHistoryCard({
    super.key, required this.description, required this.time, required this.amount, required this.isCredit, required this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: tap ,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 7.5.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 14.h),
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 38.h,width: 38.h,
              decoration: BoxDecoration(
                  color:  isCredit?AppColors.greenC7:AppColors.redE1,
                  shape: BoxShape.circle
              ),
              child: Center(child: Image.asset(
                isCredit?"assets/png/icons/credit_icon.png":"assets/png/icons/debit_icon.png",
                width: 18.h,height: 18.h,)),
            ),
            gapW(15.w),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 180.w,
                  child: ctmTxtGroteskMid(description,AppColors.black33,16.sp,maxLines: 1),
                ),
                gapH(5.h),
                ctmTxtGroteskMid(isCredit? "Credit":"Debit",AppColors.black4D,14.sp,maxLines: 1),

              ],),

            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 100.w,
                    child:
                    nairaSign(amount,16.sp,
                        colors:AppColors.black33,weight: FontWeight.w500,
                        textAlign: TextAlign.end),
                  ),
                  gapH(5.h),
                  ctmTxtGroteskReg(time,AppColors.black4D,12.sp,maxLines: 1,textAlign: TextAlign.end),

                ],),
            ),


          ],),
      ),
    );
  }
}