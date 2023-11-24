import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/textWidgets.dart';

import '../Utils/constants/Themes/colors.dart';
import '../models/response/BeneficiaryResponse.dart';
import '../views/appScreens/dashboard/billPaymentScreens/BillPaymentScreen.dart';

class QuickTransferDesign extends StatelessWidget {
  Beneficiary beneficiary;
   QuickTransferDesign({super.key, required this.beneficiary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
      height: 56.h,width: 260.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.whiteFA
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
      iconAndTextWidget(
      beneficiary.beneficiaryBank,(){
      },"",""),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ctmTxtGroteskMid(
                  beneficiary.accountholderFullname,AppColors.black4D,16.sp,),
              SizedBox(
                height: 17.h,
                width: 175.w,
                child: Row(
                  children: [
                    ctmTxtGroteskMid(
                      beneficiary.accountholderFullname,AppColors.black4D,14.sp,),
                    Container(
                      height: 5.h,
                      width: 5.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.moneyTronicsBlue
                      ),
                    ),
                    ctmTxtGroteskMid(
                      beneficiary.beneficiaryAccount,AppColors.black4D,14.sp,),
                  ],
                ),
              )
            ],),
        ],
      ),
    );
  }
}
