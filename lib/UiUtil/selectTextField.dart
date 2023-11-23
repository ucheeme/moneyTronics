


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Utils/constants/Themes/colors.dart';

class SelectTextField extends StatefulWidget {
  final String labelText;
  //final TextInputType inputType;
  final TextEditingController controller;
  final Function(String) onChange;
  const SelectTextField({super.key,
    required this.labelText,
    // required this.inputType,
    required this.controller, required this.onChange});

  @override
  State<SelectTextField> createState() => _SelectTextFieldState();
}

class _SelectTextFieldState extends State<SelectTextField> {
  final double _height = 57.h;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: TextFormField(
        enabled: false,
        controller: widget.controller,
        cursorHeight: 15.h,
        cursorColor:AppColors.moneyTronicsBlue,
        style: TextStyle(
          color: AppColors.black, fontSize: 16.sp,
          fontFamily: 'HKGroteskMedium',
          fontWeight: FontWeight.w500,
        ),
        onChanged: widget.onChange,
        decoration: InputDecoration(
            labelText: widget.labelText,
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
            disabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.black66,
                  width: 0.5.r,
                ),
                borderRadius: BorderRadius.circular(15.r)
            ),
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.black,)
        ),
      ),
    );
  }
}
