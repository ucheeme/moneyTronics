import 'package:flutter/cupertino.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';
import 'package:lottie/lottie.dart';

import '../utils/constants/Themes/colors.dart';

class SuccessAlertBottomSheet extends StatefulWidget {
  final bool isSuccessful;
  final String type,description;
  final void Function() shareTap, downloadTap,returnTap;
  const SuccessAlertBottomSheet({super.key,
    required this.isSuccessful, required this.type,
    required this.description, required this.shareTap,
    required this.downloadTap, required this.returnTap});

  @override
  State<SuccessAlertBottomSheet> createState() => _SuccessAlertBottomSheetState();
}

class _SuccessAlertBottomSheetState extends State<SuccessAlertBottomSheet>  with TickerProviderStateMixin {
  late FlutterGifController controller;

  @override
  void initState() {
    controller = FlutterGifController(vsync: this, duration: const Duration(milliseconds: 200), reverseDuration: const Duration(milliseconds: 200),);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,height: 690.h,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.asset(widget.isSuccessful?"assets/png/images/success.png":
          // "assets/png/images/failed.png",
          //   width: 300.w,height: 300.h,fit: BoxFit.contain,
          // ),
          gapHeight(40.h),
          Lottie.asset('assets/lotties/sucessful.json', height: 250.h,
              width: 250.w),
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
          Spacer(),
          blueBtn(title: "Return to Dashboard", tap:widget.returnTap)
        ],
      ),
    );
  }
  Row shareOrDownloadReceiptBtn({required void Function() shareTap,required void Function() downloadTap}) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: shareTap,
          child: Column(
            children: [
              greenIconHolder("assets/icons/download.png",),
              gapHeight(10.h),
              ctmTxtGroteskMid("Share",AppColors.black,16.sp)
            ],
          ),
        ),
        gapWidth(83.w),
        GestureDetector(onTap: downloadTap,
          child: Column(
            children: [
              greenIconHolder("assets/png/icons/copy.png"),
              gapHeight(10.h),
              ctmTxtGroteskMid("Copy",AppColors.black,16.sp)
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
      child: Center(child:

      Image.asset(image,width: 24.w,height: 24.h, color:AppColors.moneyTronicsBlue ,),
      ),);
  }
}
