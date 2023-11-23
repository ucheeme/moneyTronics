
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';

class SelectionTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final Function ()tap;
  const SelectionTextField({super.key, required this.controller, required this.title, required this.tap});

  @override
  State<SelectionTextField> createState() => _SelectionTextFieldState();
}

class _SelectionTextFieldState extends State<SelectionTextField> {
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
                color: AppColors.moneyTronicsSkyBlue,
                width: 0.5.h,
              ),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: false,
                    controller: widget.controller,
                    cursorHeight: 15.h,
                    cursorColor:AppColors.black,
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
                ),
                Icon(Icons.keyboard_arrow_down_rounded,size: 24.h,color: AppColors.black,)
              ],
            ),
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
