import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';
import 'package:moneytronic/utils/constants/text.dart';

import '../utils/constants/Themes/colors.dart';

class DigitHolder extends StatefulWidget {
  final int selectedIndex;
  final int index;
  final String value;

  const DigitHolder({
    required this.selectedIndex,
    required this.value,
    Key? key, required this.index,
  }) : super(key: key);

  @override
  State<DigitHolder> createState() => _DigitHolderState();
}

class _DigitHolderState extends State<DigitHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left: 0.w,right: 8.w),
      width: 30.w,
      height: 30.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: AppColors.green0C,
            width: 0.3.h),
      ),
      child:Center(
        child: widget.value.length > widget.index ?
        Container(
          width: 15.w,height: 15.h,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.moneyTronicsBlue
          ),
        ):const SizedBox(),
      ),
      // Center(child: widget.value.length > widget.index ? Icon(Icons.circle,color:
      // AppColors.black,size: 20.r,):null 123456
      // ),
    );
  }
}
//widget.value.length > widget.index ? widget.value[widget.index] : '',

Padding number(zero,one,two,three,four,five,six,seven,eight,nine,cancel,extraBtn) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 50.w),
    child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            numberBtn(one,"1",),
            numberBtn(two,"2",),
            numberBtn(three,"3",),
          ],
        ),
        margin(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            numberBtn(four,"4",),
            numberBtn(five,"5",),
            numberBtn(six,"6",),
          ],
        ),
        margin(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            numberBtn(seven,"7",),
            numberBtn(eight,"8",),
            numberBtn(nine,"9",),
          ],
        ),
        margin(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: extraBtn,
                child: Image.asset("assets/icons/active_biometrics.png",width: 60.w,height: 60.h,)),
            numberBtn(zero,"0",),
           numberBtnCancel(cancel),
          ],
        ),
      ],
    ),
  );
}

Padding numberWithBiometrics(zero,one,two,three,four,five,six,seven,eight,
    nine,cancel,extraBtn) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 50.w),
    child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            numberBtn(one,"1",),
            numberBtn(two,"2",),
            numberBtn(three,"3",),
          ],
        ),
        margin(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            numberBtn(four,"4",),
            numberBtn(five,"5",),
            numberBtn(six,"6",),
          ],
        ),
        margin(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            numberBtn(seven,"7",),
            numberBtn(eight,"8",),
            numberBtn(nine,"9",),
          ],
        ),
        margin(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: extraBtn,
                child: Image.asset("assets/icons/active_biometrics.png",width: 60.w,height: 60.h,)),
            numberBtn(zero,"0",),
            numberBtnCancel(cancel),
          ],
        ),
      ],
    ),
  );
}

SizedBox margin() => gapHeight(40.h);
GestureDetector numberBtn(tap,title) {
  return GestureDetector(
    onTap: tap,
    child: Container(
      width: 60.w,height: 60.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 0.3.h, color: AppColors.whiteCC,
        ),
        // borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Center(child: ctmTxtGroteskMid(title, AppColors.black, 34.sp)),
    ),
  );
}
GestureDetector numberBtnCancel(tap) {
  return GestureDetector(
    onTap: tap,
    child: Container(
      width: 60.w,height: 60.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 0.3.h, color: AppColors.whiteCC,
        ),
        // borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Center(child:
      Image.asset("assets/icons/cancel.png",width:24.w,height: 24.h,)
      ),
    ),
  );
}
Container secureTxt() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 30.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.moneyTronicsSkyBlue
    ),
    child: SizedBox(width: 260.w,
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/icons/lockFill.png",width: 16.w,height: 16.h,),
            gapWidth(5.w),
            ctmTxtGroteskMid(AppStrings.accountSecured,
                AppColors.moneyTronicsBlue,14.sp,maxLines: 1),

          ],),
      ),
    ),
  );
}