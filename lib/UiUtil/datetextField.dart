import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';

class DateTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final Function ()tap;
  const DateTextField({Key? key, required this.controller,
    required this.title, required this.tap}) : super(key: key);

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  final double _height = 57.h;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: widget.tap,
      child: Stack(clipBehavior: Clip.none,
        children: [
          Container(
            height: _height,width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: AppColors.green0C,
                width: 0.5.h,
              ),
            ),
            child: TextFormField(
              enabled: false,
              controller: widget.controller,
              cursorHeight: 15.h,
              cursorColor:AppColors.green2B,
              style: TextStyle(
                color: AppColors.black, fontSize: 16.sp,
                fontFamily: 'HKGroteskMedium',
                fontWeight: FontWeight.w500,
              ),
              // onChanged: widget.onChange,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 10.h),
                border: InputBorder.none,
              ),
              // textInputAction: TextInputAction.done,
            ),
            // child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: TextFormField(
            //         controller: widget.controller,
            //         cursorHeight: 15.h,
            //         cursorColor:AppColors.green2B,
            //         style: TextStyle(
            //           color: AppColors.black, fontSize: 16.sp,
            //           fontFamily: 'HKGroteskMedium',
            //           fontWeight: FontWeight.w500,
            //         ),
            //        // onChanged: widget.onChange,
            //         decoration: InputDecoration(
            //           contentPadding: EdgeInsets.only(bottom: 10.h),
            //           border: InputBorder.none,
            //         ),
            //         // textInputAction: TextInputAction.done,
            //       ),
            //     ),
            //     gapW(20.w),
            //     // widget.details.isNotEmpty?
            //     // Container(
            //     //   padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            //     //   decoration: BoxDecoration(
            //     //     borderRadius: BorderRadius.circular(15.r),
            //     //     color: AppColors.greenEB,
            //     //   ),
            //     //   child: ctmTxtGroteskMid(
            //     //       (widget.details.length > 20 )? '${widget.details. substring(0,20)}...': widget.details,
            //     //       AppColors.green2B, 16.sp,maxLines: 1,textAlign: TextAlign.center),
            //     // ): const SizedBox(),
            //   ],
            // ),
          ),
          Positioned(
            left: 20.w,
            top: -10.h,
            child: Container(
              height: 19.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              color: AppColors.whiteFA, // Customize the background color of the label
              child: ctmTxtGroteskMid(widget.title, AppColors.black33, 16.sp),
            ),
          )
        ],
      ),
    );
  }
}
