import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



import '../../utils/constants/Themes/colors.dart';
import '../customWidgets.dart';
import '../textWidgets.dart';





class ReceiptBottomSheet2 extends StatelessWidget {
  final bool isSuccessful;
  final String type,description;
  final void Function() shareTap, downloadTap,returnTap;
  const ReceiptBottomSheet2({super.key,
    required this.isSuccessful, required this.type,
    required this.description, required this.shareTap,
    required this.downloadTap, required this.returnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,height: 690.h,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        gapH(30.h),
        Image.asset(isSuccessful?"assets/png/images/success.png":
        "assets/png/images/failed.png",
          width: 300.w,height: 300.h,fit: BoxFit.contain,
        ),
        ctmTxtGroteskMid(type, AppColors.black, 24.sp),
        gapH(15.h),
        SizedBox(width: 306.w,
          child: ctmTxtGroteskMid(description,
              AppColors.black33, 16.sp,maxLines: 2,textAlign: TextAlign.center),
        ),
        gapH(60.h),
        shareOrDownloadReceiptBtn(shareTap: shareTap,
           downloadTap: downloadTap),
          gapH(40.h),
          blueBtn(title: "Return to Dashboard", tap:returnTap)

      ],),
    );
  }

  static Row shareOrDownloadReceiptBtn({required void Function() shareTap,required void Function() downloadTap}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
          GestureDetector(
            onTap: shareTap,
            child: Column(
              children: [
                greenIconHolder("assets/icons/download.png"),
                gapH(10.h),
                ctmTxtGroteskMid("Download receipt",AppColors.black,16.sp)
              ],
            ),
          ),
          gapW(83.w),
          GestureDetector(onTap: downloadTap,
            child: Column(
              children: [
                greenIconHolder("assets/icons/share.png"),
                gapH(10.h),
                ctmTxtGroteskMid("Share receipt",AppColors.black,16.sp)
              ],
            ),
          ),

        ],);
  }

  static Container greenIconHolder(image) {
    return Container(
            width: 44.h,height: 44.h,
            decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(20.r)
            ),
            child: Center(child: Image.asset(image,width: 24.w,height: 24.h,),),
          );
  }
}
