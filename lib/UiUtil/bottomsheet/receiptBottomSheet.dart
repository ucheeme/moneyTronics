
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';

import '../../utils/constants/Themes/colors.dart';
import '../textWidgets.dart';

class ReceiptBottomSheet extends StatefulWidget {
  final bool isSuccessful;
  final String type,description;
  final void Function() shareTap, downloadTap,returnTap;
  const ReceiptBottomSheet({super.key,
    required this.isSuccessful, required this.type,
    required this.description, required this.shareTap,
    required this.downloadTap, required this.returnTap});

  @override
  State<ReceiptBottomSheet> createState() => _ReceiptBottomSheetState();
}

class _ReceiptBottomSheetState extends State<ReceiptBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,height: 690.h,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          gapHeight(30.h),
          Lottie.asset(widget.isSuccessful?"assets/lotties/sucessful.json":
          "assets/lotties/failedAnim.json",
            width: 300.w,height: 300.h,fit: BoxFit.contain,
          ),
          ctmTxtGroteskMid(widget.type, AppColors.black, 24.sp),
          gapHeight(15.h),
          SizedBox(width: 306.w,
            child: ctmTxtGroteskMid(widget.description,
                AppColors.black33, 16.sp,maxLines: 2,textAlign: TextAlign.center),
          ),
          gapHeight(60.h),
          shareOrDownloadReceiptBtn(shareTap: widget.shareTap,
              downloadTap: widget.downloadTap),
          gapHeight(40.h),
          blueBtn(title: "Return to Dashboard", tap:widget.returnTap)

        ],),
    );
  }

  Row shareOrDownloadReceiptBtn({required void Function() shareTap,required void Function() downloadTap}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: shareTap,
          child: Column(
            children: [
              greenIconHolder("assets/icons/download.png"),
              gapHeight(10.h),
              ctmTxtGroteskMid("Share receipt",AppColors.black,16.sp)
            ],
          ),
        ),
        gapWidth(83.w),
        GestureDetector(onTap: downloadTap,
          child: Column(
            children: [
              greenIconHolder("assets/icons/share.png"),
              gapHeight(10.h),
              ctmTxtGroteskMid("Download receipt",AppColors.black,16.sp)
            ],
          ),
        ),

      ],);
  }

  Container greenIconHolder(image) {
    return Container(
      width: 44.h,height: 44.h,
      decoration: BoxDecoration(
          color: AppColors.moneyTronicsSkyBlue,
          borderRadius: BorderRadius.circular(20.r)
      ),
      child: Center(child: Image.asset(image,width: 24.w,height: 24.h,),),
    );
  }
}
