import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';
import '../utils/constants/Themes/colors.dart';

class CustomTextFieldWithValidation extends StatefulWidget {
  final TextEditingController? controller;
  final String title,details;
  final Function(String) onChange;
  final TextInputType inputType;
  String? error;
  bool? obsureText;
  bool? enabled = true;
  CustomTextFieldWithValidation({
    super.key, required this.controller, required this.title,
    required this.details, this.error, this.obsureText, required this.onChange, required this.inputType, this.enabled
  });

  @override
  State<CustomTextFieldWithValidation> createState() => _CustomTextFieldWithValidationState();
}

class _CustomTextFieldWithValidationState extends State<CustomTextFieldWithValidation> {

  final double _height = 57.h;

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
                  enabled: widget.enabled,
                  cursorColor:AppColors.moneyTronicsSkyBlue,
                  obscureText: widget.obsureText ?? false,
                  keyboardType: widget.inputType,
                  style: TextStyle(
                    color: AppColors.black, fontSize: 15.sp,
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
              gapWidth(20.w),
              widget.details.isNotEmpty?
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.moneyTronicsSkyBlue,
                ),
                child: ctmTxtGroteskMid(
                    (widget.details.length > 20 )? '${widget.details. substring(0,20)}...': widget.details,
                    AppColors.black1A, 15.sp,maxLines: 1,textAlign: TextAlign.center),
              ): const SizedBox(),
            ],
          ),
        ),
        Positioned(
          left: 20.w,
          top: -10.h,
          child: Container(
            height: 22.h,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            color: AppColors.whiteFA, // Customize the background color of the label
            child: ctmTxtGroteskMid(widget.title, AppColors.black33, 15.sp),
          ),
        )
      ],
    );
  }
}