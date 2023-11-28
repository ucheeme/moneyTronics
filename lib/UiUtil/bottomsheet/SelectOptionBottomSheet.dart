import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



import '../../utils/constants/Themes/colors.dart';
import '../customWidgets.dart';
import '../textWidgets.dart';



class SelectOptionBottomSheet extends StatefulWidget {
  final double height;
  final String title;
  final List<String> items;
  const SelectOptionBottomSheet({super.key, required this.items, required this.title, required this.height});

  @override
  State<SelectOptionBottomSheet> createState() => _SelectOptionBottomSheetState();
}

class _SelectOptionBottomSheetState extends State<SelectOptionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,height: widget.height,
      color: AppColors.white,
      // padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h),
      child: Column(
        children: [
          appBarBottomSheet(title: widget.title,
              backTap: (){Navigator.pop(context);}),
          Expanded(
            child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return listWidget(
                      widget.items[index],(){
                    Navigator.pop(context, widget.items[index]);
                  });
                }
            ),
          ),
          gapH(22.h),
        ],
      ),
    );
  }
  Widget listWidget(title,tap) {
    return GestureDetector(onTap: tap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 7.5.h),
        //width: 398.w,height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
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
