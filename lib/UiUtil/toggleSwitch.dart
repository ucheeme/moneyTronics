


import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants/Themes/colors.dart';

class CustomToggleSwitch extends StatefulWidget {
 final bool value;
  const CustomToggleSwitch({super.key, required this.value});

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 30.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.20)
          ),
          BoxShadow(
            color: widget.value ?AppColors.moneyTronicsBlue: AppColors.moneyTronicsSkyBlue,
            spreadRadius: 0.0,
            blurRadius: 1.4.r,
            offset: const Offset(0.0, 0.0), // shadow direction: bottom right
          )
        ],
        //color: widget.value ?AppColors.green2B: AppColors.greenEB,
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        alignment: widget.value ? Alignment.centerRight: Alignment.centerLeft,
        child: Container(
          width: 16.2.w,
          height: 16.2.h,
          margin: EdgeInsets.all(7.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.value ? AppColors.moneyTronicsSkyBlue:AppColors.moneyTronicsBlue,
          ),
        ),
      ),
    );
  }
}
