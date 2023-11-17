import 'package:flutter/cupertino.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';

import '../../utils/constants/Themes/colors.dart';
import '../textWidgets.dart';

class SimpleSuccessAlertBottomSheet extends StatefulWidget {
  final bool isSuccessful;
  final String type,description, accountBtn;
  final void Function() returnTap;
  const SimpleSuccessAlertBottomSheet({super.key,
    required this.isSuccessful, required this.type,
    required this.description, required this.accountBtn, required this.returnTap});

  @override
  State<SimpleSuccessAlertBottomSheet> createState() => _SimpleSuccessAlertBottomSheetState();
}

class _SimpleSuccessAlertBottomSheetState extends State<SimpleSuccessAlertBottomSheet>  with TickerProviderStateMixin {
  late FlutterGifController controller;

  @override
  void initState() {
    controller = FlutterGifController(vsync: this, duration: const Duration(milliseconds: 200), reverseDuration: const Duration(milliseconds: 200),);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,height: 590.h,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          gapHeight(70.h),
          Lottie.asset('assets/json/success.json', height: 250, width: 250),
          ctmTxtGroteskMid(widget.type, AppColors.black, 24.sp),
          gapHeight(15.h),
          SizedBox(width: 306.w,
            child: ctmTxtGroteskMid(
                widget.description,
                AppColors.black33,
                16.sp,
                maxLines: 2,
                textAlign: TextAlign.center),
          ),
          gapHeight(60.h),
          gapHeight(40.h),
          const Spacer(),
          blueBtn(title: widget.accountBtn, tap:widget.returnTap)
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
              greenIconHolder("assets/png/icons/download.png",),
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
          color: AppColors.greenD8,
          borderRadius: BorderRadius.circular(20.r)
      ),
      child: Center(child:


      Image.asset(image,width: 24.w,height: 24.h, color:AppColors.green18 ,),
      ),);
  }
}
