import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';
import 'package:moneytronic/utils/constants/text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/constants/Themes/colors.dart';
AnnotatedRegion<SystemUiOverlayStyle> darkStatusBar(child) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value:const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness:  Brightness.light ,
        statusBarIconBrightness:  Brightness.dark
    ),
    child: child,
  );
}

GestureDetector outlineBtn({required String title, isEnabled, required Function()tap}) {
  return GestureDetector(
    onTap: tap,
    child: Container(
      height: 60.h,
      decoration: BoxDecoration(
        color:AppColors.moneyTronicsSkyBlue,// Customize the color of the indicator
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
            color: AppColors.moneyTronicsBlue,
            width:0.5.r
        ),// Customize the border radius
      ),
      child: Center(child: ctmTxtGroteskMid(title, AppColors.moneyTronicsBlue, 18.sp, weight: FontWeight.w600),),
    ),
  );
}
EdgeInsets paddingWidth(width) => EdgeInsets.symmetric(horizontal: width);
EdgeInsets paddingWidthHeigth(width,height) => EdgeInsets.symmetric(horizontal: width,vertical: height);
SizedBox gapHeight(height) => SizedBox(height: height,);
SizedBox gapH(height) => SizedBox(height: height,);
SizedBox gapWidth(width) => SizedBox(width: width,);
SizedBox gapW(width) => SizedBox(width: width,);
Widget forwardBtn(tap) {
  return GestureDetector(
    onTap: tap,
    child: Container(
      width: 60.w,height: 60.h,
      decoration: BoxDecoration(
          color: AppColors.moneyTronicsBlue,
          borderRadius: BorderRadius.circular(20.h)
      ),
      child: Center(
        child: Image.asset("assets/icons/arrow_forward.png",
          width: 20.w,height: 20.h,fit: BoxFit.contain,
        ),
      ),
    ),
  );
}

EdgeInsets screenPadding() => EdgeInsets.symmetric(horizontal: 16.w);

BoxShadow cardShadow() {
  return BoxShadow(
    color: AppColors.black.withOpacity(0.10),
    spreadRadius: 0,
    blurRadius: 10,
    offset: const Offset(0, 4),
  );
}
GestureDetector pageButton(icon,{required String title,required Function()tap}) {
  return GestureDetector(onTap: tap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 15.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19.r),
          color: AppColors.white
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: 41.h,height:41.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: AppColors.moneyTronicsSkyBlue,
            ),
            child: Center(child:
            Image.asset(icon,
              width: 19.w,height: 19.h,
            ),),
          ),
          gapWidth(10.w),
          ctmTxtGroteskMid(title,AppColors.black1A,18.sp),
          const Spacer(),
          Image.asset("assets/icons/arrow_forward.png",
            width: 24.w,height: 24.h,color: AppColors.black0D,)
        ],),
    ),
  );
}
GestureDetector blueBtn({required String title, isEnabled, required Function()tap}) {
  return GestureDetector(
    onTap: tap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 60.h,width: 398.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color:  AppColors.moneyTronicsBlue
      ),
      child: Center(child: ctmTxtGroteskMid(title, AppColors.whiteF4, 18.sp),),
    ),
  );
}
Widget disabledBtn({required String title}) {
  return Container(
    height: 60.h,width: 398.w,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color:  AppColors.whiteCC
    ),
    child: Center(child: ctmTxtGroteskMid(title, AppColors.black6B, 18.sp),),
  );
}
Future<dynamic> openBottomSheet(BuildContext context,Widget bottomScreen, {bool? isDismissible}) {
  return showModalBottomSheet(
      isDismissible: isDismissible ?? true,
      isScrollControlled: true,
      context: context,
      backgroundColor: AppColors.white,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(12.r),topLeft: Radius.circular(12.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child:  bottomScreen,
      )
  );
}
Container appBarBackAndTxt({required String title,required Function backTap}) {
  return Container(
    padding:EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 15.h),
    decoration: const BoxDecoration(
      color: AppColors.white,
    ),
    child: Container(
      height: 56.h,
      decoration: const BoxDecoration(
        // border: Border.all(
        //   color: AppColors.grayEE,
        //   width: 1.r,
        // )
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          backArrow(backTap,),
          gapWidth(10.w),
          ctmTxtGroteskMid(title,AppColors.black33,18.sp),


        ],),
    ),
  );
}
Container appBarBackSignUp({required String title,required Function backTap,required String subText}) {
  return Container(
    padding:EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 15.h),
    decoration: const BoxDecoration(
      color: AppColors.white,
    ),
    child: Container(
      height: 149.h,
      decoration: const BoxDecoration(
        // border: Border.all(
        //   color: AppColors.grayEE,
        //   width: 1.r,
        // )
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(16),
          backArrow(backTap,),
          const Gap(20),
          ctmTxtGroteskMid(title,AppColors.black33,18.sp,weight: FontWeight.w700),
          Gap(8),
          ctmTxtGroteskMid(subText,AppColors.black1A,16.sp,maxLines: 3),



        ],),
    ),
  );
}
Container appBarBottomSheet({required String title,required Function backTap}) {
  return Container(
    width: double.infinity,height: 86.h,
    padding:EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 0.h),
    decoration: BoxDecoration(
      color: AppColors.white,
    ),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        backArrow(backTap,),
        gapWidth(10.w),
        ctmTxtGroteskMid(title,AppColors.black33,18.sp),

      ],),
  );
}
Container appBarTxtOnly({required String title,}) {
  return Container(
    padding:EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 15.h),
    decoration: BoxDecoration(
      color: AppColors.white,
    ),
    child: Container(
      height: 56.h,
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: AppColors.grayEE,
        //   width: 1.r,
        // )
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          gapWidth(20.w),
          ctmTxtGroteskMid(title,AppColors.black33,18.sp),


        ],),
    ),
  );
}
Container appBarBackAndImg({required String title,required Function backTap}) {
  return Container(
    padding:EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 15.h),
    decoration: const BoxDecoration(
      color: AppColors.white,
    ),
    child: Container(
      height: 90.h,
     // color: Colors.amber,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          backArrow(backTap,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Image.asset("assets/pictures/mfbLogo.png",
                width: 250.w,
                height: 96.h,)),
            ),
          ),
          gapWidth(24.0)

        ],),
    ),
  );
}
GestureDetector backArrow(tap) {
  return GestureDetector(onTap: tap,child: Image.asset("assets/icons/arrow_back.png",
    width: 24.w,height: 24.h,));
}

GestureDetector alreadyHaveAccount({required Function()tap}) {
  return GestureDetector(onTap: tap,
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ctmTxtGroteskMid(AppStrings.alreadyHaveAcctText,AppColors.black4D, 16.sp),
        ctmTxtGroteskMid(AppStrings.loginText,AppColors.moneyTronicsBlue, 16.sp)
      ],),
  );
}
GestureDetector doNotHaveAccount({required Function()tap}) {
  return GestureDetector(onTap: tap,
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ctmTxtGroteskMid(AppStrings.doNotHaveAcctText,AppColors.black4D, 16.sp),
        ctmTxtGroteskMid(AppStrings.signUpText,AppColors.moneyTronicsBlue, 16.sp)
      ],),
  );
}
Align forgotPassword({required Function()tap}) {
  return Align(alignment: Alignment.centerRight,
    child: GestureDetector(onTap: tap,
      child: ctmTxtGroteskMid(AppStrings.forgetPasswordText,AppColors.black,
          16.sp),
    ),);
}
AnnotatedRegion<SystemUiOverlayStyle> lightStatusBar(BuildContext context,widget) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value:const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness:  Brightness.light,
    ),
    child: widget,
  );
}
Column selectAccountColumn({required String title,required Widget pageView,required Widget pageIndicator,
double top=30.0, double bottom= 20.0}) {
  return Column(children: [
    Container(padding:EdgeInsets.only(left: 16.w,top: top.h,bottom: bottom.h),
        alignment: Alignment.centerLeft, child: ctmTxtGroteskMid(
            title, AppColors.black,18.sp)),
    pageView,
   gapHeight(20.h),
    pageIndicator

  ],);
}
Widget textFieldBorderWidget2(Widget widget, String title) {

  return Container(
    height: 57.h,
    width: double.infinity,
    child: InputDecorator(
      decoration: InputDecoration(

        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
        labelText: title,
        labelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: "HKGroteskMedium",
            fontSize: 15.sp),
        enabledBorder: OutlineInputBorder(
          gapPadding: 2,
          borderSide:  BorderSide(color: AppColors.moneyTronicsBlue,width: 0.5.h),
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      child: widget,
    ),
  );
}

ExpandingDotsEffect customIndicatorEffect() {
  return ExpandingDotsEffect(
    dotWidth: 25.w,
    dotHeight: 11.5.h,
    radius: 10.r,
    activeDotColor: AppColors.moneyTronicsSkyBlue,
    dotColor: AppColors.whiteE5,
    expansionFactor: 2,
  );
}