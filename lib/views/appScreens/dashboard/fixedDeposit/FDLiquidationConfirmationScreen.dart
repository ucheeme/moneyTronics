import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/textWidgets.dart';
import '../../../../models/response/FdLiquidationSummaryResponse.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Themes/colors.dart';

class FDLiquidationConfirmationScreen extends StatelessWidget {
  final GlobalKey _globalKey =  GlobalKey();
  FixedDepositSummaryResponse response;
  FDLiquidationConfirmationScreen({required this.response, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var isDebit = true;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RepaintBoundary(
                key: _globalKey,
                child: Column(
                  children: [
                    Container(
                      color: AppColors.accent,
                      height: 80.0,
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("MoneyTronics MFB",
                                  AppColors.black33, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.bold),
                              ctmTxtGroteskMid("Microfinance bank",
                                  AppColors.black33, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600),
                            ],
                          ) ,
                          const Spacer(),
                          Column(
                            children: [
                              ctmTxtGroteskMid("",
                                  AppColors.black33, 18.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w600),
                              ctmTxtGroteskMid("Fixed Deposit liquidation",
                                  AppColors.black33, 18.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w600),
                            ],
                          ),
                        ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 30.0),
                              child: Row(
                                children: [
                                  ctmTxtGroteskMid("Investment amount",
                                      AppColors.black66, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600),
                                  Spacer(),
                                  ctmTxtGroteskMid(getAmount(response.investmentAmount),
                                      AppColors.primary, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.bold),
                                ],
                              )
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 30.0),
                              child: Row(
                                children: [
                                  ctmTxtGroteskMid("Interest accrued",
                                      AppColors.black66, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600),
                                  Spacer(),
                                  ctmTxtGroteskMid(getAmount(response.interestAccrued),
                                      AppColors.primary, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.bold),
                                ],
                              )
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 30.0),
                              child: Row(
                                children: [
                                  ctmTxtGroteskMid("Penal charge",
                                      AppColors.black66, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600),
                                  Spacer(),
                                  ctmTxtGroteskMid(getAmount(response.penalCharge),
                                      AppColors.primary, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.bold),
                                ],
                              )
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 30.0),
                              child: Row(
                                children: [
                                  ctmTxtGroteskMid("Tax amount",
                                      AppColors.black66, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600),
                                  Spacer(),
                                  ctmTxtGroteskMid(getAmount(response.taxAmount),
                                      AppColors.primary, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.bold),
                                ],
                              )
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 30.0),
                              child: Row(
                                children: [
                                  ctmTxtGroteskMid("Investment date",
                                      AppColors.black66, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600),
                                  Spacer(),
                                  ctmTxtGroteskMid(response.startDate,
                                      AppColors.primary, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.bold),
                                ],
                              )
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 30.0),
                              child: Row(
                                children: [
                                  ctmTxtGroteskMid("Amount due",
                                      AppColors.black66, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600),
                                  Spacer(),
                                  ctmTxtGroteskMid(getAmount(response.amountDue),
                                      AppColors.primary, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.bold),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                    gapH(10.0),
                  ],
                ),
              ),
              gapH(20.0),
              blueBtn(
                  title: 'Proceed',
                  isEnabled: true,
                  tap: () {
                    Navigator.pop(context, true);
                  })
            ],
          ),
        ),
      ),
    );
  }
  Widget dottedLine(){
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 1.0.h,
        dashLength: 5.0.w,
        dashColor: AppColors.black66.withOpacity(0.50),
      ),
    );
  }
  String getAmount(amount){
    return  "NGN ${currencyFormatter.format(double.parse(amount))}";
  }
}
