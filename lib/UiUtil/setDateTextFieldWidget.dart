import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';

class SetDateTextFieldWidget extends StatelessWidget {
  final String title;
  final String date;
  const SetDateTextFieldWidget({
    super.key,
    required this.dateControl,required this.title,
    required this.date
  });

  final TextEditingController dateControl;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none,
      children: [
        Container(
          height: 50.h,width: 180.w,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: AppColors.green0C,
              width: 0.5.h,
            ),
          ),
          // child: TextFormField(
          //   enabled: false,
          //   controller: dateControl,
          //   cursorHeight: 15.h,
          //   cursorColor:AppColors.moneyTronicsBlue,
          //   style: TextStyle(
          //     color: AppColors.black, fontSize: 16.sp,
          //     fontFamily: 'HKGroteskMedium',
          //     fontWeight: FontWeight.w500,
          //   ),
          //   onChanged: (value){},
          //   decoration: InputDecoration(
          //     contentPadding: EdgeInsets.only(bottom: 10.h),
          //    border: InputBorder.none,
          //   ),
          //   // textInputAction: TextInputAction.done,
          // ),
          child: ctmTxtGroteskMid(date, AppColors.black, 14.sp),
        ),
        Positioned(
          left: 20.w,
          top: -10.h,
          child: Container(
            height: 19.h,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            color: AppColors.whiteFA, // Customize the background color of the label
            child: ctmTxtGroteskMid(title, AppColors.black33, 16.sp),
          ),
        )
      ],
    );
  }
}