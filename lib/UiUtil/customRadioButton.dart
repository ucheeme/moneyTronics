import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';

class CustomRadioButton extends StatefulWidget {
  final String title;
  bool isActive= false;
   CustomRadioButton({super.key,required this.title, required this.isActive});

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
        Container(
        //margin: EdgeInsets.only(left: 0.w,right: 8.w),
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color:widget.isActive?AppColors.moneyTronicsBlue:
              AppColors.moneyTronicsSkyBlue,
              width: 0.3.h),
        ),
        child:Center(
          child: widget.isActive ?
          Container(
            width: 25.w,height: 25.h,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.moneyTronicsBlue
            ),
          ):Container(
            width: 22.w,height: 22.h,
            decoration: const BoxDecoration(
              color: AppColors.moneyTronicsSkyBlue,
              shape: BoxShape.circle
            ),
          ),
        ),
      ),
          const Gap(10),
          ctmTxtGroteskMid(widget.title,AppColors.black1A,14.sp,)
        ],
      );
  }
}
