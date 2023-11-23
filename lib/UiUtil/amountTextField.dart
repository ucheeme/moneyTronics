


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/constants/Themes/colors.dart';
import '../utils/ThousandInputFormat.dart';

class AmountTextField extends StatefulWidget {
  bool? enabled = true;
  final String labelText;
  final TextInputType inputType;
  final TextEditingController controller;
  final Function(String) onChange;
   AmountTextField({super.key, required this.labelText,
    required this.inputType, required this.controller,
    required this.onChange, this.enabled,});

  @override
  State<AmountTextField> createState() => _AmountTextFieldState();
}

class _AmountTextFieldState extends State<AmountTextField> {
  final double _height = 57.h;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: TextFormField(
        enabled: widget.enabled,
        inputFormatters: [ThousandsSeparatorInputFormatter()],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
          prefixText: "NGN ",
          prefixStyle: GoogleFonts.roboto(
            color: AppColors.black,fontSize: 17.sp,
            fontWeight: FontWeight.w500,
          ),
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



        ),
        // textInputAction: TextInputAction.done,
      ),
    );
  }
}
