import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';

import '../../utils/constants/Themes/colors.dart';
import '../searchTextField.dart';
import '../textWidgets.dart';

class SelectBankBottomSheet extends StatefulWidget {
  const SelectBankBottomSheet({super.key});

  @override
  State<SelectBankBottomSheet> createState() => _SelectBankBottomSheetState();
}

class _SelectBankBottomSheetState extends State<SelectBankBottomSheet> {
  TextEditingController searchControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ FocusManager.instance.primaryFocus?.unfocus();},
      child: Container(
        width: double.infinity,height: 742.h,
        color: AppColors.white,
        // padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 16.h),
        child: Column(
          children: [
            (MediaQuery.of(context).viewInsets.bottom != 0)?
            gapHeight(30.h):gapHeight(10.h),
            Container(
              width: double.infinity,height: 100.h,
              padding: EdgeInsets.fromLTRB(16.w, 30.h,16.w,15.h),
              color: AppColors.white,
              child: SearchTextField(
                  labelText: "Search bank",
                  inputType: TextInputType.text,
                  controller: searchControl,
                  onChange: (val){}),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return iconAndTextWidget("assets/icons/sterling_bank.png",
                        "title",(){
                          Navigator.pop(context, "First Bank");
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

  Widget iconAndTextWidget(image,title,tap) {
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
            Container(
              width: 40.w,height: 40.h,
              decoration: BoxDecoration(
                color: AppColors.white,borderRadius: BorderRadius.circular(9.r),
              ),
              child: Center(child: Image.asset(image,
                width: 34.w,height: 34.h,
              ),
              ),
            ),
            gapWidth(15.w),
            SizedBox(width: 200.w,
                child: ctmTxtGroteskMid(title,AppColors.black,18.sp,maxLines: 1))
          ],),
      ),
    );
  }
}
