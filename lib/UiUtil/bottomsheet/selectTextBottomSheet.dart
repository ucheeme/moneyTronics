import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/response/BillsResponse/BillerGroupsDetailsResponse.dart';
import '../../models/response/BillsResponse/BillerPackageResponse.dart';
import '../../utils/constants/Themes/colors.dart';
import '../customWidgets.dart';
import '../textWidgets.dart';

class SelectionModal{
  String title;
  String id;

  SelectionModal({required this.title, required this.id, });
}

class SelectTextBottomSheet extends StatefulWidget {
  final String titleText;
  final List<SelectionModal> items;
  final double height;
  const SelectTextBottomSheet({super.key, required this.titleText, required this.items, required this.height});

  @override
  State<SelectTextBottomSheet> createState() => _SelectTextBottomSheetState();
}

class _SelectTextBottomSheetState extends State<SelectTextBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ FocusManager.instance.primaryFocus?.unfocus();},
      child: Container(
        width: double.infinity,height: 402.h,
        color: AppColors.white,
        // padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h),
        child: Column(
          children: [
            appBarBottomSheet(title: widget.titleText,
                backTap: (){Navigator.pop(context);}),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return listWidget(
                        widget.items[index].title,(){
                      Navigator.pop(context, widget.items[index]);
                    });
                  }
              ),
            ),
            gapHeight(22.h),
          ],
        ),
      ),
    );
  }

  Widget listWidget(title,tap) {
    return GestureDetector(onTap: tap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.5.h),
        width: 398.w,height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: AppColors.whiteFA,borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            SizedBox(width: 300.w,
                child: ctmTxtGroteskMid(title,AppColors.black,18.sp,maxLines: 1))
          ],),
      ),
    );
  }
}

class SelectBillGategoryBottomSheet extends StatefulWidget {
  final String titleText;
  final List<BillerGroupsDetailsResponse> items;
  final double height;
  const SelectBillGategoryBottomSheet({super.key, required this.titleText, required this.items, required this.height});

  @override
  State<SelectBillGategoryBottomSheet> createState() => _SelectBillGategoryBottomSheetState();
}

class _SelectBillGategoryBottomSheetState extends State<SelectBillGategoryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ FocusManager.instance.primaryFocus?.unfocus();},
      child: Container(
        width: double.infinity,height: widget.height,
        color: AppColors.white,
        // padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h),
        child: Column(
          children: [
            appBarBottomSheet(title: widget.titleText,
                backTap: (){Navigator.pop(context);}),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return listWidget(
                        widget.items[index].name,(){
                      Navigator.pop(context, widget.items[index]);
                    });
                  }
              ),
            ),
            gapH(22.h),
          ],
        ),
      ),
    );
  }

  Widget listWidget(title,tap) {
    return GestureDetector(onTap: tap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.5.h),
        width: 398.w,height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: AppColors.whiteFA,borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            SizedBox(width: 300.w,
                child: ctmTxtGroteskMid(title,AppColors.black,18.sp,maxLines: 1))
          ],),
      ),
    );
  }
}


class SelectBillPackageBottomSheet extends StatefulWidget {
  final String titleText;
  final List<BillerPackageResponse> items;
  final double height;
  const SelectBillPackageBottomSheet({super.key, required this.titleText, required this.items, required this.height});

  @override
  State<SelectBillPackageBottomSheet> createState() => _SelectBillPackageBottomSheetState();
}

class _SelectBillPackageBottomSheetState extends State<SelectBillPackageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ FocusManager.instance.primaryFocus?.unfocus();},
      child: Container(
        width: double.infinity,height: widget.height,
        color: AppColors.white,
        // padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h),
        child: Column(
          children: [
            appBarBottomSheet(title: widget.titleText,
                backTap: (){Navigator.pop(context);}),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return listWidgetAndAmount(
                        widget.items[index].name,
                        widget.items[index].amount.toString(),
                            (){
                          Navigator.pop(context, widget.items[index]);
                        });
                  }
              ),
            ),
            gapH(22.h),
          ],
        ),
      ),
    );
  }
}
Widget listWidgetAndAmount(title,amount,tap) {
  return GestureDetector(onTap: tap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.5.h),
      width: 398.w,height: 80.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      decoration: BoxDecoration(
        color: AppColors.whiteFA,borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(width: 300.w,
                  child: ctmTxtGroteskMid(title,AppColors.black,18.sp,maxLines: 1))
            ],),
          gapH(5.h),
          ctmTxtGroteskMid(amount,AppColors.black,15.sp,maxLines: 1,weight:FontWeight.w800)

        ],
      ),
    ),
  );
}
