import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';

class BalanceWidget extends StatefulWidget {
  final String balance;
  const BalanceWidget({
    super.key, required this.balance,
  });

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
      height: 102.h,width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.moneyTronicsSkyBlue
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ctmTxtGroteskReg("Available balance",AppColors.black4D,16.sp),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nairaSign(obscure? "NGN *****":widget.balance,28.sp,colors:AppColors.primary),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                  child: Image.asset(obscure?"assets/png/icons/eye.png":"assets/png/icons/eye_slash.png"
                    ,width: 24.w,height: 24.h,)
              )

            ],)
        ],),
    );
  }
}