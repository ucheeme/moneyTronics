
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../utils/constants/Themes/colors.dart';

class ProtectAccountScreen extends StatelessWidget {
  final Function() proceedTap;
  final String title;
  final String body;
  const ProtectAccountScreen({required this.proceedTap, required this.title, required this.body, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,height: 460.h,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/png/icons/secured.png",
            width: 200.w,height: 200.h,fit: BoxFit.contain,
          ),
          ctmTxtGroteskMid(title, AppColors.black, 24.sp),
          gapHeight(15.h),
          SizedBox(width: 306.w,
            child: ctmTxtGroteskMid(body,
                AppColors.black33, 16.sp,maxLines: 2,textAlign: TextAlign.center),
          ),
          gapHeight(40.h),
          blueBtn(title: "Proceed", tap:proceedTap),
          gapHeight(40.h),
        ],
      ),
    );
  }
}
