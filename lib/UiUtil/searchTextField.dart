import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants/Themes/colors.dart';

class SearchTextField extends StatefulWidget {
  final String labelText;
  final TextInputType inputType;
  final TextEditingController controller;
  final Function(String) onChange;
  const SearchTextField({super.key,
    required this.labelText, required this.inputType,
    required this.controller, required this.onChange});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final double _height = 57.h;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: TextFormField(
        controller: widget.controller,
        cursorHeight: 15.h,
        cursorColor:AppColors.moneyTronicsSkyBlue,
        keyboardType: widget.inputType,
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
                  color: AppColors.green2B,
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
            suffixIcon: SizedBox(width: 24.w,height: 24.h,
                child: Center(child: Image.asset("assets/icons/search.png",width: 24.w,height: 24.h,)))



        ),
        // textInputAction: TextInputAction.done,
      ),
    );
  }
}
