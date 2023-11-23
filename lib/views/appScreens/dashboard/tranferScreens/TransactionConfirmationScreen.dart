import 'dart:io';
import 'dart:typed_data';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_line/dotted_line.dart';

import '../../../../UiUtil/customWidgets.dart';
import '../../../../UiUtil/textWidgets.dart';
import '../../../../models/requests/TransferRequest.dart';
import '../../../../utils/appUtil.dart';
import '../../../../utils/constants/Themes/colors.dart';



class TransferConfirmationScreen extends StatelessWidget {
  final GlobalKey _globalKey =  GlobalKey();
  TransferRequest response;
  TransferConfirmationScreen({required this.response, Key? key}) : super(key: key);
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
                      color: AppColors.moneyTronicsSkyBlue,
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
                              ctmTxtGroteskMid("Fund transfer",
                                  AppColors.black33, 18.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w600),
                            ],
                          ),
                        ],),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: Column(
                        children: [
                          ctmTxtGroteskMid("Transaction amount",
                              AppColors.black66, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600),
                          gapH(10.0),
                          ctmTxtGroteskMid(getAmount(),
                              AppColors.moneyTronicsBlue, 22.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.bold),
                        ],
                      )
                    ),
                    Column(
                      children: [
                        Container(
                          height: 80.0,
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Receiver details",
                                  AppColors.black66, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600) ,
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ctmTxtGroteskMid(response.creditAcctName,
                                      AppColors.black33, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w700),
                                  ctmTxtGroteskMid("${response.benificiaryBank} | ${response.creditAcct}",
                                      AppColors.black66, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w400),
                                ],
                              ),
                            ],),
                        ),
                        dottedLine(),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60.0,
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Sending account",
                                  AppColors.black66, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600) ,
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(

                                    child: ctmTxtGroteskMid(response.debitAcct,
                                        AppColors.black33, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w700),
                                  ),
                               ],
                              ),
                            ],),
                        ),
                        dottedLine(),
                      ],
                    ),

                    Column(
                      children: [
                        Container(
                          height: 60.0,
                          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Description",
                                  AppColors.black66, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600) ,
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: ctmTxtGroteskMid(response.narration1,
                                        AppColors.black33, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w700),
                                  ),],
                              ),
                            ],),
                        ),
                        dottedLine(),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 60.0,
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctmTxtGroteskMid("Transaction type",
                                  AppColors.black66, 18.sp,maxLines: 1,textAlign: TextAlign.start, weight: FontWeight.w600) ,
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ctmTxtGroteskMid(isDebit ? "Debit" : "Credit",
                                      isDebit ? AppColors.red00 : AppColors.moneyTronicsBlue, 16.sp,maxLines: 1,textAlign: TextAlign.end, weight: FontWeight.w700),],
                              ),
                            ],),
                        ),
                        dottedLine(),
                      ],
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
                    openPinScreen(context, (pin) {
                      response.transactionPin = pin;
                      Navigator.pop(context, response);
                    });
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
  String getAmount(){
    return  "NGN ${currencyFormatter.format(response.payamount)}";
  }
}
