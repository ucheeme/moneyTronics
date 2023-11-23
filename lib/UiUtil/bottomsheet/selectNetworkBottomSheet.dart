


import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Utils/constants/Themes/colors.dart';
import '../../models/response/BillsResponse/NetworkPlansResponse.dart';
import '../customWidgets.dart';
import '../textWidgets.dart';

class SelectNetworkBottomSheet extends StatefulWidget {
  final String titleText;
  final List<SubscribedService> items;
  final double height;
  const SelectNetworkBottomSheet({super.key,
    required this.titleText, required this.items, required this.height});

  @override
  State<SelectNetworkBottomSheet> createState() => _SelectNetworkBottomSheetState();
}

class _SelectNetworkBottomSheetState extends State<SelectNetworkBottomSheet> {
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
