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
          TextFormField(
            controller: widget.controller,
            cursorHeight: 15.h,
            enabled: false,
            cursorColor:AppColors.moneyTronicsBlue,
            style: TextStyle(
              color: AppColors.black, fontSize: 15.sp,
              fontFamily: 'HKGroteskMedium',
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              labelText: widget.title,
              labelStyle: TextStyle(
                color: AppColors.black, fontSize: 17.sp,
                fontFamily: 'HKGroteskMedium',
                fontWeight: FontWeight.w500,
              ),
              contentPadding: EdgeInsets.only(bottom: 10.h,left: 15.w,right: 15.w),
              border:  OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.black66,
                    width: 0.5.r,
                  ),
                  borderRadius: BorderRadius.circular(15.r)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.moneyTronicsBlue,
                    width: 0.5.r,
                  ),
                  borderRadius: BorderRadius.circular(15.r)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.black66,
                    width: 0.5.r,
                  ),
                  borderRadius: BorderRadius.circular(15.r)
              ),
            ),
          ),

        ],
      ),
    );
  }
}
