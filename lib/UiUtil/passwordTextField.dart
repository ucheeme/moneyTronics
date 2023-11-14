import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';




class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final Function(String) onChange;
  String? error;
  PasswordTextField({super.key,
    required this.controller, this.error,  required this.title, required this.onChange});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final double _height = 57.h;
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none,
      children: [
        Container(
          height: _height,width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: AppColors.moneyTronicsBlue,
              width: 0.5.h,
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  cursorHeight: 15.h,
                  cursorColor:AppColors.moneyTronicsSkyBlue,
                  keyboardType: TextInputType.text,
                  obscureText: obscure,
                  style: TextStyle(
                    color: AppColors.black, fontSize: 16.sp,
                    fontFamily: 'HKGroteskMedium',
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: widget.onChange,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10.h),
                    border: InputBorder.none,
                    errorText: widget.error ?? "",
                  ),
                  // textInputAction: TextInputAction.done,
                ),
              ),
              GestureDetector(
                onTap: (){
                 setState(() {
                   obscure = !obscure;
                 });
                },
                 child: Image.asset(obscure?"assets/icons/eye.png":"assets/icons/eye_slash.png"
                   ,width: 24.w,height: 24.h,)
              )
                  // child: Icon(obscure?Icons.visibility_outlined : Icons.visibility_off_outlined,
                  //   size: 24.h,color: AppColors.black))
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
    );
  }
}
