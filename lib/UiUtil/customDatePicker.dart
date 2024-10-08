import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../utils/constants/Themes/colors.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  TextEditingController dateControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 660.h,width: double.infinity,
      color:AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [

            SfDateRangePicker(
              // initialDisplayDate: DateTime.now(),
              selectionMode: DateRangePickerSelectionMode.single,
              view: DateRangePickerView.month,
              headerHeight: 58.h,
              headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: AppColors.moneyTronicsSkyBlue,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    color: AppColors.black09,
                    fontSize: 18.sp,
                    fontFamily: 'HKGroteskMedium',
                    fontWeight: FontWeight.w500,
                  )
              ),
              toggleDaySelection: false,
              showNavigationArrow: true,
              //showActionButtons: true,
              selectionColor: AppColors.moneyTronicsSkyBlue,
              todayHighlightColor: AppColors.black4D,
              selectionShape: DateRangePickerSelectionShape.rectangle,
              selectionRadius: 15.r,
              selectionTextStyle:TextStyle(
                color: AppColors.moneyTronicsBlue,
                fontSize: 20.sp,
                fontFamily: 'HKGroteskRegular',
                fontWeight: FontWeight.w800,
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                  cellDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: AppColors.whiteFA
                  ),
                  textStyle: TextStyle(
                    color: AppColors.black66,
                    fontSize: 16.sp,
                    fontFamily: 'HKGroteskRegular',
                    fontWeight: FontWeight.w400,
                  )
              ),
              yearCellStyle: DateRangePickerYearCellStyle(
                  cellDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: AppColors.whiteFA
                  ),
                  textStyle: TextStyle(
                    color: AppColors.black66,
                    fontSize: 16.sp,
                    fontFamily: 'HKGroteskRegular',
                    fontWeight: FontWeight.w400,
                  )
              ),
              monthViewSettings: DateRangePickerMonthViewSettings(
                  dayFormat: "EEE",
                  viewHeaderHeight: 60.h,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: TextStyle(
                        color: AppColors.black1A,
                        fontSize: 18.sp,
                        fontFamily: 'HKGroteskMedium',
                        fontWeight: FontWeight.w500,
                      )
                  )
              ),
              onSelectionChanged: (value){
                setState(() {
                  dateControl.text = value.value.toString().split(' ')[0];
                });
              },




              // viewSpacing: 1.h,


            ),

            dateTextField(dateControl.text),
            gapHeight(21.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: blueBtn(title: "Set date", tap: (){
              //  Navigator.pop(context,dateControl.text);
                Get.back(result: dateControl.text);
              }),
            ),
            gapHeight(25.h),
          ],
        ),
      ),
    );
  }

  Padding dateTextField(String date) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Stack(clipBehavior: Clip.none,
        children: [
          Container(
            height: 57.h,width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: AppColors.moneyTronicsSkyBlue,
                width: 0.5.h,
              ),
            ),
            // child: TextFormField(
            //   enabled: false,
            //   controller: dateControl,
            //   cursorHeight: 15.h,
            //   cursorColor:AppColors.moneyTronicsSkyBlue,
            //   style: TextStyle(
            //     color: AppColors.black, fontSize: 16.sp,
            //     fontFamily: 'HKGroteskMedium',
            //     fontWeight: FontWeight.w500,
            //   ),
            //   onChanged: (value){},
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.only(bottom: 10.h),
            //     border: InputBorder.none,
            //   ),
            //   // textInputAction: TextInputAction.done,
            // ),
            child: ctmTxtGroteskMid(date, AppColors.black, 14.sp),
          ),
          Positioned(
            left: 20.w,
            top: -10.h,
            child: Container(
              height: 19.h,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              color: AppColors.whiteFA, // Customize the background color of the label
              child: ctmTxtGroteskMid("Set date", AppColors.black33, 16.sp),
            ),
          )
        ],
      ),
    );
  }
}

