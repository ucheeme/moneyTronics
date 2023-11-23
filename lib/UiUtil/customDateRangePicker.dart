
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../utils/appUtil.dart';
import '../utils/constants/Themes/colors.dart';
import 'customWidgets.dart';

class CustomDateRangePicker extends StatefulWidget {
  const CustomDateRangePicker({super.key});

  @override
  State<CustomDateRangePicker> createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  TextEditingController startDateControl = TextEditingController();
  TextEditingController endDateControl = TextEditingController();

  void _handleDateRangeChanged(args) {
    setState(() {
      DateTime? startDate = args.value.startDate;
      DateTime? endDate = args.value.endDate;
      DateTime today =    DateTime.now();
      if (today.compareTo(endDate ?? today) == -1){
        AppUtils.showSnack("Maximum end date should be today's date", context);
        startDateControl.text = "";
        endDateControl.text = "";
        return;
      }
      startDateControl.text =
          DateFormat('dd-MM-yyyy').format(startDate!);
      endDateControl.text =
          DateFormat('dd-MM-yyyy').format(endDate!);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 660.h,width: double.infinity,
      color:AppColors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
            child: SfDateRangePicker(
              // initialDisplayDate: DateTime.now(),
              selectionMode: DateRangePickerSelectionMode.extendableRange,
              view: DateRangePickerView.month,
              headerHeight: 58.h,
              headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: AppColors.greenEB,
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
              selectionColor: AppColors.moneyTronicsBlue,
              todayHighlightColor: AppColors.black4D,
              rangeSelectionColor: AppColors.moneyTronicsSkyBlue.withOpacity(0.50),

              selectionShape: DateRangePickerSelectionShape.rectangle,
              startRangeSelectionColor: AppColors.moneyTronicsBlue.withOpacity(0.50),

              endRangeSelectionColor: Colors.red.withOpacity(0.50),
              //selectionRadius: 15.r,
              selectionTextStyle:TextStyle(
                color: AppColors.white,
                fontSize: 18.sp,
                fontFamily: 'HKGroteskRegular',
                fontWeight: FontWeight.w600,
              ),

              // cellBuilder: (BuildContext context, DateRangePickerCellDetails details) {
              //   return Container(
              //     width: 44.w,height:44.w,
              //     margin: EdgeInsets.all(6.w),
              //     alignment: Alignment.center,
              //     // decoration: BoxDecoration(
              //     //     borderRadius: BorderRadius.circular(15.r),
              //     //     color: AppColors.whiteFA
              //     // ),
              //     child: Text(
              //       '${details.date.day}', // Use details.date to get the day
              //       style: TextStyle(
              //         color: isToday(details.date) ? Colors.green : Colors.black,
              //         fontFamily: 'HKGroteskRegular',
              //         fontWeight: FontWeight.w500,
              //         // Add other styling properties as needed
              //       ),
              //     ),
              //   );
              // },

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
                  ),

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
                  showWeekNumber: false,
                  dayFormat: "EEE",
                  viewHeaderHeight: 60.h,
                  showTrailingAndLeadingDates: false,
                  viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      textStyle: TextStyle(
                        color: AppColors.black1A,
                        fontSize: 18.sp,
                        fontFamily: 'HKGroteskMedium',
                        fontWeight: FontWeight.w500,
                      )
                  )
              ),
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args){

                if(args.value.startDate != null &&args.value.endDate != null){
                  _handleDateRangeChanged(args);
                }
              },




              // viewSpacing: 1.h,


            ),
          ),


          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SetDateTextFieldWidget(dateControl:startDateControl, title: 'Start date',),
              gapW(21.w),
              SetDateTextFieldWidget(dateControl:endDateControl, title: 'End date',)
            ],
          ),
          gapH(21.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: blueBtn(title: "Proceed", tap: (){
              if(startDateControl.text.isNotEmpty && endDateControl.text.isNotEmpty){
                StartDateEndDate startAndEndDate = StartDateEndDate(
                    startDate: startDateControl.text,
                    endDate: endDateControl.text );
                Navigator.pop(context,startAndEndDate);
              }
             // return date range
            }),
          ),
          gapH(25.h),
        ],
      ),
    );
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

}


class SetDateTextFieldWidget extends StatelessWidget {
  final String title;
  const SetDateTextFieldWidget({
    super.key,
    required this.dateControl,required this.title
  });

  final TextEditingController dateControl;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none,
      children: [
        Container(
          height: 57.h,width: 180.w,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: AppColors.green0C,
              width: 0.5.h,
            ),
          ),
          child: TextFormField(
            enabled: false,
            controller: dateControl,
            cursorHeight: 15.h,
            cursorColor:AppColors.moneyTronicsBlue,
            style: TextStyle(
              color: AppColors.black, fontSize: 16.sp,
              fontFamily: 'HKGroteskMedium',
              fontWeight: FontWeight.w500,
            ),
            onChanged: (value){},
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 10.h),
              border: InputBorder.none,
            ),
            // textInputAction: TextInputAction.done,
          ),
        ),
        Positioned(
          left: 20.w,
          top: -10.h,
          child: Container(
            height: 19.h,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            color: AppColors.whiteFA, // Customize the background color of the label
            child: ctmTxtGroteskMid(title, AppColors.black33, 16.sp),
          ),
        )
      ],
    );
  }
}
class StartDateEndDate {
  String startDate;
  String endDate;

  StartDateEndDate({
    required this.startDate,
    required this.endDate,
  });
}
