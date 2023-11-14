import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';


class LoadingDialog extends StatefulWidget {
  final String title,description;
  const LoadingDialog({Key? key,
    required this.title, required this.description,})
      : super(key: key);

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: 350.w,height: 247.h,
        color: AppColors.white,
        child: Column(
          children: [
            gapHeight(30.h),
            loadingIndicator(),
            gapHeight(25.h),
            SizedBox(
              width: 270.w,
              child: Column(children: [
                ctmTxtGroteskMid(widget.title, AppColors.black, 24.sp),
                gapHeight(15.h),
                ctmTxtGroteskMid(widget.description,
                    AppColors.black33, 16.sp,maxLines: 2,textAlign: TextAlign.center)


              ],),
            ),
          ],
        ),
      ),
    );
  }

  Container loadingIndicator() {
    return Container(
            width: 270.w,height:35.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.10),
                ),
                BoxShadow(
                  color: AppColors.greenEB,
                  spreadRadius: -0.0,
                  blurRadius: 10.r,
                  offset: const Offset(0.0, 0.0), // shadow direction: bottom right
                )
              ],
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              greenCircle(),
              SizedBox(width: 200.w,height: 15.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    backgroundColor: AppColors.green18,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.green2B),
                  ),
                ),
              ),
              greenCircle(),
            ],),

          );
  }
  Container greenCircle() {
    return Container(
                width: 15.h,height: 18.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.green2B
                ),

              );
  }
}
