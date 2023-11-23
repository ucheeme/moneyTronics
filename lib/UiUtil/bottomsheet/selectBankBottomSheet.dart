import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moneytronic/UiUtil/customWidgets.dart';

import '../../models/response/Bank.dart';
import '../../utils/constants/Themes/colors.dart';
import '../searchTextField.dart';
import '../textWidgets.dart';

class SelectBankBottomSheet extends StatefulWidget {
  final List<Bank> banks;
  const SelectBankBottomSheet({required this.banks, super.key});

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
        child: Column(
          children: [
            (MediaQuery.of(context).viewInsets.bottom != 0)?
            gapH(30.h):gapH(10.h),
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
                  itemCount: widget.banks.length,
                  itemBuilder: (context, index) {
                    return iconAndTextWidget(
                        widget.banks[index].bankname ?? "",(){
                      Navigator.pop(context,  widget.banks[index]);
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

  Widget iconAndTextWidget(String title,tap) {
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
              width: 34.w,height: 32.h,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.green24
              ),
              child: Center(child: ctmTxtGroteskMid(title[0].toUpperCase(),AppColors.white,12.5.sp),),
            ),
            gapW(15.w),
            SizedBox(width: 200.w,
                child: ctmTxtGroteskMid(title,AppColors.black,18.sp,maxLines: 1))
          ],),
      ),
    );
  }
}
