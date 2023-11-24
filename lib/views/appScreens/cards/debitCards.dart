import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../UiUtil/customWidgets.dart';
import '../../../UiUtil/infos.dart';
import '../../../UiUtil/textWidgets.dart';
import '../../../UiUtil/toggleSwitch.dart';
import '../../../Utils/constants/Themes/colors.dart';
import '../../../bloc/TransactionBloc/transaction_bloc.dart';
import '../../../models/response/BeneficiaryResponse.dart';
import '../dashboard/Beneficiary/BeneficiaryScreen.dart';
import '../dashboard/dashboard.dart';

class DebitCard extends StatefulWidget {
  const DebitCard({super.key});

  @override
  State<DebitCard> createState() => _DebitCardState();
}

class _DebitCardState extends State<DebitCard> {
  final PageController _sendingAccPageController = PageController();
  bool saveBeneficiary = false;
  late TransactionBloc bloc;
  var recipientName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView( keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(children: [
                selectAccountColumn(
                    title: "",
                    top: 4.0,
                    bottom: 0.0,
                    pageView: SizedBox(width: double.infinity,height: 100.h,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _sendingAccPageController,
                        onPageChanged: (int page) {
                          bloc.formValidation.setSelectedAccount(userAccounts![page]);
                        },
                        itemCount: accountWidget().length,
                        itemBuilder: (context, index) {
                          return accountWidget()[index];
                        },
                      ),
                    ),
                    pageIndicator: SmoothPageIndicator(
                      controller: _sendingAccPageController,
                      count: accountWidget().length,
                      effect: customIndicatorEffect(),
                    )
                ),
                const Gap(49),
               Container(
                   padding: EdgeInsets.symmetric(horizontal: 16.w,),
                   child: Image.asset("assets/icons/cardAtm.png")),
                gapHeight(63.98.h),
                Container(alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ctmTxtGroteskMid("Card management",AppColors.black,18.sp),
                      gapH(33.h),
                      Container(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                          children: [
                            ctmTxtGroteskMid("Block card", AppColors.black, 16.sp),
                            GestureDetector(onTap: (){
                              setState(() {
                                saveBeneficiary = !saveBeneficiary;
                              });
                            },
                               child: CustomToggleSwitch(value: saveBeneficiary,)),
                          ],
                        ),
                     ),
                      gapHeight(30.h),
                      Container(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                          children: [
                            ctmTxtGroteskMid("Change pin", AppColors.black, 16.sp),
                            GestureDetector(onTap: (){
                              setState(() {
                                saveBeneficiary = !saveBeneficiary;
                              });
                            },
                                child: const Icon(Icons.arrow_forward)),
                          ],
                        ),
                      )
                      
                    ],
                  ),
                ),

              ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
