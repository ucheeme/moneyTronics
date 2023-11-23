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
  Function()? detailTap;
  CustomTextFieldWithValidation({
    super.key,this.detailTap, required this.controller, required this.title,
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
          alignment: Alignment.centerLeft,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  cursorHeight: 15.h,
                  enabled: widget.enabled,
                  cursorColor:AppColors.moneyTronicsBlue,
                  obscureText: widget.obsureText ?? false,
                  keyboardType: widget.inputType,
                  style: TextStyle(
                    color: AppColors.black, fontSize: 15.sp,
                    fontFamily: 'HKGroteskMedium',
                    fontWeight: FontWeight.w500,
                  ),
                  onChanged: widget.onChange,
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
              ),
              widget.details.isNotEmpty?
              Column(
                children: [
                  gapWidth(20.w),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: GestureDetector(
                        onTap: widget.detailTap,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            color: AppColors.moneyTronicsSkyBlue,
                          ),
                          child: ctmTxtGroteskMid(
                              (widget.details.length > 20 )? '${widget.details. substring(0,20)}...': widget.details,
                              AppColors.moneyTronicsBlue, 15.sp,maxLines: 1,textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),
                ],
              ): const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}